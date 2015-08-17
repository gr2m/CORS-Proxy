/* global describe, it, beforeEach*/
'use strict'

describe('example app', function () {
  this.timeout(60000)

  beforeEach(function () {
    return this.browser
      .get('http://localhost:1338')
  })

  it('Heading is "CORS Proxy test"', function () {
    return this.browser
      .elementByCssSelector('h1').text()
      .should.eventually.equal('CORS Proxy test')
  })
})
