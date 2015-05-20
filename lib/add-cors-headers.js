module.exports = function addCorsHeaders (request, reply) {
  var allowedHeaders = [
    'authorization',
    'content-length',
    'content-type',
    'if-match',
    'if-none-match',
    'origin',
    'x-requested-with'
  ]

  function addAllowedHeaders (arr) {
    for (var i = 0; i < arr.length; i++) {
      if (allowedHeaders.indexOf(arr[i].trim().toLowerCase()) === -1) {
        allowedHeaders.push(arr[i].trim().toLowerCase())
      }
    }
  }
  addAllowedHeaders(Object.keys(request.headers))

  // depending on whether we have a boom or not,
  // headers need to be set differently.
  var response = request.response.isBoom ? request.response.output : request.response

  if (request.method === 'options') {
    response.statusCode = 200
    if (request.headers['access-control-request-headers']) {
      addAllowedHeaders(
        request.headers['access-control-request-headers'].split(',')
      )
    }
  }

  response.headers['access-control-allow-origin'] = request.headers.origin
  response.headers['access-control-allow-headers'] = allowedHeaders.join(', ')
  response.headers['access-control-expose-headers'] = 'content-type, content-length, etag'
  response.headers['access-control-allow-methods'] = 'GET, PUT, POST, DELETE'
  response.headers['access-control-allow-credentials'] = 'true'

  reply.continue()
}
