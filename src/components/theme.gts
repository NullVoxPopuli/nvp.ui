import { modifier } from "ember-modifier";
import { setColorScheme } from "ember-primitives/color-scheme";

import type { TOC } from "@ember/component/template-only";

const setTheme = modifier((element: HTMLElement, [theme]: [string]) => {
  setColorScheme(element, theme);
});

export const Theme: TOC<{
  Args: {
    name: "light" | "dark";
  };
  Blocks: {
    default: [];
  };
}> = <template>
  <div {{setTheme @name}} class="theme-{{@name}}">
    {{yield}}
  </div>
</template>;
