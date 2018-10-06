(function (PRO) {
  const PROw3c = function (selector = '[data-w3c]') {
    return PRO.to(selector)
      .deactive()
      .onclick(() => window.open(
        `//validator.w3.org/nu/?doc=${encodeURIComponent(location.href)}&showsource=yes&showoutline=yes`,
        '_blank'
      ))
  }

  PRO.w3c = function () {
    PROw3c(...arguments)
    return this
  }

  PRO.prototype.w3c = function () {
    PROw3c(this)
    return this
  }
})(PRO)
