import { colorScheme, sync } from "ember-primitives/color-scheme";

import type { TOC } from "@ember/component/template-only";

/**
 * Needed when there is the possibility that the set theme is different
 * from the user's prefers-color-scheme
 */
sync();

function isDark() {
  return colorScheme.current === "dark";
}

function syncBodyClass() {
  if (isDark()) {
    document.body.classList.add("theme-dark");
    document.body.classList.remove("theme-light");
  } else {
    document.body.classList.add("theme-light");
    document.body.classList.remove("theme-dark");
  }
}

export const Shell: TOC<{ Blocks: { default: [] } }> = <template>
  {{(syncBodyClass)}}{{yield}}
</template>;
