const { withProjectBuildGradle } = require('@expo/config-plugins');
const {
  mergeContents,
} = require('@expo/config-plugins/build/utils/generateCode');

const withBuildscriptDependency = (config) => {
  return withProjectBuildGradle(config, (result) => {
    result.modResults.contents = addDependencies(result.modResults.contents);
    return result;
  });
};

function addDependencies(buildGradle) {
  const newBuildGradle = mergeContents({
    tag: 'RNSFC',
    src: buildGradle,
    newSrc: `maven { url "https://s3.amazonaws.com/salesforcesos.com/android/maven/release" }`,
    anchor: `maven { url 'https://www.jitpack.io' }`,
    offset: 0,
    comment: '//',
  });
  return newBuildGradle.contents;
}

module.exports = withBuildscriptDependency;
