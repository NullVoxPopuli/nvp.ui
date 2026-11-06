/**
 * Type tests for `<Tabs as |Tab|>`.
 *
 * `pnpm lint:types` checks this file. Nothing runs it.
 *
 * - The template shows each way to write a tab, as an app writes it.
 * - The DSL calls below are what Glint makes of the template,
 *   so each case says which args and blocks the types accept.
 */
import { emitComponent, NamedArgsMarker, resolve } from "@glint/template/-private/dsl";
import { expectTypeOf } from "expect-type";

import { Tabs } from "../src/components/tabs.gts";

import type { TOC } from "@ember/component/template-only";

declare const Label: TOC<object>;

export const valid = <template>
  <Tabs as |Tab|>
    <Tab @label="Red" @content="Apple" />
    <Tab @label={{Label}} @content={{Label}} />

    <Tab @label="Yellow">Banana</Tab>
    <Tab @label={{Label}}>Banana</Tab>

    <Tab>
      <:button>Purple</:button>
      <:content>Blueberries</:content>
    </Tab>
  </Tabs>
</template>;

export const invalid = <template>
  <Tabs as |Tab|>
    {{! @glint-expect-error: @content needs a @label }}
    <Tab @content="Apple" />

    {{! @glint-expect-error: @label is a string or a component }}
    <Tab @label={{42}}>Apple</Tab>

    {{! @glint-expect-error: @content is a string or a component }}
    <Tab @label="Red" @content={{42}} />

    {{! @glint-expect-error: Tabs passes @tab }}
    <Tab @tab={{Label}} @label="Red" />

    {{! @glint-expect-error: no way to write a tab takes @color }}
    <Tab @label="Red" @color="red" />
  </Tabs>
</template>;

const tabs = emitComponent(resolve(Tabs)({ ...NamedArgsMarker }));
const [Tab] = tabs.blockParams.default;
const tab = resolve(Tab);

/**
 * `@label` and `@content`
 */
tab({ label: "Red", content: "Apple", ...NamedArgsMarker });
tab({ label: Label, content: Label, ...NamedArgsMarker });

/**
 * `@label`, with the default block for the tab panel.
 * The block has no block params.
 */
tab({ label: "Red", ...NamedArgsMarker });
expectTypeOf(
  emitComponent(tab({ label: "Red", ...NamedArgsMarker })).blockParams.default,
).toEqualTypeOf<[]>();

/**
 * No args, with the `<:button>` and `<:content>` blocks.
 */
tab();
expectTypeOf(emitComponent(tab()).blockParams.button).toEqualTypeOf<[]>();
expectTypeOf(emitComponent(tab()).blockParams.content).toEqualTypeOf<[]>();

// @ts-expect-error @content needs a @label
tab({ content: "Apple", ...NamedArgsMarker });

// @ts-expect-error @label is a string or a component
tab({ label: 42, ...NamedArgsMarker });

// @ts-expect-error @content is a string or a component
tab({ label: "Red", content: 42, ...NamedArgsMarker });

// @ts-expect-error Tabs passes @tab
tab({ tab: Label, label: "Red", ...NamedArgsMarker });

// @ts-expect-error no way to write a tab takes @color
tab({ label: "Red", color: "red", ...NamedArgsMarker });

/**
 * `@orientation` and `@variant` of `Tabs` take only the listed values.
 */
resolve(Tabs)({ orientation: "left", variant: "danger", ...NamedArgsMarker });
// @ts-expect-error not an orientation
resolve(Tabs)({ orientation: "middle", ...NamedArgsMarker });
// @ts-expect-error not a variant
resolve(Tabs)({ variant: "rainbow", ...NamedArgsMarker });
