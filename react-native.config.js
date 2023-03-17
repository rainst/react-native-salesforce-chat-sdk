module.exports = {
  dependency: {
    platforms: {
      ios: {
        scriptPhases: [
          {
            name: '[RNSFCSDK] Strip Development Resources',
            path: './StripDevelopmentResources.sh',
            execution_position: 'after_compile',
            input_files: [],
          },
        ],
      },
    },
  },
};
