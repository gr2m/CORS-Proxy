http = require('http');
httpProxy = require('http-proxy');


module.exports = (req, res, proxy) ->
  
  unless req.headers.origin
    console.log 'req.headers.origin not given'
    res.write('hello https\n');
    res.end();
    return
  
    
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
    'access-control-allow-origin'      : req.headers.origin
  
  
  if req.method is 'OPTIONS'
    console.log 'responding to OPTIONS request'
    res.writeHead(200, cors_headers);
    res.end();
    return
    
  else
    [ignore, hostname, path] = req.url.match(/\/([^\/]*)(.*)/)

    module.exports.options = module.exports.options || {}
    if module.exports.options.target
      # use target.host and target.port
      host = module.exports.options.target.host
      port = module.exports.options.target.port || 80
    else
      [host, port] = hostname.split(/:/)

    unless host
      res.write "Cannot determine target host\n"
      res.end();
      return;

    console.log "proxying to #{host}:#{port}#{path}"
    
    
    res.setHeader(key, value) for key, value of cors_headers
    
    # req.headers.host = hostname
    req.url          = path
    
    
    # Put your custom server logic here, then proxy
    proxy.proxyRequest(req, res, {
      host: host,
      port: port || 80
    });
