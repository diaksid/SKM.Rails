(function (PRO) {
  const PROyandexMetrika = function (selector = '[data-yandex-metrika]') {
    return PRO.to(selector).each(element => {
      if (element.dataset && element.dataset.yandexMetrika) {
        PRO(element)
          .deactive()
          .onclick(el => window.open(
            `//metrika.yandex.ru/dashboard?id=${el.dataset.yandexMetrika}`,
            '_blank'
          ))
      }
    })
  }

  PRO.yandexMetrika = function () {
    PROyandexMetrika(...arguments)
    return this
  }

  PRO.prototype.yandexMetrika = function () {
    PROyandexMetrika(this)
    return this
  }
})(PRO)
