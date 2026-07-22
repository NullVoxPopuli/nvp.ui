import { Button } from './button.js';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

const ToggleButton = setComponentTemplate(precompileTemplate("<Button aria-pressed={{if @pressed \"true\" \"false\"}} ...attributes @disabled={{@disabled}} @onClick={{@onClick}} @variant={{@variant}} @start={{@start}} @end={{@end}}>\n  {{yield}}\n</Button>", {
  strictMode: true,
  scope: () => ({
    Button
  })
}), templateOnly());

export { ToggleButton };
//# sourceMappingURL=toggle-button.js.map
