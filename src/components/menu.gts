// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck
import "./variables.css";
import "./focus.css";
import "./menu.css";

import { hash } from "@ember/helper";

import { modifier } from "ember-modifier";
import { Key } from "ember-primitives/components/keys";
import { Menu as PrimitiveMenu } from "ember-primitives/components/menu";

import type { TOC } from "@ember/component/template-only";
import type { ComponentLike } from "@glint/template";

export interface Signature {
  Element: null;
  Args: {
    /**
     * Color variant for the trigger button.
     *
     * `bare` removes the button chrome entirely (background, border,
     * shadow) so the trigger can align with surrounding content —
     * e.g. as a sidebar's account switcher.
     */
    variant?: "primary" | "secondary" | "danger" | "default" | "bare";
    /**
     * Placement of the menu content relative to the trigger.
     * Uses floating-ui placement values.
     *
     * Defaults to "bottom-start" (aligned with the left edge of the trigger).
     */
    placement?: string;
  };
  Blocks: {
    default: [
      {
        Trigger: ComponentLike<{ Element: HTMLButtonElement; Blocks: { default: [] } }>;
        Content: ComponentLike<{
          Element: HTMLDivElement;
          Blocks: {
            default: [
              {
                Item: ComponentLike<{
                  Element: HTMLButtonElement;
                  Args: { onSelect?: (event: Event) => void };
                  Blocks: { default: [] };
                }>;
                LinkItem: ComponentLike<{
                  Element: HTMLAnchorElement;
                  Args: { href: string };
                  Blocks: { default: [] };
                }>;
                Separator: ComponentLike<{ Element: HTMLDivElement }>;
              },
            ];
          };
        }>;
      },
    ];
  };
}

export const Menu: TOC<Signature> = <template>
  <PrimitiveMenu
    @placement={{if @placement @placement "bottom-start"}}
    @offsetOptions={{6}}
    as |menu|
  >
    {{yield
      (hash
        Trigger=(component StyledTrigger Trigger=menu.Trigger variant=@variant)
        Content=(component StyledContent Content=menu.Content isOpen=menu.isOpen)
      )
    }}
  </PrimitiveMenu>
</template>;

const StyledTrigger = <template>
  <@Trigger class="nvp__menu__trigger" data-variant={{@variant}} ...attributes>
    {{yield}}
  </@Trigger>
</template>;

const showPopover = modifier((element: HTMLElement) => {
  element.showPopover();
});

const StyledContent = <template>
  <@Content class="nvp__menu__content surface elevation-xl" ...attributes as |items|>
    {{yield
      (hash
        Item=(component StyledItem Item=items.Item)
        LinkItem=(component StyledLinkItem LinkItem=items.LinkItem)
        Separator=(component StyledSeparator Separator=items.Separator)
      )
    }}
  </@Content>
  {{#if @isOpen}}
    {{! The menu content is in the top layer, and the hints anchor to it.
        An anchor is usable only when it is earlier in the top layer,
        so the hints join the top layer after the content. }}
    <div popover="manual" class="nvp__menu__kbd-hints surface elevation-lg" {{showPopover}}>
      press
      <Key>esc</Key>
      to close
    </div>
  {{/if}}
</template>;

const StyledItem = <template>
  <@Item class="nvp__menu__item" @onSelect={{@onSelect}} ...attributes>
    {{yield}}
  </@Item>
</template>;

const StyledLinkItem = <template>
  <@LinkItem class="nvp__menu__link-item" @href={{@href}} ...attributes>
    {{yield}}
  </@LinkItem>
</template>;

const StyledSeparator = <template>
  <@Separator class="nvp__menu__separator" ...attributes />
</template>;
