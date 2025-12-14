import "./tabs.css";

import {
  type ButtonType,
  type ContainerType,
  type ContentType,
  Tabs as PrimitiveTabs,
} from "ember-primitives/components/tabs";

import type { TOC } from "@ember/component/template-only";
import type { ComponentLike, WithBoundArgs } from "@glint/template";

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

const StyledTab: TOC<
  | {
      Args: {
        tab: ContainerType;
        label: undefined;
        content: undefined;
      };
      Blocks: {
        button: [];
        content: [];
        default: never;
      };
    }
  | {
      Args: {
        tab: ContainerType;
        label: string | ComponentLike;
        content: undefined;
      };
      Blocks: {
        default: [];
        button: never;
        content: never;
      };
    }
  | {
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
> = <template>
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
    default: [WithBoundArgs<typeof StyledTab, "tab">];
  };
}> = <template>
  <PrimitiveTabs
    class="nvp__tabs"
    data-orientation={{or @orientation "top"}}
    data-variant={{or @variant "primary"}}
    as |Tab|
  >
    {{yield (component StyledTab tab=Tab)}}
  </PrimitiveTabs>
</template>;

function or(x: string | undefined, y: string) {
  return x ?? y;
}
