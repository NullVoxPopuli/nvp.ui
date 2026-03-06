import "./accordion.css";

// @ts-nocheck
import { Accordion as PrimitiveAccordion } from "ember-primitives/components/accordion";

import type { TOC } from "@ember/component/template-only";
import type { WithBoundArgs } from "@glint/template";

// Chevron icon
const Chevron: TOC<Record<string, never>> = <template>
  <svg
    class="nvp__accordion__chevron"
    xmlns="http://www.w3.org/2000/svg"
    height="1em"
    viewBox="0 0 512 512"
    fill="currentColor"
    aria-hidden="true"
  >
    {{! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. }}
    <path
      d="M233.4 406.6c12.5 12.5 32.8 12.5 45.3 0l192-192c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L256 338.7 86.6 169.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l192 192z"
    />
  </svg>
</template>;

const StyledItem: TOC<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  Args: { item: any };
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  Blocks: { default: [any] };
}> = <template>
  <@item class="nvp__accordion__item" as |i|>
    {{yield
      (object
        isExpanded=i.isExpanded
        Header=(component StyledHeader header=i.Header)
        Content=(component StyledContent content=i.Content)
      )
    }}
  </@item>
</template>;

const StyledHeader: TOC<{
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  Args: { header: any };
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  Blocks: { default: [any] };
}> = <template>
  <@header class="nvp__accordion__header" as |h|>
    {{yield (object Trigger=(component StyledTrigger trigger=h.Trigger))}}
  </@header>
</template>;

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const StyledTrigger: TOC<{ Args: { trigger: any }; Blocks: { default: [] } }> = <template>
  <@trigger class="nvp__accordion__trigger">
    {{yield}}
    <Chevron />
  </@trigger>
</template>;

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const StyledContent: TOC<{ Args: { content: any }; Blocks: { default: [] } }> = <template>
  <@content class="nvp__accordion__content">
    {{yield}}
  </@content>
</template>;

export interface Signature {
  Element: HTMLDivElement;
  Args:
    | {
        /**
         * Only one item can be open at a time.
         */
        type: "single";
        /**
         * Whether any item can be collapsed when it's already open.
         */
        collapsible?: boolean;
        disabled?: boolean;
      }
    | {
        /**
         * Multiple items can be open at once.
         */
        type: "multiple";
        disabled?: boolean;
      };
  Blocks: {
    default: [
      {
        /**
         * An accordion item. Must have a unique `@value`.
         */
        Item: WithBoundArgs<typeof StyledItem, "item">;
      },
    ];
  };
}

export const Accordion: TOC<Signature> = <template>
  <PrimitiveAccordion class="nvp__accordion" ...attributes as |a|>
    {{yield (object Item=(component StyledItem item=a.Item))}}
  </PrimitiveAccordion>
</template>;

function object<T extends object>(obj: T): T {
  return obj;
}
