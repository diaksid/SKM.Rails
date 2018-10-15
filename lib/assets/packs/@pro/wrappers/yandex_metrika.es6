(function (PRO) {
  const PROyandexMetrika = function (selector = '[data-yandex-metrika]') {
    return PRO.to(selector).each(element => {
      if (element.dataset && element.dataset.yandexMetrika) {
        PRO(element)
          .deactive()
          .onclick(() => window.open(
            `//metrika.yandex.ru/dashboard?id=${element.dataset.yandexMetrika}`,
            '_blank'
          ))
      }
    })
  }

  const NAME = 'yandexMetrika'

  PRO[NAME] = function () {
    PROyandexMetrika(...arguments)
    return this
  }

  PRO.prototype[NAME] = function () {
    PROyandexMetrika(this)
    return this
  }
})(PRO)
