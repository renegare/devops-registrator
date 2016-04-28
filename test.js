const test = require('ava').test
const expect = require('chai').expect
const debug = require('debug')('test')
const req = require('request-promise')

const DOCKER_HOST = (process.env.DOCKER_HOST || '').replace(/tcp:\/\/([^:]+):.+$/, '$1') || '127.0.0.1'
debug('docker host', DOCKER_HOST)

const consulReq = req.defaults({
  baseUrl: 'http://' + DOCKER_HOST + ':8500',
  resolveWithFullResponse: true
})

const appReq = req.defaults({
  baseUrl: 'http://' + DOCKER_HOST + ':3000',
  resolveWithFullResponse: true
})

test('verify consul is reachable', () => {
  return consulReq('/v1/status/leader')
    .then(res => expect(res.statusCode).to.eql(200))
})

test('verify sample app A is reachable', () => {
  return appReq('/healthcheck')
    .then(res => expect(res.statusCode).to.eql(200))
})
//
// test('verify sample app A is ')
