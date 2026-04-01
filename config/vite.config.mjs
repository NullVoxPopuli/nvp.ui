import { ember, extensions } from "@embroider/vite";

import { babel } from "@rollup/plugin-babel";
import rehypeShiki from "@shikijs/rehype";
import { kolay } from "kolay/vite";
import info from "unplugin-info/vite";
import { defineConfig } from "vite";

const nm = `${process.cwd()}/node_modules`;

export default defineConfig({
  build: {
    sourceMap: true,
    target: ["esnext"],
  },
  resolve: {
    extensions,
    alias: {
      "nvp.ui/button": `${process.cwd()}/src/components/button.gts`,
      "nvp.ui/header": `${process.cwd()}/src/components/header.gts`,
      "nvp.ui/polite-sticky": `${process.cwd()}/src/components/polite-sticky.gts`,
      "nvp.ui/theme-toggle": `${process.cwd()}/src/components/theme-toggle.gts`,
      "nvp.ui/progress-circle": `${process.cwd()}/src/components/progress-circle.gts`,
      "nvp.ui/tabs": `${process.cwd()}/src/components/tabs.gts`,
      "nvp.ui/theme": `${process.cwd()}/src/components/theme.gts`,
      "nvp.ui": `${process.cwd()}/src/index.ts`,

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
      groups: [
        {
          name: "Docs",
          src: import.meta.resolve("../public/docs", import.meta.url),
        },
      ],
      packages: ["."],
      rehypePlugins: [
        [
          rehypeShiki,
          {
            themes: {
              light: "github-light",
              dark: "github-dark",
            },
            defaultColor: "light-dark()",
          },
        ],
      ],
      scope: `
        import { ComponentSignature } from 'kolay';
      `,
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
