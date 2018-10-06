(function (PRO) {
  const Pro = PRO()

  class PROjson {
    static to (data) {
      return JSON.stringify(data)
    }

    static from (data) {
      if (typeof data === 'string' && data.match(/\[(.+)]/)) {
        return JSON.parse(data)
      }
    }
  }

  Pro.json = PROjson
})(PRO)
