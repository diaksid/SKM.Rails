(function (PRO) {
  const Pro = PRO()

  const PROyandexMetrika = function (selector = '[data-yandex-metrika]') {
    return Pro.to(selector).each(element => {
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

  Pro.yandexMetrika = function () {
    PROyandexMetrika(...arguments)
    return this
  }

  Pro.prototype.yandexMetrika = function () {
    PROyandexMetrika(this)
    return this
  }
})(PRO)
