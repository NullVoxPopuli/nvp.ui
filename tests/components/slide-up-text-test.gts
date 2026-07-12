import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { SlideUpText } from "#src/index.ts";

module("SlideUpText", function (hooks) {
  setupRenderingTest(hooks);

  test("renders and splits text into word spans", async function (assert) {
    await render(
      <template>
        <SlideUpText>Hello beautiful world</SlideUpText>
      </template>,
    );

    assert.dom(".nvp__slide-up-text").exists();
    assert.dom(".nvp__slide-up-text__word").exists({ count: 3 });
  });

  test("splats attributes", async function (assert) {
    await render(
      <template>
        <SlideUpText data-test-slide>Hello world</SlideUpText>
      </template>,
    );

    assert.dom("[data-test-slide]").exists();
    assert.dom("[data-test-slide]").hasClass("nvp__slide-up-text");
  });
});
