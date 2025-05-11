import { Addon } from "@embroider/addon-dev/rollup";
import { resolve } from "node:path";

import { babel } from "@rollup/plugin-babel";

const addon = new Addon({
  srcDir: "src",
  destDir: "dist",
});

const configs = {
  babel: resolve(import.meta.dirname, "./babel.publish.config.cjs"),
  ts: resolve(import.meta.dirname, "./tsconfig.publish.json"),
};

export default {
  output: addon.output(),
  plugins: [
    addon.publicEntrypoints(["**/*.js"]),
    // Services are the only thing we can't rely on auto-import
    // handling for us.
    addon.appReexports(["services/**/*.js"]),
    babel({
      extensions: [".js", ".gjs", ".ts", ".gts"],
      babelHelpers: "bundled",
      configFile: configs.babel,
    }),
    addon.dependencies(),
    addon.gjs(),
    addon.declarations("declarations", configs.ts),
    addon.keepAssets(["**/*.css"]),
    addon.clean(),
  ],
};
