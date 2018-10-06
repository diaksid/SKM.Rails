(function (PRO) {
  PRO.assign({
    deactive () {
      return this.onclick((event) => {
        event.preventDefault()
        event.stopPropagation()
        return false
      })
    }
  }, true)
})(PRO)
