process.env.NODE_ENV = process.env.NODE_ENV || 'development';
const FriendlyErrors = require('friendly-errors-webpack-plugin');
const ErrorOverlay = require('error-overlay-webpack-plugin');
const environment = require('./environment');

environment.config.devServer.sockPort = 3035;
environment.plugins.push(
    { key: 'ErrorOverlay', value: new ErrorOverlay() },
    { key: 'FriendlyErrors', value: new FriendlyErrors() },
);

module.exports = environment.toWebpackConfig();
