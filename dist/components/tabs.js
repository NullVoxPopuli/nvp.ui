import "./tabs.css"
import { Tabs as Tabs$1 } from 'ember-primitives/components/tabs';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

function isString(x) {
  return typeof x === "string";
}
const StyledButton = setComponentTemplate(precompileTemplate("<@button class=\"nvp__tabs__tab surface\">\n  {{yield}}\n</@button>", {
  strictMode: true
}), templateOnly());
const StyledContent = setComponentTemplate(precompileTemplate("<@content class=\"nvp__tabs__tabpanel surface\">\n  {{yield}}\n</@content>", {
  strictMode: true
}), templateOnly());
const StyledTab = setComponentTemplate(precompileTemplate("<@tab as |UnstyledButton UnstyledContent|>\n  {{#let (component StyledButton button=UnstyledButton) (component StyledContent content=UnstyledContent) as |Button Content|}}\n\n    {{#if @label}}\n      <Button>\n        {{#if (isString @label)}}\n          {{@label}}\n        {{else}}\n          <@label />\n        {{/if}}\n      </Button>\n\n      <Content>\n        {{#if @content}}\n          {{#if (isString @content)}}\n            {{@content}}\n          {{else}}\n            <@content />\n          {{/if}}\n        {{else}}\n          {{yield}}\n        {{/if}}\n      </Content>\n    {{else}}\n      <Button>\n        {{yield to=\"button\"}}\n      </Button>\n      <Content>\n        {{yield to=\"content\"}}\n      </Content>\n    {{/if}}\n  {{/let}}\n</@tab>", {
  strictMode: true,
  scope: () => ({
    StyledButton,
    StyledContent,
    isString
  })
}), templateOnly());
const Tabs = setComponentTemplate(precompileTemplate("<PrimitiveTabs class=\"nvp__tabs\" data-orientation={{or @orientation \"top\"}} data-variant={{or @variant \"primary\"}} as |Tab|>\n  {{!-- @glint-expect-error --}}\n  {{yield (component StyledTab tab=Tab)}}\n</PrimitiveTabs>", {
  strictMode: true,
  scope: () => ({
    PrimitiveTabs: Tabs$1,
    or,
    StyledTab
  })
}), templateOnly());
function or(x, y) {
  return x ?? y;
}

export { Tabs };
//# sourceMappingURL=tabs.js.map
