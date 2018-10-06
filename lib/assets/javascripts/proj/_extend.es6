(function (PRO) {
  PRO().assign({
    aligns(selector) {
      let val = 0
      Pro.to(selector)
        .each(function () {
          this.style.height = ''
          const height = new Pro(this).innerHeight()
          if (height > val) {
            val = height
          }
        })
        .each(function () {
          this.style.height = `${val}px`
        })
    },

    scroll(options = {}, callback) {
      if (typeof options === 'function') {
        callback = options;
        options = {};
      } else if (typeof options === 'string') {
        options = { selector: options };
      }
      new Pro(options.selector || '[data-scroll]')
        .deactive()
        .onclick(function () {
          let selector = this.dataset.scroll || this.getAttribute('href');
          if (selector &&
            !this.classList.contains('is-active') &&
            !this.parentNode.classList.contains('is-active')) {
            selector === '#' ? Pro.totop(options, callback) : Pro.toobj(selector, options, callback)
          }
        });
      return this
    },

    base64() {
      new Pro('[data-base64]').each(function () {
        this.innerHTML += atob(this.dataset.base64)
      })
      return this
    },

    mailto() {
      new Pro('[data-mailto]').each(function () {
        const mail = atob(this.dataset.mailto)
        if (mail) {
          this.href = `mailto://${mail}`
          if (!this.dataset.hasOwnProperty('mailtoSafe')) {
            this.innerHTML += mail
          }
        } else {
          this.style.visibility = 'hidden'
        }
      })
      return this
    },

    w3c() {
      window.open(
        `//validator.w3.org/nu/?doc=${encodeURIComponent(location.href)}&showsource=yes&showoutline=yes`,
        '_blank'
      )
      return this
    },

    ymet() {
      if (this.dataset.ymet) {
        window.open(
          `//metrika.yandex.ru/dashboard?id=${this.dataset.ymet}`,
          '_blank'
        )
      }
      return this
    }
  });


  PRO().assign({
    aligns(selector) {
      if (selector) {
        this.each(function () {
          Pro.aligns(new Pro(selector, this))
        })
      } else {
        Pro.aligns(this)
      }
      return this
    },

    deactive() {
      return this.onclick((event) => {
        event.preventDefault();
        event.stopPropagation();
        return false
      })
    },

    w3c() {
      return this.onclick(Pro.w3c)
    },

    ymet() {
      return this.onclick(Pro.ymet)
    }
  }, true)
}).call(this, PRO)
