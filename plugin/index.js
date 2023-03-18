const { withPlugins } = require('@expo/config-plugins');
const withBuildscriptDependency = require('./android/withBuildscriptDependency');

module.exports = (config) => {
  return withPlugins(config, [withBuildscriptDependency]);
};
