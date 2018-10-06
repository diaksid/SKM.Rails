(function (PRO) {
  const Pro = PRO()
  const PROinnerHeight = Pro.innerHeight

  const PROaligns = function (selector, context) {
    let val = 0
    return new Pro(selector, context)
      .each(function () {
        this.style.height = ''
        const height = PROinnerHeight(this)
        if (height > val) {
          val = height
        }
      })
      .each(function () {
        this.style.height = `${val}px`
      })
  }

  Pro.aligns = function () {
    PROaligns(...arguments)
    return this
  }

  Pro.prototype.aligns = function (selector) {
    if (selector) {
      this.each(function () {
        PROaligns(selector, this)
      })
    } else {
      PROaligns(this)
    }
    return this
  }
})(PRO)
