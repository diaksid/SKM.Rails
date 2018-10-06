(function (window, document, PRO) {
  PRO.assign({
    on (element, type, callback) {
      if (typeof element === 'string') {
        callback = type
        type = element
        element = document
      }
      if (element instanceof Array) {
        for (let item of element) {
          this.on(item, type, callback)
        }
      } else {
        element.addEventListener(type, callback)
      }
      return this
    },

    off (element, type, callback) {
      if (typeof element === 'string') {
        callback = type
        type = element
        element = document
      }
      if (element instanceof Array) {
        for (let item of element) {
          this.off(item, type, callback)
        }
      } else {
        element.removeEventListener(type, callback)
      }
      return this
    },

    onclick (element, callback) {
      if (typeof callback === 'string') {
        let url = callback
        if (/\/\//.test(url)) {
          callback = () => window.open(url, '_blank')
        } else {
          callback = () => location.assign(url)
        }
      }
      element.addEventListener('click', callback)
      return this
    }
  })

  PRO.assign({
    on (type, callback) {
      return this.each(function () {
        this.addEventListener(type, callback)
      })
    },

    off (type, callback) {
      return this.each(function () {
        this.removeEventListener(type, callback)
      })
    },

    onclick (callback) {
      return this.each(function () {
        PRO.onclick(this, callback)
      })
    }
  }, true)
})(window, document, PRO)
