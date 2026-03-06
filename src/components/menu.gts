import "./menu.css";

// @ts-nocheck
import {
  type ContentSignature,
  type ItemSignature,
  type LinkItemSignature,
  Menu as PrimitiveMenu,
  type Signature as PrimitiveSignature,
  type TriggerSignature,
} from "ember-primitives/components/menu";

import type { TOC } from "@ember/component/template-only";
import type { WithBoundArgs } from "@glint/template";

type PrimitiveMenuYields = PrimitiveSignature["Blocks"]["default"][0];
type ContentYields = ContentSignature["Blocks"]["default"][0];

const StyledItem: TOC<{
  Element: ItemSignature["Element"];
  Args: ItemSignature["Args"] & { item: ContentYields["Item"] };
  Blocks: { default: [] };
}> = <template>
  <@item class="nvp__menu__item" @onSelect={{@onSelect}} ...attributes>
    {{yield}}
  </@item>
</template>;

const StyledLinkItem: TOC<{
  Element: HTMLAnchorElement;
  Args: LinkItemSignature["Args"] & { linkItem: ContentYields["LinkItem"] };
  Blocks: { default: [] };
}> = <template>
  {{! @glint-expect-error: href is passed via ...attributes spread }}
  <@linkItem class="nvp__menu__item" ...attributes>
    {{yield}}
  </@linkItem>
</template>;

const StyledSeparator: TOC<{ Element: HTMLDivElement; Blocks: { default: [] } }> = <template>
  <div class="nvp__menu__separator" role="separator" ...attributes>
    {{yield}}
  </div>
</template>;

const StyledContent: TOC<{
  Args: { content: PrimitiveMenuYields["Content"] };
  Blocks: {
    default: [
      {
        Item: WithBoundArgs<typeof StyledItem, "item">;
        LinkItem: WithBoundArgs<typeof StyledLinkItem, "linkItem">;
        Separator: typeof StyledSeparator;
      },
    ];
  };
}> = <template>
  <@content class="nvp__menu__content" as |c|>
    {{yield
      (object
        Item=(component StyledItem item=c.Item)
        LinkItem=(component StyledLinkItem linkItem=c.LinkItem)
        Separator=StyledSeparator
      )
    }}
  </@content>
</template>;

const StyledTrigger: TOC<{
  Element: TriggerSignature["Element"];
  Args: { trigger: PrimitiveMenuYields["Trigger"] };
  Blocks: { default: [] };
}> = <template>
  <@trigger class="nvp__menu__trigger" ...attributes>
    {{yield}}
  </@trigger>
</template>;

export interface Signature {
  Blocks: {
    default: [
      {
        /**
         * Use to trigger the menu opening.
         * Must be rendered.
         */
        Trigger: WithBoundArgs<typeof StyledTrigger, "trigger">;

        /**
         * The content of the menu.
         * Must be rendered.
         */
        Content: WithBoundArgs<typeof StyledContent, "content">;

        /**
         * Whether the menu is open.
         */
        isOpen: boolean;
      },
    ];
  };
}

export const Menu: TOC<Signature> = <template>
  <PrimitiveMenu as |m|>
    {{yield
      (object
        Trigger=(component StyledTrigger trigger=m.Trigger)
        Content=(component StyledContent content=m.Content)
        isOpen=m.isOpen
      )
    }}
  </PrimitiveMenu>
</template>;

function object<T extends object>(obj: T): T {
  return obj;
}
