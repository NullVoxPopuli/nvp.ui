import "./theme-toggle.css"
import '../focus-DwGfQpls.js';
import '../button-BPgeLyPB.js';
import { on } from '@ember/modifier';
import { colorScheme } from 'ember-primitives/color-scheme';
import { Switch } from 'ember-primitives/components/switch';
import { Sun, Moon } from './-private/icons.js';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

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
const ThemeToggle = setComponentTemplate(precompileTemplate("<Switch class=\"nvp__site-theme-toggle\" ...attributes as |s|>\n  <s.Control name=\"color-scheme\" checked={{(isDark)}} {{on \"change\" toggleTheme}} />\n  <s.Label>\n    <span class=\"nvp__sr-only\">Toggle between light and dark mode</span>\n    {{!--\n      \uD83C\uDFB5 It's raining, it's pouring, ... \uD83C\uDFB5\n      https://www.youtube.com/watch?v=ll5ykbAumD4\n    --}}\n    <Moon />\n    <Sun />\n    <span class=\"ball nvp__button\"></span>\n  </s.Label>\n</Switch>", {
  strictMode: true,
  scope: () => ({
    Switch,
    isDark,
    on,
    toggleTheme,
    Moon,
    Sun
  })
}), templateOnly());

export { ThemeToggle };
//# sourceMappingURL=theme-toggle.js.map
