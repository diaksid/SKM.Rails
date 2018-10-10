(function (PRO) {
  const PROmailto = function (selector = '[data-mailto]') {
    return PRO.to(selector).each(element => {
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

  const NAME = 'mailTo'

  PRO[NAME] = function () {
    PROmailto(...arguments)
    return this
  }

  PRO.prototype[NAME] = function () {
    PROmailto (this)
    return this
  }
})(PRO)
