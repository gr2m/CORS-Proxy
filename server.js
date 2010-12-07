var http = require('http');

http.createServer(function(request, response) {
  if (request.method == 'OPTIONS') {
    console.log('OPTIONS request: sending cors headers.');
    
    response.writeHead(200, {
      'Access-Control-Allow-Origin'  : '*',
      'Access-Control-Allow-Methods' : 'POST, GET, PUT, DELETE, OPTIONS',
      'Access-Control-Max-Age'       : '86400', // 24 hours
      'Access-Control-Allow-Headers' : 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept, X-MiteApiKey'
    });
    response.end();
    return;
  }
    
  var proxy = http.createClient(80, request.headers['host'].replace(/\:.*$/,''));
  
  console.log(request.method, request.url);
  var proxy_request = proxy.request(request.method, request.url, request.headers);
  proxy_request.addListener('response', function (proxy_response) {
    proxy_response.addListener('data', function(chunk) {
      response.write(chunk, 'binary');
    });
    proxy_response.addListener('end', function() {
      response.end();
    });
    response.writeHead(proxy_response.statusCode, proxy_response.headers);
  });
  request.addListener('data', function(chunk) {
    proxy_request.write(chunk, 'binary');
  });
  request.addListener('end', function() {
    proxy_request.end();
  });
}).listen(8080);