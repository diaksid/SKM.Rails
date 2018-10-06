//= require ./_helpers
//= require ./_events
//= require_self


(function (window, document, PRO) {
  var turbo = !!window.Turbolinks

  if (turbo && navigator.userAgent.match(/Firefox\/(\d+)\./)) {
    window.Turbolinks.supported = false
  }

  PRO
    .onReady(PRO.fn.onready)
    .onLoad(PRO.fn.onload)

  if (turbo) {
    PRO(document)
      .on('turbolinks:visit', function () {
        turbo = 'visit'
      })
      .on('turbolinks:load', function () {
        if (turbo === 'visit') {
          componentHandler.upgradeDom()
          PRO.fn
            .onready()
            .onload()
        }
      })
  }
}).call(this, window, document, PRO)
