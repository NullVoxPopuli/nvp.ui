// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck
import "./variables.css";
import "./focus.css";
import "./menu.css";

import { hash } from "@ember/helper";

import { Key } from "ember-primitives/components/keys";
import { Menu as PrimitiveMenu } from "ember-primitives/components/menu";

import type { TOC } from "@ember/component/template-only";
import type { ComponentLike } from "@glint/template";

export interface Signature {
  Element: null;
  Args: {
    /**
     * Color variant for the trigger button
     */
    variant?: "primary" | "secondary" | "danger" | "default";
    /**
     * Placement of the menu content relative to the trigger.
     * Uses floating-ui placement values.
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
  <PrimitiveMenu @placement={{@placement}} as |menu|>
    {{yield
      (hash
        Trigger=(component StyledTrigger Trigger=menu.Trigger variant=@variant)
        Content=(component StyledContent Content=menu.Content)
      )
    }}
  </PrimitiveMenu>
</template>;

const StyledTrigger = <template>
  <@Trigger class="nvp__menu__trigger" data-variant={{@variant}} ...attributes>
    {{yield}}
  </@Trigger>
</template>;

const StyledContent = <template>
  <@Content class="nvp__menu__content surface elevation-lg" ...attributes as |items|>
    {{yield
      (hash
        Item=(component StyledItem Item=items.Item)
        LinkItem=(component StyledLinkItem LinkItem=items.LinkItem)
        Separator=(component StyledSeparator Separator=items.Separator)
      )
    }}
    <div class="nvp__menu__kbd-hints">
      press
      <Key>esc</Key>
      to close
    </div>
  </@Content>
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
