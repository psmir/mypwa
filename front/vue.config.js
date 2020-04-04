module.exports = {
  pwa: {
    assetsVersion: '1.0.3',
    workboxPluginMode: 'InjectManifest',
    workboxOptions: {
      swSrc: './src/sw.js',
      swDest: 'service-worker.js',
    },
  },
};
