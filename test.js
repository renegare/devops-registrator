const test = require('ava').test
const expect = require('chai').expect
const debug = require('debug')('test')
const req = require('request-promise')
const resolve = require('bluebird').resolve
const reject = require('bluebird').reject

const DOCKER_HOST = (process.env.DOCKER_HOST || '').replace(/tcp:\/\/([^:]+):.+$/, '$1') || '127.0.0.1'
debug('docker host', DOCKER_HOST)

const consulReq = req.defaults({
  baseUrl: 'http://' + DOCKER_HOST + ':8500',
  resolveWithFullResponse: true
})

const consul = require('consul')({
  host: DOCKER_HOST,
  promisify (fn) {
    return new Promise((resolve, reject) => {
      try {
        fn((err, data, res) => {
          if (err) {
            err.res = res
            return reject(err)
          }
          resolve([data, res])
        })
      } catch (err) {
        reject(err)
      }
    })
  }
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

test('verify services are registered', () =>
  consul.catalog.service.list()
    .then(res => res[0])
    .then(services => expect(services).to.eql({
      consul: [],
      sample_a: []
      // sample_b: []
    }))
)
