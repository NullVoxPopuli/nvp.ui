import "./tabs.css";

import {
  type ButtonType,
  type ContainerType,
  type ContentType,
  Tabs as PrimitiveTabs,
} from "ember-primitives/components/tabs";

import type { TOC } from "@ember/component/template-only";
import type { ComponentLike } from "@glint/template";

function isString(x: unknown): x is string {
  return typeof x === "string";
}

const StyledButton: TOC<{ Args: { button: ButtonType }; Blocks: { default: [] } }> = <template>
  <@button class="nvp__tabs__tab surface">
    {{yield}}
  </@button>
</template>;

const StyledContent: TOC<{ Args: { content: ContentType }; Blocks: { default: [] } }> = <template>
  <@content class="nvp__tabs__tabpanel surface">
    {{yield}}
  </@content>
</template>;

/**
 * A tab with the `<:button>` and `<:content>` blocks.
 */
interface BlocksTab {
  Args: {
    tab: ContainerType;
    label?: undefined;
    content?: undefined;
  };
  Blocks: {
    button: [];
    content: [];
    default: never;
  };
}

/**
 * A tab with `@label`, and the default block for the tab panel.
 */
interface LabelTab {
  Args: {
    tab: ContainerType;
    label: string | ComponentLike;
    content?: undefined;
  };
  Blocks: {
    default: [];
    button: never;
    content: never;
  };
}

/**
 * A tab with `@label` and `@content`.
 */
interface LabelContentTab {
  Args: {
    label: string | ComponentLike;
    content: string | ComponentLike;
    tab: ContainerType;
  };
  Blocks: {
    default: [];
    button: never;
    content: never;
  };
}

/**
 * `WithBoundArgs` removes `tab` from the union as a whole,
 * which loses which args go together.
 * This removes it from each way to write a tab on its own.
 */
type Bound<S> = S extends { Args: infer A; Blocks: infer B }
  ? { Args: Omit<A, "tab">; Blocks: B }
  : never;

export type Tab = ComponentLike<Bound<BlocksTab | LabelTab | LabelContentTab>>;

const StyledTab: TOC<BlocksTab | LabelTab | LabelContentTab> = <template>
  <@tab as |UnstyledButton UnstyledContent|>
    {{#let
      (component StyledButton button=UnstyledButton)
      (component StyledContent content=UnstyledContent)
      as |Button Content|
    }}

      {{#if @label}}
        <Button>
          {{#if (isString @label)}}
            {{@label}}
          {{else}}
            <@label />
          {{/if}}
        </Button>

        <Content>
          {{#if @content}}
            {{#if (isString @content)}}
              {{@content}}
            {{else}}
              <@content />
            {{/if}}
          {{else}}
            {{yield}}
          {{/if}}
        </Content>
      {{else}}
        <Button>
          {{yield to="button"}}
        </Button>
        <Content>
          {{yield to="content"}}
        </Content>
      {{/if}}
    {{/let}}
  </@tab>
</template>;

export const Tabs: TOC<{
  Args: {
    /**
     * Override the default tab orientation relative to the tabpanel content
     *
     * Default: top
     */
    orientation?: "top" | "left" | "right" | "bottom";

    /**
     * Override the default selection color to the tablist.
     * This is the color to indicate the active tab.
     *
     * Default: 'primary'
     */
    variant?: "primary" | "secondary" | "danger";
  };
  Blocks: {
    default: [Tab];
  };
}> = <template>
  <PrimitiveTabs
    class="nvp__tabs"
    data-orientation={{or @orientation "top"}}
    data-variant={{or @variant "primary"}}
    as |Tab|
  >
    {{! @glint-expect-error }}
    {{yield (component StyledTab tab=Tab)}}
  </PrimitiveTabs>
</template>;

function or(x: string | undefined, y: string) {
  return x ?? y;
}
