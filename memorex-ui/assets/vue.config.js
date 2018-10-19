const path = require("path");

module.exports = {
  lintOnSave: true,
  outputDir: path.resolve(__dirname, "../priv/static"),
  devServer: {
    disableHostCheck: true,
    proxy: 'http://localhost:4000'
  }
};
