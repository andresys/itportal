const { environment } = require('@rails/webpacker')
const sass = require('./loaders/sass')
// const woff2 = require('./loaders/woff2')

environment.loaders.prepend('sass', sass)
// environment.loaders.prepend('woff2', woff2)

module.exports = environment
