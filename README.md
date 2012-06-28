## start the cors proxy

    $ git clone git://github.com/gr2m/CORS-Proxy.git
    $ cd CORS-proxy
    $ npm install .
    $ node server.js

## usage

The cors proxy will start at http://localhost:9292. To access another domain, use the domain name (including port) as the first folder, e.g.

    http://localhost:9292/localhost:3000/sign_in
    http://localhost:9292/my.domain.com/path/to/resource
    etc etc