import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Badge } from "#src/index.ts";

module("Badge", function (hooks) {
  setupRenderingTest(hooks);

  test("renders with default styling", async function (assert) {
    await render(
      <template>
        <Badge>Default</Badge>
      </template>,
    );

    assert.dom(".nvp__badge").exists();
    assert.dom(".nvp__badge").hasText("Default");
  });

  test("renders with primary variant", async function (assert) {
    await render(
      <template>
        <Badge @variant="primary">Primary</Badge>
      </template>,
    );

    assert.dom(".nvp__badge").hasAttribute("data-variant", "primary");
  });

  test("renders with secondary variant", async function (assert) {
    await render(
      <template>
        <Badge @variant="secondary">Secondary</Badge>
      </template>,
    );

    assert.dom(".nvp__badge").hasAttribute("data-variant", "secondary");
  });

  test("renders with danger variant", async function (assert) {
    await render(
      <template>
        <Badge @variant="danger">Danger</Badge>
      </template>,
    );

    assert.dom(".nvp__badge").hasAttribute("data-variant", "danger");
  });

  test("renders with small size", async function (assert) {
    await render(
      <template>
        <Badge @size="small">Small</Badge>
      </template>,
    );

    assert.dom(".nvp__badge").hasAttribute("data-size", "small");
  });

  test("splats attributes", async function (assert) {
    await render(
      <template>
        <Badge data-test-badge>Content</Badge>
      </template>,
    );

    assert.dom("[data-test-badge]").exists();
    assert.dom("[data-test-badge]").hasClass("nvp__badge");
  });
});
