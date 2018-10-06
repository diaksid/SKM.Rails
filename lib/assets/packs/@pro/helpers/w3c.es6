(function (PRO) {
  const Pro = PRO()

  const PROw3c = function (selector = '[data-w3c]') {
    return Pro.to(selector)
      .deactive()
      .onclick(() => window.open(
        `//validator.w3.org/nu/?doc=${encodeURIComponent(location.href)}&showsource=yes&showoutline=yes`,
        '_blank'
      ))
  }

  Pro.w3c = function () {
    PROw3c(...arguments)
    return this
  }

  Pro.prototype.w3c = function () {
    PROw3c(this)
    return this
  }
})(PRO)
