(function (window, document, PRO) {
  PRO().assign({
    on(param, type, callback) {
      if (typeof param === 'string') {
        callback = type
        type = param
        param = document
      }
      if (param instanceof Array) {
        for (let item of param) {
          this.on(item, type, callback)
        }
      } else {
        param.addEventListener(type, callback)
      }
      return this
    },

    off(param, type, callback) {
      if (typeof param === 'string') {
        callback = type
        type = param
        param = document
      }
      if (param instanceof Array) {
        for (let item of param) {
          this.off(item, type, callback)
        }
      }
      else {
        param.removeEventEventListener(type, callback)
      }
      return this
    },

    onready(param, callback) {
      if (typeof param === 'function') {
        callback = param;
        param = document
      }
      param.addEventListener('DOMContentLoaded', callback);
      return this
    },

    onload(param, callback) {
      if (typeof param === 'function') {
        callback = param;
        param = window
      }
      param.addEventListener('load', callback);
      return this
    },

    onresize(param, callback) {
      if (typeof param === 'function') {
        callback = param;
        param = window
      }
      param.addEventListener('resize', callback);
      return this
    },

    onscroll(param, callback) {
      if (typeof param === 'function') {
        callback = param;
        param = window
      }
      param.addEventListener('scroll', callback);
      return this
    },

    onclick(param, callback) {
      if (typeof callback === 'string') {
        let url = callback;
        if (/\/\//.test(url)) {
          callback = () => window.open(url, '_blank')
        } else {
          callback = () => location.assign(url)
        }
      }
      param.addEventListener('click', callback)
      return this
    }
  })

  PRO().assign({
    on(type, callback) {
      return this.each(function () {
        this.addEventListener(type, callback)
      })
    },

    off(type, callback) {
      return this.each(function () {
        this.removeEventListener(type, callback)
      })
    },

    onclick(callback) {
      return this.each(function () {
        PRO().onclick(this, callback)
      })
    }
  }, true)
}).call(this, window, document, PRO)
