import { sync, colorScheme } from 'ember-primitives/color-scheme';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

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
const Shell = setComponentTemplate(precompileTemplate("\n  {{(syncBodyClass)}}{{yield}}\n", {
  strictMode: true,
  scope: () => ({
    syncBodyClass
  })
}), templateOnly());

export { Shell };
//# sourceMappingURL=shell.js.map
