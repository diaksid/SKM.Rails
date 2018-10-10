(function (document, PRO) {
  PRO.fn = PRO.fn || {}

  PRO.fn.aligns = function () {
    PRO('.h-js--aligns').aligns('.h-js--align')
    return this
  }

  PRO.fn.submit = function () {
    PRO('[data-submit]').on('change', function () {
      if (this.dataset.submit) {
        document.querySelector(this.dataset.submit).submit()
      } else {
        this.parentNode.submit()
      }
    })
    return this
  }

  PRO.fn.snackbar = function () {
    var element = document.querySelector('.mdl-js-snackbar')
    if (element) {
      document.querySelectorAll('.c-message--flash').forEach(function (msg) {
        var options = { message: msg.innerHTML }
        if (msg.dataset && msg.dataset.type) {
          options.actionText = msg.dataset.type
          options.actionHandler = function () {
            alert(msg.innerHTML)
          }
        }
        element.MaterialSnackbar.showSnackbar(options)
      })
    }
    return this
  }
}).call(this, document, PRO)
