import Route from "@ember/routing/route";

import rehypeShikiFromHighlighter from "@shikijs/rehype/core";
import { colorScheme } from "ember-primitives/color-scheme";
import { setupKolay } from "kolay/setup";
import { createHighlighterCore } from "shiki/core";
import { createOnigurumaEngine } from "shiki/engine/oniguruma";

import type { Manifest } from "kolay";

export default class ApplicationRoute extends Route {
  async model(): Promise<{ manifest: Manifest }> {
    const highlighter = await createHighlighterCore({
      themes: [import("shiki/themes/github-dark.mjs"), import("shiki/themes/github-light.mjs")],
      langs: [
        import("shiki/langs/javascript.mjs"),
        import("shiki/langs/typescript.mjs"),
        import("shiki/langs/bash.mjs"),
        import("shiki/langs/css.mjs"),
        import("shiki/langs/html.mjs"),
        import("shiki/langs/markdown.mjs"),
        import("shiki/langs/glimmer-js.mjs"),
        import("shiki/langs/glimmer-ts.mjs"),
        import("shiki/langs/handlebars.mjs"),
        import("shiki/langs/jsonc.mjs"),
      ],
      engine: createOnigurumaEngine(() => import("shiki/wasm")),
    });

    const manifest = await setupKolay(this, {
      resolve: {
        "ember-primitives": import("ember-primitives"),
        "ember-primitives/components/popover": import("ember-primitives/components/popover"),
        "ember-primitives/components/progress": import("ember-primitives/components/progress"),
        "nvp.ui": import("../../src/index"),
        "nvp.ui/components/progress-circle": import("../../src/components/progress-circle"),
        kolay: import("kolay"),
      },
      rehypePlugins: [
        // @shikijs/rehype
        [
          rehypeShikiFromHighlighter,
          // Options for @shikijs/rehype-
          // https://shiki.matsu.io/packages/rehype#fine-grained-bundle
          highlighter,
          {
            defaultColor: colorScheme.current === "dark" ? "dark" : "light",
            themes: {
              light: "github-light",
              dark: "github-dark",
            },
          },
        ],
      ],
    });

    return { manifest };
  }
}
