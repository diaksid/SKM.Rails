(function (PRO) {
  const PRObase64 = function (selector = '[data-base64]') {
    return PRO.to(selector).each(element => {
      if (element.dataset) {
        element.innerHTML += atob(element.dataset.base64)
      }
    })
  }

  const NAME = 'base64'

  PRO[NAME] = function () {
    PRObase64(...arguments)
    return this
  }

  PRO.prototype[NAME] = function () {
    PRObase64(this)
    return this
  }
})(PRO)
