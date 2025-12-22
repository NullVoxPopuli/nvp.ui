import '../button-m_AcxtTC.js';
import { Popover } from 'ember-primitives/components/popover';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

const or = (a, b) => a || b;
const isString = x => typeof x === "string";
const Button = setComponentTemplate(precompileTemplate("\n  <Popover @inline={{true}} as |popover|>\n    <button class=\"preem__button\" data-variant={{@variant}} aria-disabled={{Boolean @disabled}} type=\"button\" {{popover.reference}}>\n      {{#if (or (has-block \"start\") @start)}}\n        <span>{{@start}}{{yield to=\"start\"}}</span>\n      {{/if}}\n\n      {{#if (or (has-block) (has-block \"text\"))}}\n        <span class=\"preem__button__text\">{{yield}}{{yield to=\"text\"}}</span>\n      {{/if}}\n\n      {{#if (or (has-block \"end\") @end)}}\n        <span>{{@end}}{{yield to=\"end\"}}</span>\n      {{/if}}\n\n      {{!-- This block must come after the main button content\n          so that screen readers read the button context and then\n          the disabled reason in that order.\n\n          It would be confusing to read the reason before you know what the reason is for.\n      --}}\n      {{#if @disabled}}\n        {{!-- Needs more work -- maybe using a menu instead of popover --}}\n        {{!-- template-lint-disable no-nested-interactive --}}\n        <popover.Content tabindex=\"0\" class=\"preem__button__disabled-reason\">\n          {{#if (isString @disabled)}}\n            {{@disabled}}\n          {{else}}\n            <@disabled />\n          {{/if}}\n          <div class=\"arrow\" {{popover.arrow}}></div>\n        </popover.Content>\n      {{/if}}\n    </button>\n\n  </Popover>\n", {
  strictMode: true,
  scope: () => ({
    Popover,
    Boolean,
    or,
    isString
  })
}), templateOnly());

export { Button };
//# sourceMappingURL=button.js.map
