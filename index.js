var addCorsHeaders = require('./lib/add-cors-headers')
var pkg = require('./package.json')

function corsPlugin (server, options, next) {
  server.ext('onPreResponse', addCorsHeaders)
  next()
}

corsPlugin.attributes = {
  pkg: pkg
}
module.exports = corsPlugin
