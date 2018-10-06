(function (PRO) {
  const PRObase64 = function (selector = '[data-base64]') {
    return PRO.to(selector).each(element => {
      if (element.dataset) {
        element.innerHTML += atob(element.dataset.base64)
      }
    })
  }

  PRO.base64 = function () {
    PRObase64(...arguments)
    return this
  }

  PRO.prototype.base64 = function () {
    PRObase64(this)
    return this
  }
})(PRO)
