(function (PRO) {
  const Pro = PRO()

  const PROmailto = function (selector = '[data-mailto]') {
    return Pro.to(selector).each(element => {
      const mail = element.dataset && atob(element.dataset.mailto)
      if (mail) {
        element.href = `mailto://${mail}`
        if (!element.dataset.hasOwnProperty('mailtoSafe')) {
          element.innerHTML += mail
        }
      } else {
        element.style.visibility = 'hidden'
      }
    })
  }

  Pro.mailto = function () {
    PROmailto(...arguments)
    return this
  }

  Pro.prototype.mailto = function () {
    PROmailto (this)
    return this
  }
})(PRO)
