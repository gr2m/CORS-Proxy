url = require('url');
http = require('http');
httpProxy = require('http-proxy');


module.exports = (req, res, proxy) ->
    
  if req.headers['access-control-request-headers']
    headers = req.headers['access-control-request-headers']
  else
    headers = 'accept, accept-charset, accept-encoding, accept-language, authorization, content-length, content-type, host, origin, proxy-connection, referer, user-agent, x-requested-with'
    headers += ", #{header}" for header in req.headers when req.indexOf('x-') is 0

  cors_headers =
    'access-control-allow-methods'     : 'HEAD, POST, GET, PUT, PATCH, DELETE'
    'access-control-max-age'           : '86400' # 24 hours
    'access-control-allow-headers'     : headers
    'access-control-allow-credentials' : 'true'
    'access-control-allow-origin'      : req.headers.origin || '*'
  
  
  if req.method is 'OPTIONS'
    console.log 'responding to OPTIONS request'
    res.writeHead(200, cors_headers);
    res.end();
    return
    
  else
    # Handle CORS proper.

    # do we have a target configured?
    module.exports.options = module.exports.options || {}
    if module.exports.options.target
      target0 = url.parse module.exports.options.target
      target = {
        host: target0.hostname,
        port: target0.port || 80
      }
      path = req.url
      req.headers.host = target0.hostname;
    else
      [ignore, hostname, path] = req.url.match(/\/([^\/]*)(.*)/)
      [host, port] = hostname.split(':')
      target = {
        host: host,
        port: port
      }
      req.headers.host = hostname

    unless target and target.host and target.port
      res.write "Cannot determine target host\n"
      res.end();
      return;

    # console.log "proxying to #{target.host}:#{target.port}#{path}"
    
    
    res.setHeader(key, value) for key, value of cors_headers
    
    # req.headers.host = hostname
    req.url          = path
    
    # Put your custom server logic here, then proxy
    proxy.proxyRequest(req, res, target);
