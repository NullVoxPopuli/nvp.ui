import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { ShimmerText } from "#src/index.ts";

module("ShimmerText", function (hooks) {
  setupRenderingTest(hooks);

  test("renders with shimmer class", async function (assert) {
    await render(
      <template>
        <ShimmerText>Hello World</ShimmerText>
      </template>,
    );

    assert.dom(".nvp__shimmer-text").exists();
    assert.dom(".nvp__shimmer-text").hasText("Hello World");
  });

  test("splats attributes", async function (assert) {
    await render(
      <template>
        <ShimmerText data-test-shimmer>Text</ShimmerText>
      </template>,
    );

    assert.dom("[data-test-shimmer]").exists();
    assert.dom("[data-test-shimmer]").hasClass("nvp__shimmer-text");
  });
});
