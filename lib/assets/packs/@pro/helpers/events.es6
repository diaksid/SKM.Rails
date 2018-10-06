(function (PRO) {
  const Pro = PRO()

  const PROnewEvent = function (name, bubble = false, cancelable = false) {
    let event
    if (typeof Event === 'function') {
      event = new Event(name, {
        bubble: bubble,
        cancelable: cancelable
      })
    } else {
      event = document.createEvent('Event')
      event.initEvent(name, bubble, cancelable)
    }
    return event
  }

  const PROonReady = function (element, callback) {
    if (typeof element === 'function') {
      callback = element
      element = document
    }
    return element.addEventListener('DOMContentLoaded', callback)
  }

  const PROonLoad = function (element, callback) {
    if (typeof element === 'function') {
      callback = element
      element = window
    }
    return element.addEventListener('load', callback)
  }

  const PROonResize = function (element, callback) {
    if (typeof element === 'function') {
      callback = element
      element = window
    }
    return element.addEventListener('resize', callback)
  }

  const PROonScroll = function (element, callback) {
    if (typeof element === 'function') {
      callback = element
      element = window
    }
    return element.addEventListener('scroll', callback)
  }

  Pro.assign({
    newEvent: PROnewEvent,

    onReady () {
      PROonReady(...arguments)
      return this
    },

    onLoad () {
      PROonLoad(...arguments)
      return this
    },

    onResize () {
      PROonResize(...arguments)
      return this
    },

    onScroll () {
      PROonScroll(...arguments)
      return this
    }
  })
})(PRO)
