import { ember, extensions } from "@embroider/vite";

import { babel } from "@rollup/plugin-babel";
import { kolay } from "kolay/vite";
import info from "unplugin-info/vite";
import { defineConfig } from "vite";

const nm = `${process.cwd()}/node_modules`;

export default defineConfig({
  build: {
    target: ["esnext"],
  },
  resolve: {
    extensions,
    alias: {
      "@universal-ember/preem": `${process.cwd()}/src/index.ts`,

      // bug? idk
      "@glimmer/tracking/primitives/cache": `${nm}/ember-source/dist/packages/@glimmer/tracking/primitives/cache`,
      "@glimmer/tracking": `${nm}/ember-source/dist/packages/@glimmer/tracking/index`,

      // All of this goes away when these addons are converted to V2
      // HOWEVER -- @ember/render-modifiers should be killed
      "ember-a11y-testing/test-support": `${nm}/ember-a11y-testing/addon-test-support`,
      "@ember/render-modifiers/modifiers/did-insert": `${nm}/@ember/render-modifiers/addon/modifiers/did-insert`,
      "@ember/render-modifiers/modifiers/did-update": `${nm}/@ember/render-modifiers/addon/modifiers/did-update`,
      "@ember/render-modifiers/modifiers/will-destroy": `${nm}/@ember/render-modifiers/addon/modifiers/will-destroy`,
      "ember-set-body-class/helpers/set-body-class": `${nm}/ember-set-body-class/addon/helpers/set-body-class`,
      "ember-on-resize-modifier/modifiers/on-resize": `${nm}/ember-on-resize-modifier/addon/modifiers/on-resize`,
    },
  },
  plugins: [
    ember(),
    babel({
      babelHelpers: "inline",
      extensions,
    }),
    info(),
    kolay({
      src: "public/docs",
      packages: ["."],
    }),
  ],
  optimizeDeps: {
    // a wasm-providing dependency
    exclude: ["content-tag"],
    // for top-level-await, etc
    esbuildOptions: {
      target: "esnext",
    },
  },
});
