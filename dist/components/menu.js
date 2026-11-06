import "./menu.css"
import '../variables-goOgJf2v.js';
import '../focus-C7z7jBjO.js';
import { hash } from '@ember/helper';
import { modifier } from 'ember-modifier';
import { Key } from 'ember-primitives/components/keys';
import { Menu as Menu$1 } from 'ember-primitives/components/menu';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck

const Menu = setComponentTemplate(precompileTemplate("<PrimitiveMenu @placement={{if @placement @placement \"bottom-start\"}} @offsetOptions={{6}} as |menu|>\n  {{yield (hash Trigger=(component StyledTrigger Trigger=menu.Trigger variant=@variant) Content=(component StyledContent Content=menu.Content isOpen=menu.isOpen))}}\n</PrimitiveMenu>", {
  strictMode: true,
  scope: () => ({
    PrimitiveMenu: Menu$1,
    hash,
    StyledTrigger,
    StyledContent
  })
}), templateOnly());
const StyledTrigger = setComponentTemplate(precompileTemplate("<@Trigger class=\"nvp__menu__trigger\" data-variant={{@variant}} ...attributes>\n  {{yield}}\n</@Trigger>", {
  strictMode: true
}), templateOnly());
const showPopover = modifier(element => {
  element.showPopover();
});
const StyledContent = setComponentTemplate(precompileTemplate("<@Content class=\"nvp__menu__content surface elevation-xl\" ...attributes as |items|>\n  {{yield (hash Item=(component StyledItem Item=items.Item) LinkItem=(component StyledLinkItem LinkItem=items.LinkItem) Separator=(component StyledSeparator Separator=items.Separator))}}\n</@Content>\n{{#if @isOpen}}\n  {{!-- The menu content is in the top layer, and the hints anchor to it.\n      An anchor is usable only when it is earlier in the top layer,\n      so the hints join the top layer after the content. --}}\n  <div popover=\"manual\" class=\"nvp__menu__kbd-hints surface elevation-lg\" {{showPopover}}>\n    press\n    <Key>esc</Key>\n    to close\n  </div>\n{{/if}}", {
  strictMode: true,
  scope: () => ({
    hash,
    StyledItem,
    StyledLinkItem,
    StyledSeparator,
    showPopover,
    Key
  })
}), templateOnly());
const StyledItem = setComponentTemplate(precompileTemplate("<@Item class=\"nvp__menu__item\" @onSelect={{@onSelect}} ...attributes>\n  {{yield}}\n</@Item>", {
  strictMode: true
}), templateOnly());
const StyledLinkItem = setComponentTemplate(precompileTemplate("<@LinkItem class=\"nvp__menu__link-item\" @href={{@href}} ...attributes>\n  {{yield}}\n</@LinkItem>", {
  strictMode: true
}), templateOnly());
const StyledSeparator = setComponentTemplate(precompileTemplate("<@Separator class=\"nvp__menu__separator\" ...attributes />", {
  strictMode: true
}), templateOnly());

export { Menu };
//# sourceMappingURL=menu.js.map
