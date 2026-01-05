import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Avatar } from "#src/index.ts";

module("Avatar", function (hooks) {
  setupRenderingTest(hooks);

  test("it renders with an image", async function (assert) {
    await render(
      <template>
        <Avatar @src="https://via.placeholder.com/150" @alt="Test Avatar" />
      </template>,
    );

    assert.dom("[data-prim-avatar]").exists();
    assert.dom(".nvp__avatar").exists();
  });

  test("it renders fallback when no src provided", async function (assert) {
    await render(
      <template>
        <Avatar @src="" @alt="Test Avatar" />
      </template>,
    );

    assert.dom(".nvp__avatar").exists();
    // The fallback should appear after the delay when the image fails to load
    await new Promise((resolve) => setTimeout(resolve, 300));
    assert.dom(".nvp__avatar__fallback").exists();
  });

  test("it accepts size variant", async function (assert) {
    await render(
      <template>
        <Avatar @src="https://via.placeholder.com/150" @alt="Test Avatar" @size="small" />
      </template>,
    );

    assert.dom(".nvp__avatar[data-size='small']").exists();
  });

  test("it renders custom fallback content", async function (assert) {
    await render(
      <template>
        <Avatar @src="" @alt="Test Avatar">
          <:fallback>
            <span class="custom-fallback">AB</span>
          </:fallback>
        </Avatar>
      </template>,
    );

    // Wait for the fallback to appear after delay
    await new Promise((resolve) => setTimeout(resolve, 300));
    assert.dom(".custom-fallback").exists();
    assert.dom(".custom-fallback").hasText("AB");
  });
});
