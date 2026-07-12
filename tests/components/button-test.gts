import { click, render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Button } from "#src/index.ts";

module("Button", function (hooks) {
  setupRenderingTest(hooks);

  test("calls @onClick when clicked", async function (assert) {
    const handleClick = () => assert.step("clicked");

    await render(
      <template>
        <Button @onClick={{handleClick}}>Click me</Button>
      </template>,
    );

    assert.dom(".nvp__button").hasText("Click me");

    await click(".nvp__button");

    assert.verifySteps(["clicked"]);
  });

  test("does not call @onClick when disabled", async function (assert) {
    const handleClick = () => assert.step("clicked");

    await render(
      <template>
        <Button @disabled="Reason for being disabled" @onClick={{handleClick}}>
          Click me
        </Button>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("aria-disabled");

    await click(".nvp__button");

    assert.verifySteps([]);
  });

  test("can be clicked without an @onClick", async function (assert) {
    await render(
      <template>
        <Button>Click me</Button>
      </template>,
    );

    await click(".nvp__button");

    assert.dom(".nvp__button").hasText("Click me");
  });
});
