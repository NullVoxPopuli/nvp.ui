import "./variables.css";
import "./focus.css";
import "./menu.css";

import { hash } from "@ember/helper";

import { Menu as PrimitiveMenu } from "ember-primitives/components/menu";

import type { TOC } from "@ember/component/template-only";

// Wrapper for Menu.Content that applies styling to child items
const StyledContent: TOC<{
  Args: { Content: unknown };
  Blocks: { default: [unknown] };
}> = <template>
  {{! @glint-ignore }}
  <@Content class="nvp__menu__content surface elevation-lg" as |Items|>
    {{yield
      (hash
        Item=(component Items.Item class="nvp__menu__item")
        LinkItem=(component Items.LinkItem class="nvp__menu__item")
        Separator=(component Items.Separator class="nvp__menu__separator")
      )
    }}
  </@Content>
</template>;

export interface Signature {
  /**
   * The underlying menu element is not exposed,
   * as doing so could lead to misuse.
   */
  Element: null;
  Args: {
    /**
     * Whether the menu should be rendered inline (default: false)
     */
    inline?: boolean;

    /**
     * Placement of the menu relative to the trigger
     * Default: 'bottom-start'
     */
    placement?:
      | "top"
      | "top-start"
      | "top-end"
      | "right"
      | "right-start"
      | "right-end"
      | "bottom"
      | "bottom-start"
      | "bottom-end"
      | "left"
      | "left-start"
      | "left-end";

    /**
     * What colors to make the trigger button.
     */
    variant?: "danger" | "primary" | "secondary" | "default" | undefined;
  };
  Blocks: {
    /**
     * Menu content - receives menu helpers including Trigger, Content, and trigger
     */
    default: [
      {
        Trigger: unknown;
        Content: unknown;
        trigger: unknown;
        isOpen: boolean;
      },
    ];
  };
}

export const Menu: TOC<Signature> = <template>
  <PrimitiveMenu @inline={{@inline}} @placement={{@placement}} as |menu|>
    {{! @glint-ignore }}
    {{yield
      (hash
        Trigger=(component menu.Trigger class="nvp__menu__trigger" data-variant=@variant)
        Content=(component StyledContent Content=menu.Content)
        trigger=menu.trigger
        isOpen=menu.isOpen
      )
    }}
  </PrimitiveMenu>
</template>;
