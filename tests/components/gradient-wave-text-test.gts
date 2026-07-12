import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { GradientWaveText } from "#src/index.ts";

module("GradientWaveText", function (hooks) {
  setupRenderingTest(hooks);

  test("renders with gradient wave class", async function (assert) {
    await render(
      <template>
        <GradientWaveText>Just ship things.</GradientWaveText>
      </template>,
    );

    assert.dom(".nvp__gradient-wave-text").exists();
    assert.dom(".nvp__gradient-wave-text").hasText("Just ship things.");
  });

  test("splats attributes", async function (assert) {
    await render(
      <template>
        <GradientWaveText data-test-wave>Text</GradientWaveText>
      </template>,
    );

    assert.dom("[data-test-wave]").exists();
    assert.dom("[data-test-wave]").hasClass("nvp__gradient-wave-text");
  });
});
