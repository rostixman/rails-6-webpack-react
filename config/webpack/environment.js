const { environment } = require('@rails/webpacker');
const resolve = require('./resolve.alias');

environment.config.merge(resolve);

module.exports = environment;
