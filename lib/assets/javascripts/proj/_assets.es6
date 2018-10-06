(function (window, document, Pro) {

  Pro.assign({
    assets: '',

    asset(path) {
      if (path.indexOf('//') === -1) {
        if (path[0] === '/') {
          path = path.slice(1)
        }
        path = `${this.assets}/${path}`
      }
      return path
    },

    stylesheet(path, options, callback) {
      if (typeof options === 'function') {
        callback = options
        options = null
      }
      options = Object.assign({
        href: this.asset(path),
        rel: 'stylesheet'
      }, options)
      const el = document.createElement('link')
      for (let key in options) {
        if (options.hasOwnProperty(key)) {
          el.setAttribute( key, options[key])
        }
      }
      if (typeof callback === 'function') {
        el.addEventListener('load', callback)
      }
      function fn () {
        document.head.appendChild(el)
      }
      if (window.opera === '[object Opera]') {
        Pro.onready(fn)
      } else {
        fn()
      }
      return this
    },

    script(path, options, callback) {
      if (typeof options === 'function') {
        callback = options
        options = null
      }
      options = Object.assign({
        src: this.asset(path),
        async: true
      }, options)
      if (options.hasOwnProperty('async') && !options.async) {
        delete options.async
      }
      const el = document.createElement('script')
      for (let key in options) {
        if (options.hasOwnProperty(key)) {
          el.setAttribute( key, options[key])
        }
      }
      if (typeof callback === 'function') {
        el.addEventListener('load', callback)
      }
      const parent = window.Turbolinks ? 'head' : 'body'
      function fn () {
        document[parent].appendChild(el)
      }
      if (window.opera === '[object Opera]') {
        Pro.onready(fn)
      } else {
        fn()
      }
      return this
    }
  })

}).call(this, window, document, Pro)
