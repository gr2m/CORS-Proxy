# corsproxy

> standalone CORS proxy

## Setup

```
npm install -g corsproxy
corsproxy
# with custom port: CORSPROXY_PORT=1234 corsproxy
```

## Usage

The cors proxy will start at http://localhost:1337.
To access another domain, use the domain name (including port) as the first folder, e.g.

- http://localhost:9292/localhost:3000/sign_in
- http://localhost:9292/my.domain.com/path/to/resource
- etc etc

## License

MIT
