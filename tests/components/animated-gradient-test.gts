import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { AnimatedGradient } from "#src/index.ts";

module("AnimatedGradient", function (hooks) {
  setupRenderingTest(hooks);

  test("renders a canvas element", async function (assert) {
    await render(<template><AnimatedGradient style="width: 200px; height: 100px;" /></template>);

    assert.dom(".nvp__animated-gradient").exists();
    assert.dom(".nvp__animated-gradient__canvas").exists();
  });

  test("renders content on top of gradient", async function (assert) {
    await render(
      <template>
        {{! template-lint-disable no-inline-styles }}
        <AnimatedGradient style="width: 200px; height: 100px;">
          <p data-test-content>Hello</p>
        </AnimatedGradient>
      </template>,
    );

    assert.dom(".nvp__animated-gradient__content").exists();
    assert.dom("[data-test-content]").hasText("Hello");
  });

  test("splats attributes on container", async function (assert) {
    await render(
      <template>
        <AnimatedGradient data-test-gradient style="width: 200px; height: 100px;" />
      </template>,
    );

    assert.dom("[data-test-gradient]").exists();
    assert.dom("[data-test-gradient]").hasClass("nvp__animated-gradient");
  });
});
