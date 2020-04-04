module.exports = {
  pwa: {
    assetsVersion: '1.0.2',
    workboxPluginMode: 'InjectManifest',
    workboxOptions: {
      swSrc: './src/sw.js',
      swDest: 'service-worker.js',
    },
  },
};
