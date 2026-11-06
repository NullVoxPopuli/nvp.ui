import { click, render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Tabs } from "#src/components/tabs.gts";

module("Tabs", function (hooks) {
  setupRenderingTest(hooks);

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
