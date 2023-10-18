process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

environment.runtimeCompiler = true

module.exports = environment.toWebpackConfig()