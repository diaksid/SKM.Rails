(function (PRO) {
  var Pro = PRO()
  PRO.fn = PRO.fn || {}

  PRO.fn.onready = function () {
    PRO('a.is-active, .is-active > a').deactive()
    PRO('[data-ymet]').yandexMetrika()
    PRO('[data-w3c]').w3c()
    PRO.fn.submit()
    Pro
      .base64()
      .mailto()
      .scrollTo()
      .lightbox()
      .onResize(PRO.fn.aligns)
    return this
  }

  PRO.fn.onload = function () {
    PRO.fn.aligns()
    Pro
      .lazyload('.mdl-layout__content', { reset: 'turbolinks:before-cache' })
      .ymaps('.c-content__ymap')
    PRO('[data-click]').each(function () {
      PRO().onclick(this, this.dataset.click)
    })
    setTimeout(PRO.fn.snackbar, 1000)
    return this
  }
}).call(this, PRO)
