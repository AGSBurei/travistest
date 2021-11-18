module.exports = {
    devServer: {
      proxy: 'http://front:8080',
      disableHostCheck: true,   // That solved it
      // outputDir: '../mobile/www',
      // publicPath: './'
    }
  }