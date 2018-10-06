(function (PRO) {
  const Pro = PRO()

  Pro.assign({
    deactive () {
      return this.onclick((event) => {
        event.preventDefault()
        event.stopPropagation()
        return false
      })
    }
  }, true)
})(PRO)
