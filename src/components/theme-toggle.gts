import "./variables.css";
import "./focus.css";
import "./theme-toggle.css";
import "./button.css";

import { on } from "@ember/modifier";

import { colorScheme } from "ember-primitives/color-scheme";
import { Switch } from "ember-primitives/components/switch";

import { Moon, Sun } from "./-private/icons.gts";

import type { TOC } from "@ember/component/template-only";

function toggleTheme() {
  if (colorScheme.current === "dark") {
    colorScheme.update("light");
  } else {
    colorScheme.update("dark");
  }
}

function isDark() {
  return colorScheme.current === "dark";
}

export interface Signature {
  Element: Element;
}

export const ThemeToggle: TOC<Signature> = <template>
  <Switch class="nvp__site-theme-toggle" ...attributes as |s|>
    <s.Control name="color-scheme" checked={{(isDark)}} {{on "change" toggleTheme}} />
    <s.Label>
      <span class="nvp__sr-only">Toggle between light and dark mode</span>
      {{!
        🎵 It's raining, it's pouring, ... 🎵
        https://www.youtube.com/watch?v=ll5ykbAumD4
      }}
      <Moon />
      <Sun />
      <span class="ball nvp__button"></span>
    </s.Label>
  </Switch>
</template>;
