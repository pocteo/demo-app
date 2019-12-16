'use strict'

const logger = require('koa-logger')
const Koa = require('koa')
const app = new Koa()

app.use(logger())

app.use(async ctx => {
  ctx.body = `GitOps`
})

app.listen(3000)
