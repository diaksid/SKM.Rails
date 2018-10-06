(function (window, PRO) {
  const Pro = PRO()

  const ANIMATION_DELAY = 60
  const ANIMATION_DURATION = 1000

  Pro.animation = {
    delay: ANIMATION_DELAY,
    duration: ANIMATION_DURATION,

    request (callback, el) {
      return (
        window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame ||
        window.oRequestAnimationFrame ||
        window.msRequestAnimationFrame ||
        (callback => {
          setTimeout(callback, ANIMATION_DELAY)
        })
      )(callback, el)
    },

    cancel (id) {
      return (
        window.cancelAnimationFrame ||
        window.webkitCancelRequestAnimationFrame ||
        window.mozCancelAnimationFrame ||
        window.oCancelRequestAnimationFrame ||
        window.msCancelRequestAnimationFrame ||
        (id => {
          clearTimeout(id)
        })
      )(id)
    }
  }
})(window, PRO)
