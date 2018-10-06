(function (window, document, PRO) {
  const Pro = PRO()
  const PROdata = Pro.data

  const PROlightBox = (function () {
    const NAME = 'lightbox'
    const VERSION = '0.0.1'

    const DATA_KEY = 'lightbox'
    const EVENT_KEY = `${DATA_KEY}.`

    const Events = {
      'OPEN': `${EVENT_KEY}open`,
      'CLOSE': `${EVENT_KEY}close`
    }

    const Default = {
      attribute: 'light',
      padding: 0,
      delayShow: 250,
      delayHide: 250,
      delayStep: 250,
      onerror: "data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512' fill='%23c33' enable-background='new 0 0 512 512'%3E%3Cpath d='m256 96q44 0 80 21 37 21 58 58 21 37 21 80t-21 80q-21 37-58 58-37 21-80 21t-80-21q-37-21-58-58-21-37-21-80t21-80q21-37 58-58 37-21 80-21zm27 261v-40q0-3-2-5-2-2-5-2h-40q-3 0-5 2-2 2-2 5v40q0 3 2 5 2 2 5 2h40q3 0 5-2 2-2 2-5zm-0.4-72 4-130q0-3-2-4-2-2-5-2h-46q-3 0-5 2-2 1-2 4l4 130q0 2 2 4 2 2 5 2h39q3 0 5-2 2-2 2-4z'/%3E%3C/svg%3E"
    }

    class PROlightBox {
      static on (event, handler) {
        document.addEventListener(Events[event.toUpperCase()], handler)
        return this
      }

      static get name () {
        return NAME
      }

      static get version () {
        return VERSION
      }

      static get default () {
        return Default
      }

      static _init (instance) {
        if (!this._overlay) {
          this._events = {}
          for (let event in Events) {
            this._events[event] = Pro.newEvent(Events[event])
          }
          this._overlay = Pro.tag('div')
            .addClass(`${this._dataKey}-overlay`)
            .hide()
          this._content = Pro.tag('div')
            .addClass(`${this._dataKey}-content`)
            .onclick(event => event.stopPropagation())
          this._modal = Pro.tag('div')
            .addClass(`${this._dataKey}-modal`)
            .hide()
          this._image = Pro.tag('img')
            .addClass(`${this._dataKey}-image`)
            .hide()
          this._next = Pro.tag('div')
            .addClass(`${this._dataKey}-next`)
            .hide()
          this._prev = Pro.tag('div')
            .addClass(`${this._dataKey}-prev`)
            .hide()
          this._close = Pro.tag('div')
            .addClass(`${this._dataKey}-close`)
          this._content.append(this._modal)
          this._content.append(this._image)
          this._content.append(this._next)
          this._content.append(this._prev)
          this._content.append(this._close)
          this._overlay.append(this._content)
        }
        this._body = PRO(document.body)
        if (!this._overlay.isConnected) {
          this._body.append(this._overlay)
        }
        this._content.style({ padding: instance._options.padding ? `${instance._options.padding}px` : '' })
        this._overlay
          .off('click')
          .onclick(() => instance._hide())
        this._next
          .off('click')
          .onclick(() => instance._step(true))
        this._prev
          .off('click')
          .onclick(() => instance._step())
        this._close
          .off('click')
          .onclick(() => instance._hide())
        return instance
      }

      static _show (delay, step) {
        this._loading(true)
        if (step) {
          this._content.show(delay)
        } else {
          this._body.style({
            paddingRight: `${window.innerWidth - this._body.innerWidth()}px`,
            overflow: 'hidden'
          })
          this._overlay.show(delay)
          document.dispatchEvent(this._events.OPEN)
        }
      }

      static _hide (delay, callback) {
        if (callback) {
          this._content.hide(delay, callback)
        } else {
          this._overlay.hide(delay, () => {
            this._body.style({
              paddingRight: '',
              overflow: ''
            })
            document.dispatchEvent(this._events.CLOSE)
          })
        }
      }

      static _loading (done) {
        if (done) {
          this._overlay.removeClass(`${this._dataKey}-overlay--load`)
        } else {
          this._overlay.addClass(`${this._dataKey}-overlay--load`)
        }
      }

      static get _dataKey () {
        return PROdata.toKey(DATA_KEY)
      }

      constructor (options) {
        this._options = Pro.assign({}, Default, options)
        this._stack = {}
        // this._group = this._path = null
        PROlightBox._init(this)
      }

      load (element) {
        const path = element.dataset[PROdata.toSet(this._options.attribute, 'href')] || element.dataset.href ||
          element.getAttribute('href') || element.getAttribute('src')
        if (path) {
          const group = (path[0] === '#') ? 'html' : PROdata.getSet(element, this._options.attribute)
          if (group && group !== 'html') {
            if (!this._stack[group]) {
              this._stack[group] = []
            }
            if (this._stack[group].indexOf(path) === -1) {
              this._stack[group].push(path)
            }
          }
          PRO(element).onclick(event => {
            event.preventDefault()
            event.stopPropagation()
            this._path = path
            this._group = group
            if (this._group === 'html') {
              this._html()
            } else {
              this._draw()
            }
          })
          element.style.cursor = 'pointer'
        }
        PROdata.setSet(element, DATA_KEY, 'loaded')
      }

      _html () {
        PROlightBox._image.hide()
        PROlightBox._next.hide()
        PROlightBox._prev.hide()
        const element = PRO(this._path).first
        if (element) {
          PROlightBox._content.addClass(`${PROlightBox._dataKey}-content--html`)
          PROlightBox._modal
            .html(element.innerHTML)
            .show()
          this._show()
        }
      }

      _draw (step) {
        PROlightBox._modal.hide()
        PROlightBox._content.removeClass(`${PROlightBox._dataKey}-content--html`)
        if (this._group && this._stack[this._group].length > 1) {
          PROlightBox._next.show()
          PROlightBox._prev.show()
        } else {
          PROlightBox._next.hide()
          PROlightBox._prev.hide()
        }
        const element = PROlightBox._image.first
        element.src = this._path
        if (element.complete) {
          this._show(step)
        } else {
          PROlightBox._loading()
          element.onerror = () => {
            element.src = this._options.onerror
            if (this._group) {
              this._stack[this._group][this._index] = this._options.onerror
            }
          }
          element.onload = () => this._show(step)
        }
        PROlightBox._image.show()
      }

      _show (step) {
        PROlightBox._show(this._options.delayShow, step)
      }

      _hide (callback) {
        if (callback) {
          PROlightBox._hide(this._options.delayStep, callback)
        } else {
          PROlightBox._hide(this._options.delayHide)
        }
      }

      _step (next) {
        let index = this._index
        if (next) {
          if (index < this._stack[this._group].length - 1) {
            ++index
          } else {
            index = 0
          }
        } else {
          if (index > 0) {
            --index
          } else {
            index = this._stack[this._group].length - 1
          }
        }
        this._path = this._stack[this._group][index]
        this._hide(() => this._draw(true))
      }

      get _index () {
        return this._group && this._stack[this._group].indexOf(this._path)
      }
    }

    return PROlightBox
  })()

  Pro.LightBox = PROlightBox

  Pro.prototype[PROlightBox.name] = function () {
    const instance = new PROlightBox(...arguments)
    return this.each(el => instance.load(el))
  }

  Pro[PROlightBox.name] = function () {
    new Pro(`[data-${PROdata.toKey(PROlightBox.default.attribute)}]`)[PROlightBox.name](...arguments)
    return this
  }
})(window, document, PRO)
