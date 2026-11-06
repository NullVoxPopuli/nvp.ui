import "./avatar.css"
import { Avatar as Avatar$1 } from 'ember-primitives/components/avatar';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

const or = (a, b) => a || b;
const orNum = (a, b) => a ?? b;
const Avatar = setComponentTemplate(precompileTemplate("<PrimitiveAvatar class=\"nvp__avatar\" data-size={{or @size \"medium\"}} @src={{@src}} ...attributes as |avatar|>\n  <avatar.Image alt={{@alt}} />\n  <avatar.Fallback @delayMs={{orNum @delayMs 200}}>\n    {{#if (has-block \"fallback\")}}\n      {{yield to=\"fallback\"}}\n    {{else}}\n      <svg viewBox=\"0 0 24 24\" fill=\"currentColor\" width=\"60%\" height=\"60%\" aria-hidden=\"true\">\n        <path d=\"M12 12c2.7 0 4.8-2.1 4.8-4.8S14.7 2.4 12 2.4 7.2 4.5 7.2 7.2 9.3 12 12 12zm0 2.4c-3.2 0-9.6 1.6-9.6 4.8v2.4h19.2v-2.4c0-3.2-6.4-4.8-9.6-4.8z\" />\n      </svg>\n    {{/if}}\n  </avatar.Fallback>\n</PrimitiveAvatar>", {
  strictMode: true,
  scope: () => ({
    PrimitiveAvatar: Avatar$1,
    or,
    orNum
  })
}), templateOnly());
const AvatarGroup = setComponentTemplate(precompileTemplate("<div class=\"nvp__avatar-group\" data-size={{or @size \"medium\"}} role=\"group\" ...attributes>\n  {{yield}}\n</div>", {
  strictMode: true,
  scope: () => ({
    or
  })
}), templateOnly());

export { Avatar, AvatarGroup };
//# sourceMappingURL=avatar.js.map
