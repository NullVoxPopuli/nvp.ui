import { classicEmberSupport, ember, extensions } from '@embroider/vite';

import { babel } from '@rollup/plugin-babel';
import { kolay } from 'kolay/vite';
import info from 'unplugin-info/vite';
import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    target: ['esnext'],
  },
  plugins: [
    info(),
    kolay({
      src: 'public/docs',
      packages: ['@universal-ember/preem'],
    }),
    classicEmberSupport(),
    ember(),
    // extra plugins here
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
  optimizeDeps: {
    // a wasm-providing dependency
    exclude: ['content-tag'],
    // for top-level-await, etc
    esbuildOptions: {
      target: 'esnext',
    },
  },
});
