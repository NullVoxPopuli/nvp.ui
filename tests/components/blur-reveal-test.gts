import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { BlurReveal } from "#src/index.ts";

module("BlurReveal", function (hooks) {
  setupRenderingTest(hooks);

  test("renders and splits text into character spans", async function (assert) {
    await render(
      <template>
        <BlurReveal>Hello</BlurReveal>
      </template>,
    );

    assert.dom(".nvp__blur-reveal").exists();
    assert.dom(".nvp__blur-reveal__char").exists({ count: 5 });
  });

  test("preserves spaces", async function (assert) {
    await render(
      <template>
        <BlurReveal>Hi there</BlurReveal>
      </template>,
    );

    assert.dom(".nvp__blur-reveal__space").exists({ count: 1 });
  });

  test("splats attributes", async function (assert) {
    await render(
      <template>
        <BlurReveal data-test-blur>Text</BlurReveal>
      </template>,
    );

    assert.dom("[data-test-blur]").exists();
    assert.dom("[data-test-blur]").hasClass("nvp__blur-reveal");
  });
});
