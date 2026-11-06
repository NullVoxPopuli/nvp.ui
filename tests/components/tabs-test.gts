import { click, render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Tabs } from "#src/components/tabs.gts";

/**
 * Never rendered. `pnpm lint:types` fails if one of these is not a type error.
 */
const invalidTabs = <template>
  <Tabs as |Tab|>
    {{! @glint-expect-error: @content needs a @label }}
    <Tab @content="Apple" />

    {{! @glint-expect-error: @label is a string or a component }}
    <Tab @label={{42}}>Apple</Tab>
  </Tabs>
</template>;

module("Tabs", function (hooks) {
  setupRenderingTest(hooks);

  test("invalid tabs are type errors", function (assert) {
    assert.ok(invalidTabs, "see the @glint-expect-error comments above");
  });

  test("@label and @content", async function (assert) {
    await render(
      <template>
        <Tabs as |Tab|>
          <Tab @label="Red" @content="Apple" />
          <Tab @label="Yellow" @content="Banana" />
        </Tabs>
      </template>,
    );

    assert.dom('[role="tab"]').exists({ count: 2 });
    assert.dom('[role="tabpanel"]').hasText("Apple");

    await click('[role="tab"]:nth-of-type(2)');

    assert.dom('[role="tabpanel"]').hasText("Banana");
  });

  test("@label with the default block for the content", async function (assert) {
    await render(
      <template>
        <Tabs as |Tab|>
          <Tab @label="Red">Apple</Tab>
          <Tab @label="Yellow">Banana</Tab>
        </Tabs>
      </template>,
    );

    assert.dom('[role="tab"]').exists({ count: 2 });
    assert.dom('[role="tabpanel"]').hasText("Apple");
  });

  test("named blocks for the button and the content", async function (assert) {
    await render(
      <template>
        <Tabs as |Tab|>
          <Tab>
            <:button>Red</:button>
            <:content>Apple</:content>
          </Tab>
        </Tabs>
      </template>,
    );

    assert.dom('[role="tab"]').hasText("Red");
    assert.dom('[role="tabpanel"]').hasText("Apple");
  });
});
