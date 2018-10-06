(function (PRO) {

  PRO().assign({
    to(data) {
      return (data && !(data instanceof Pro)) ? new Pro(data) : data
    },

    isObject(obj) {
      return typeof obj === 'object'
        && (!obj.constructor || obj.constructor === Object)
        && Object.prototype.toString.call(obj) === '[object Object]'
    },

    fromJSON(data) {
      if (typeof data === 'string' && data.match(/\[(.+)\]/)) {
        return JSON.parse(data)
      }
    },

    toJSON(data) {
      return JSON.stringify(data)
    },

    count(data) {
      return data.length !== null ? data.length : [].slice.call(data).length
    }
  })

}).call(this, PRO)
