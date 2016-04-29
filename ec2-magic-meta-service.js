// simulate EC2 magic IP: http://169.254.169.254/latest/meta-data/local-ipv4


const logger = require('koa-logger')
const app = require('koa')().use(logger())
const debug = require('debug')('test')

const DOCKER_HOST = (process.env.DOCKER_HOST || '').replace(/tcp:\/\/([^:]+):.+$/, '$1') || '127.0.0.1'
debug('docker host', DOCKER_HOST)

app.use(function * () {
  this.body = DOCKER_HOST
})

app.listen(3000)
