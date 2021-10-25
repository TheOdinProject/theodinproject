const { environment } = require('@rails/webpacker')
const webpack = require('webpack');
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer')

environment.plugins.append(
  'BundleAnalyzer',
  new BundleAnalyzerPlugin()
)

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}));

environment.config.set('resolve.alias', {jquery: 'jquery/src/jquery'});

module.exports = environment
