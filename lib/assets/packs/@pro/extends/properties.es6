(function (window, PRO) {
  const Pro = PRO()

  function getRect (el) {
    return typeof el.getBoundingClientRect === 'function'
      ? el.getBoundingClientRect()
      : { top: 0, left: 0, bottom: 0, right: 0 }
  }

  function isWindow (el) {
    return el === el.window
  }

  function getWindow (el) {
    return isWindow(el) ? el : el.defaultView
  }

  const PROinnerHeight = function (el) {
    return isWindow(el) ? el.innerHeight : el.clientHeight
  }

  const PROinnerWidth = function (el) {
    return isWindow(el) ? el.innerWidth : el.clientWidth
  }

  const PROouterHeight = function (el, includeMargin = true) {
    let height = PROinnerHeight(el)
    if (includeMargin && !isWindow(el)) {
      const computedStyle = window.getComputedStyle(el)
      height += parseInt(computedStyle.marginTop, 10)
      height += parseInt(computedStyle.marginBottom, 10)
    }
    return height
  }

  const PROouterWidth = function (el, includeMargin = true) {
    let width = PROinnerWidth(el)
    if (includeMargin && !isWindow(el)) {
      const computedStyle = window.getComputedStyle(el)
      width += parseInt(computedStyle.marginLeft, 10)
      width += parseInt(computedStyle.marginRight, 10)
    }
    return width
  }

  const PROscrollTop = function (el) {
    const win = getWindow(el)
    return win ? win.pageYOffset : el.scrollTop
  }

  const PROscrollLeft = function (el) {
    const win = getWindow(el)
    return win ? win.pageXOffset : el.scrollLeft
  }

  const PROoffset = function (el) {
    if (el.ownerDocument) {
      const win = getWindow(el.ownerDocument)
      const html = el.ownerDocument.documentElement
      const rect = getRect(el)
      return {
        top: rect.top + win.pageYOffset - html.clientTop,
        left: rect.left + win.pageXOffset - html.clientLeft
      }
    }
  }

  const PROview = function (el, full = false) {
    if (el.ownerDocument) {
      const win = getWindow(el.ownerDocument)
      const html = el.ownerDocument.documentElement
      const rect = getRect(el)
      const port = {
        bottom: win.innerHeight || html.clientHeight,
        right: win.innerWidth || html.clientWidth
      }
      return full
        ? (
          rect.top >= 0 &&
          rect.left >= 0 &&
          rect.bottom <= port.bottom &&
          rect.right <= port.right
        ) : (
          rect.top <= port.bottom &&
          rect.left <= port.right &&
          rect.bottom >= 0 &&
          rect.right >= 0
        )
    }
  }

  Pro.assign({
    innerHeight: PROinnerHeight,
    innerWidth: PROinnerWidth,
    outerHeight: PROouterHeight,
    outerWidth: PROouterWidth,
    scrollTop: PROscrollTop,
    scrollLeft: PROscrollLeft,
    offset: PROoffset,
    view: PROview
  })

  for (let method of [
    'innerHeight',
    'innerWidth',
    'outerHeight',
    'outerWidth',
    'scrollTop',
    'scrollLeft',
    'offset',
    'view'
  ]) {
    Pro.prototype[method] = function (param) {
      return this.length && Pro[method](this.first, param)
    }
  }
})(window, PRO);
