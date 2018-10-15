(function (PRO) {
  PRO.fn = PRO.fn || {}

  PRO.fn.onready = function () {
    PRO('a.is-active, .is-active > a').deactive()
    PRO.fn.submit()
    PRO
      .base64()
      .mailTo()
      .scrollTo()
      .w3c()
      .yandexMetrika()
      .lightBox()
      .onResize(PRO.fn.aligns)
    return this
  }

  PRO.fn.onload = function () {
    PRO.fn.aligns()
    PRO
      .lazyLoad({
        scope: '.mdl-layout__content',
        reset: 'turbolinks:before-cache'
      })
      .yandexMap('.c-content__ymap')
    PRO('[data-click]').each(function () {
      PRO.onclick(this, this.dataset.click)
    })
    setTimeout(PRO.fn.snackbar, 1000)
    return this
  }
}).call(this, PRO)
