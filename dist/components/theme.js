import { modifier } from 'ember-modifier';
import { setColorScheme } from 'ember-primitives/color-scheme';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

const setTheme = modifier((element, [theme]) => {
  setColorScheme(element, theme);
});
const Theme = setComponentTemplate(precompileTemplate("\n  <div {{setTheme @name}} class=\"theme-{{@name}}\">\n    {{yield}}\n  </div>\n", {
  strictMode: true,
  scope: () => ({
    setTheme
  })
}), templateOnly());

export { Theme };
//# sourceMappingURL=theme.js.map
