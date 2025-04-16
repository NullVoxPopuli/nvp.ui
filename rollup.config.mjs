import { Addon } from '@embroider/addon-dev/rollup';

import { babel } from '@rollup/plugin-babel';
import { resolve } from 'node:path';

const addon = new Addon({
  srcDir: 'src',
  destDir: 'dist',
});

export default {
  output: addon.output(),
  plugins: [
    addon.publicEntrypoints(['**/*.js']),
    // Services are the only thing we can't rely on auto-import
    // handling for us.
    addon.appReexports(['services/**/*.js']),
    babel({
      extensions: ['.js', '.gjs', '.ts', '.gts'],
      babelHelpers: 'bundled',
      configFile: resolve(import.meta.dirname, './babel.publish.config.cjs'),
    }),
    addon.dependencies(),
    addon.gjs(),
    addon.declarations('declarations'),
    addon.keepAssets(['**/*.css']),
    addon.clean(),
  ],
};
