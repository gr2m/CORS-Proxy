## Installation

As a standalone tool:

    $ npm install -g corsproxy

As a dependency:

    $ npm install corsproxy


## Running

Standalone:

    $ corsproxy
    CORS Proxy started on localhost:9292

Standalone with custom host/port:

    $ corsproxy 0.0.0.0 1234
    CORS Proxy started on 0.0.0.0:1234

As a dependency:

    var cors_proxy = require("corsproxy");
    var http_proxy = require("http-proxy");
    http_proxy.createServer(cors_proxy).listen(1234);

With custom target:

    var cors_proxy = require("corsproxy");
    var http_proxy = require("http-proxy");
    cors_proxy.options = {
         target: "http://0.0.0.0:5984"
    };
    http_proxy.createServer(cors_proxy).listen(1234);


## Usage

The cors proxy will start at http://localhost:9292. To access another domain, use the domain name (including port) as the first folder, e.g.

    http://localhost:9292/localhost:3000/sign_in
    http://localhost:9292/my.domain.com/path/to/resource
    etc etc
