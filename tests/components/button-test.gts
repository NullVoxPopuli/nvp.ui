import { on } from "@ember/modifier";
import { click, render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { TrackedObject } from "tracked-built-ins";

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

  test("splatted attributes land on the underlying button", async function (assert) {
    await render(
      <template>
        <Button aria-pressed="true" data-test-mute>Mute</Button>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "true");
    assert.dom(".nvp__button").hasAttribute("data-test-mute");
  });

  test("without splatted attributes, none are present", async function (assert) {
    await render(
      <template>
        <Button>Click me</Button>
      </template>,
    );

    assert.dom(".nvp__button").doesNotHaveAttribute("aria-pressed");
  });

  test("splatted class merges with the component's own class", async function (assert) {
    await render(
      <template>
        <Button class="custom-class">Click me</Button>
      </template>,
    );

    assert.dom(".nvp__button").hasClass("nvp__button");
    assert.dom(".nvp__button").hasClass("custom-class");
  });

  test("splatted attributes update reactively", async function (assert) {
    const state = new TrackedObject({ pressed: false });
    const toggle = () => (state.pressed = !state.pressed);

    await render(
      <template>
        <Button aria-pressed="{{if state.pressed 'true' 'false'}}" @onClick={{toggle}}>
          Mute
        </Button>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "false");

    await click(".nvp__button");

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "true");

    await click(".nvp__button");

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "false");
  });

  test("{{on 'click'}} via splattributes fires", async function (assert) {
    const handleClick = () => assert.step("clicked");

    await render(
      <template>
        <Button {{on "click" handleClick}}>Click me</Button>
      </template>,
    );

    await click(".nvp__button");

    assert.verifySteps(["clicked"]);
  });

  test("a disabled toggle still shows its reason and does not call @onClick", async function (assert) {
    const handleClick = () => assert.step("clicked");

    await render(
      <template>
        <Button aria-pressed="true" @disabled="Reason for being disabled" @onClick={{handleClick}}>
          Mute
        </Button>
      </template>,
    );

    assert.dom(".nvp__button").hasAttribute("aria-pressed", "true");
    assert.dom(".nvp__button").hasAttribute("aria-disabled");
    assert.dom(".nvp__button__disabled-reason").hasText("Reason for being disabled");

    await click(".nvp__button");

    assert.verifySteps([]);
  });

  test("{{on 'click'}} via splattributes is NOT suppressed by @disabled", async function (assert) {
    // Unlike @onClick, event listeners attached via splattributes bind
    // directly to the element, so the component cannot intercept them.
    // The button uses aria-disabled (not the disabled attribute) so that
    // the "why disabled" popover stays focusable, which means the browser
    // does not suppress these events either.
    //
    // This test documents that tradeoff: use @onClick when the action
    // should be suppressed while disabled.
    const handleClick = () => assert.step("clicked");

    await render(
      <template>
        <Button @disabled="Reason for being disabled" {{on "click" handleClick}}>
          Click me
        </Button>
      </template>,
    );

    await click(".nvp__button");

    assert.verifySteps(["clicked"]);
  });
});
