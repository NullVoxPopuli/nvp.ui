import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Marquee } from "#src/index.ts";

module("Marquee", function (hooks) {
  setupRenderingTest(hooks);

  test("renders with default direction", async function (assert) {
    await render(
      <template>
        <Marquee>
          <span>Item 1</span>
          <span>Item 2</span>
        </Marquee>
      </template>,
    );

    assert.dom(".nvp__marquee").exists();
    assert.dom(".nvp__marquee").hasAttribute("data-direction", "left");
    assert.dom(".nvp__marquee__track").exists();
  });

  test("duplicates content for seamless looping", async function (assert) {
    await render(
      <template>
        <Marquee>
          <span>Content</span>
        </Marquee>
      </template>,
    );

    assert.dom(".nvp__marquee__content").exists({ count: 2 });
  });

  test("marks duplicate as aria-hidden", async function (assert) {
    await render(
      <template>
        <Marquee>
          <span>Content</span>
        </Marquee>
      </template>,
    );

    const contents = document.querySelectorAll(".nvp__marquee__content");

    assert.strictEqual(contents.length, 2);
    assert.notOk(contents[0]?.getAttribute("aria-hidden"));
    assert.strictEqual(contents[1]?.getAttribute("aria-hidden"), "true");
  });

  test("sets direction attribute", async function (assert) {
    await render(
      <template>
        <Marquee @direction="right">
          <span>Content</span>
        </Marquee>
      </template>,
    );

    assert.dom(".nvp__marquee").hasAttribute("data-direction", "right");
  });

  test("sets pause-on-hover attribute", async function (assert) {
    await render(
      <template>
        <Marquee @pauseOnHover={{true}}>
          <span>Content</span>
        </Marquee>
      </template>,
    );

    assert.dom(".nvp__marquee").hasAttribute("data-pause-on-hover", "true");
  });

  test("sets fade attribute", async function (assert) {
    await render(
      <template>
        <Marquee @fade={{true}}>
          <span>Content</span>
        </Marquee>
      </template>,
    );

    assert.dom(".nvp__marquee").hasAttribute("data-fade", "true");
  });

  test("splats attributes", async function (assert) {
    await render(
      <template>
        <Marquee data-test-marquee>
          <span>Content</span>
        </Marquee>
      </template>,
    );

    assert.dom("[data-test-marquee]").exists();
    assert.dom("[data-test-marquee]").hasClass("nvp__marquee");
  });
});
