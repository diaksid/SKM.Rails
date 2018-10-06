(function (PRO) {
  const Pro = PRO()

  const PROstyle = function (el, data) {
    if (typeof data === 'object') {
      for (let key in data) {
        el.style[key] = data[key]
      }
      return this
    } else {
      const style = el.ownerDocument.defaultView.opener
        ? el.ownerDocument.defaultView.getComputedStyle(el, null)
        : window.getComputedStyle(el, null)
      return (typeof data === 'string') ? style[data] : style
    }
  }

  Pro.style = PROstyle

  Pro.assign({
    html (value = null) {
      if (value !== null) {
        return this.each(el => {
          el.innerHTML = value
        })
      }
      return this.length && this.first.innerHTML
    },

    style (data) {
      if (typeof data === 'object') {
        return this.each(el => PROstyle(el, data))
      }
      return this.length && PROstyle(this.first.style, data)
    },

    addClass (...args) {
      return this.each(el => {
        for (let arg of args) {
          el.classList.add(arg)
        }
      })
    },

    removeClass (...args) {
      return this.each(el => {
        for (let arg of args) {
          el.classList.remove(arg)
        }
      })
    },

    append (child) {
      if (child && this.length) {
        Pro.to(child).each(el => {
          this.first.appendChild(el)
        })
      }
      return this
    }
  }, true)
})(PRO)
