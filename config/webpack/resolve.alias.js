const path = require('path');

module.exports = {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, '..', '..', 'app/javascript/src'),
      '@components': path.resolve(__dirname, '..', '..', 'app/javascript/src/components')
    },
    extensions: ['.js', '.jsx', '.scss', '.css']
  }
};