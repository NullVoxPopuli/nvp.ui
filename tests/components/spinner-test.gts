import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Spinner } from "#src/index.ts";

module("Spinner", function (hooks) {
  setupRenderingTest(hooks);

  test("renders with default size and speed", async function (assert) {
    await render(<template><Spinner /></template>);

    assert.dom(".nvp__spinner").exists();
    assert.dom(".nvp__spinner").hasAttribute("role", "status");
    assert.dom(".nvp__spinner").hasAttribute("aria-label", "Loading");
    assert.dom(".nvp__spinner").hasAttribute("data-size", "medium");
    assert.dom(".nvp__spinner").hasAttribute("data-speed", "normal");
    assert.dom(".nvp__spinner__ring").exists();
  });

  test("renders with small size", async function (assert) {
    await render(<template><Spinner @size="small" /></template>);

    assert.dom(".nvp__spinner").hasAttribute("data-size", "small");
  });

  test("renders with large size", async function (assert) {
    await render(<template><Spinner @size="large" /></template>);

    assert.dom(".nvp__spinner").hasAttribute("data-size", "large");
  });

  test("renders with fast speed", async function (assert) {
    await render(<template><Spinner @speed="fast" /></template>);

    assert.dom(".nvp__spinner").hasAttribute("data-speed", "fast");
  });

  test("renders with slow speed", async function (assert) {
    await render(<template><Spinner @speed="slow" /></template>);

    assert.dom(".nvp__spinner").hasAttribute("data-speed", "slow");
  });

  test("splats attributes", async function (assert) {
    await render(<template><Spinner data-test-spinner /></template>);

    assert.dom("[data-test-spinner]").exists();
    assert.dom("[data-test-spinner]").hasClass("nvp__spinner");
  });
});
