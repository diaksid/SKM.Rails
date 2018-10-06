(function (window, document, documentElement, PRO) {
  const Pro = PRO()

  Pro.assign({
    scrollTo: function (x, y, options, callback) {
      if (typeof options === 'function') {
        callback = options
        options = null
      }
      options = Object.assign({ duration: Pro.animation.duration }, options)
      let steps = options.duration / Pro.animation.delay
      let stepX = ((window.pageXOffset || documentElement.scrollLeft) - x) / steps
      let stepY = ((window.pageYOffset || documentElement.scrollTop) - y) / steps
      let render = () => {
        window.scrollBy(-stepX, -stepY)
        if (--steps) {
          Pro.animation.request(render, window)
        } else {
          window.scrollTo(x, y)
          if (typeof callback === 'function') {
            callback.call(window)
          }
        }
      }
      if (stepX || stepY) {
        steps = Math.round(steps)
        render()
      }
      return this
    },

    totop: function (options, callback) {
      if (typeof options === 'number') {
        options = { duration: options }
      }
      return this.scrollTo(0, 0, options, callback)
    },

    toobj: function (target, options, callback) {
      if (typeof options === 'number') {
        options = { margin: options }
      }
      options = Object.assign({ margin: 0 }, options)
      target = Pro.to(target)
      if (target.length) {
        this.scrollTo(0, target.offset().top - options.margin, options, callback)
      }
      return this
    },

    animate: function (el, options, callback) {
      if (typeof el === 'string') {
        el = document.querySelector(el)
      }
      let property = Object.keys(options)[0]
      let style = window.getComputedStyle(el, null)[property]
      let unit = options.unit || style.match(/([0-9,.]+)([a-z]*)/)[2]
      let to = options[property]
      let from = options.from || parseInt(style, 10)
      if (options.from) {
        el.style[property] = from + unit
      }
      let steps = (options.duration || Pro.animation.duration) / Pro.animation.delay
      let step = (from - to) / steps
      let render = () => {
        from -= step
        el.style[property] = from + unit
        if (--steps > 0) {
          el.dataset.animate = Pro.animation.request(render, el)
        } else {
          el.style[property] = to + unit
          delete el.dataset.animate
          if (typeof callback === 'function') {
            callback.call(el)
          }
        }
      }
      if (step) {
        steps = Math.round(steps)
      }
      render()
      return this
    },

    queue: function (el, callback) {
      if (typeof el === 'string') {
        el = document.querySelector(el)
      }
      let fn = () => {
        if (el.dataset.animate) {
          setTimeout(fn, 1000 / Pro.animation.delay)
        } else {
          callback()
        }
      }
      fn()
      return this
    },

    stop: function (el) {
      if (typeof el === 'string') {
        el = document.querySelector(el)
      }
      if (el.dataset.animate) {
        Pro.animation.cancel(el.dataset.animate)
        delete el.dataset.animate
      }
      return this
    },

    hide: function (el, duration, callback) {
      if (typeof el === 'string') {
        el = document.querySelector(el)
      }
      if (typeof duration === 'function') {
        callback = duration
        duration = 0
      }
      return this.queue(el, () => {
        Pro.animate(el, { opacity: 0, duration: duration }, () => {
          el.style.display = 'none'
          if (typeof callback === 'function') {
            callback.call(el)
          }
        })
      })
    },

    show: function (el, duration, callback) {
      if (typeof el === 'string') {
        el = document.querySelector(el)
      }
      if (typeof duration === 'function') {
        callback = duration
        duration = 0
      }
      return this.queue(el, () => {
        if (el.style.display === 'none') {
          el.style.display = ''
          el.style.opacity = 0
        }
        Pro.animate(el, { opacity: 1, duration: duration }, callback)
      })
    }
  })

  Pro.assign({
    animate: function (options, callback) {
      this.each(function () {
        Pro.animate(this, options, callback)
      })
    },

    queue: function (callback) {
      this.each(function () {
        Pro.queue(this, callback)
      })
    },

    stop: function () {
      this.each(function () {
        Pro.stop(this)
      })
    },

    hide: function (duration, callback) {
      this.each(function () {
        Pro.hide(this, duration, callback)
      })
    },

    show: function (duration, callback) {
      this.each(function () {
        Pro.show(this, duration, callback)
      })
    },

    toggle: function (duration, callback) {
      this.each(function () {
        if (this.style.display === 'none') {
          Pro.show(this, duration, callback)
        } else {
          Pro.hide(this, duration, callback)
        }
      })
    }
  }, true)
}).call(this, window, document, document.documentElement, Pro)
