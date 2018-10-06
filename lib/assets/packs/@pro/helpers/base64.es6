(function (PRO) {
  const Pro = PRO()

  const PRObase64 = function (selector = '[data-base64]') {
    return Pro.to(selector).each(element => {
      if (element.dataset) {
        element.innerHTML += atob(element.dataset.base64)
      }
    })
  }

  Pro.base64 = function () {
    PRObase64(...arguments)
    return this
  }

  Pro.prototype.base64 = function () {
    PRObase64(this)
    return this
  }
})(PRO)
