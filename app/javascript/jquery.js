import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

// Polyfill jQuery methods removed in jQuery 4.x but still used by
// the Flot charting library vendored in the blacklight_range_limit gem.
if (!jquery.isFunction) {
  jquery.isFunction = function (obj) {
    return typeof obj === 'function'
  }
}
if (!jquery.trim) {
  jquery.trim = function (str) {
    return str == null ? '' : String(str).trim()
  }
}
if (!jquery.proxy) {
  jquery.proxy = function (fn, context) {
    if (typeof context === 'string') {
      var tmp = fn[context]
      context = fn
      fn = tmp
    }
    if (typeof fn !== 'function') {
      return undefined
    }
    var args = Array.prototype.slice.call(arguments, 2)
    var proxy = function () {
      return fn.apply(context, args.concat(Array.prototype.slice.call(arguments)))
    }
    return proxy
  }
}
