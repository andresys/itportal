module.exports = {
  test: /\.s?css$/,
  use: [
      "style-loader",
      "style-loader", // creates style nodes from JS strings
      "css-loader", // translates CSS into CommonJS
      "sass-loader" // compiles Sass to CSS
  ]
}