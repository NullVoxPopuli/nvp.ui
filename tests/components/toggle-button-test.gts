import { click, render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { TrackedObject } from "tracked-built-ins";

import { ToggleButton } from "#src/index.ts";

module("ToggleButton", function (hooks) {
  setupRenderingTest(hooks);

  test("@pressed={{true}} renders aria-pressed='true'", async function (assert) {
    await render(
      <template>
        <ToggleButton @pressed={{true}}>Mute</ToggleButton>
      </template>,
    );

    assert.dom(".nvp__button").hasText("Mute");
    assert.dom(".nvp__button").hasAttribute("aria-pressed", "true");
  });

  test("@pressed={{false}} renders aria-pressed='false'", async function (assert) {
    await render(
      <template>
        <ToggleButton @pressed={{false}}>Mute</ToggleButton>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "false");
  });

  test("toggles via @onClick", async function (assert) {
    const state = new TrackedObject({ pressed: false });
    const toggle = () => (state.pressed = !state.pressed);

    await render(
      <template>
        <ToggleButton @pressed={{state.pressed}} @onClick={{toggle}}>Mute</ToggleButton>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "false");

    await click(".nvp__button");

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "true");

    await click(".nvp__button");

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "false");
  });

  test("when disabled, still shows the reason and does not call @onClick", async function (assert) {
    const handleClick = () => assert.step("clicked");

    await render(
      <template>
        <ToggleButton
          @pressed={{true}}
          @disabled="Reason for being disabled"
          @onClick={{handleClick}}
        >
          Mute
        </ToggleButton>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "true");
    assert.dom(".nvp__button").hasAttribute("aria-disabled");
    assert.dom(".nvp__button__disabled-reason").hasText("Reason for being disabled");

    await click(".nvp__button");

    assert.verifySteps([]);
  });

  test("forwards @variant and splatted attributes to the underlying button", async function (assert) {
    await render(
      <template>
        <ToggleButton @pressed={{false}} @variant="primary" data-test-mute>Mute</ToggleButton>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("data-variant", "primary");
    assert.dom(".nvp__button").hasAttribute("data-test-mute");
  });
});
