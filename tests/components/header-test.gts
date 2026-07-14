import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Header } from "#src/index.ts";

module("Header", function (hooks) {
  setupRenderingTest(hooks);

  test("it defaults to auto positioning", async function (assert) {
    await render(
      <template>
        <Header>
          <:left>
            <span data-test-left>Left Content</span>
          </:left>
          <:right>
            <span data-test-right>Right Content</span>
          </:right>
        </Header>
      </template>,
    );

    assert.dom("header").exists();
    assert.dom("header").hasClass("nvp__header");
    assert.dom("[data-test-left]").hasText("Left Content");
    assert.dom("[data-test-right]").hasText("Right Content");
    assert.dom("header").hasAttribute("data-position", "auto");
  });

  test("it works with top positioning", async function (assert) {
    await render(
      <template>
        <Header @position="top">
          <:left>
            <span>Left</span>
          </:left>
          <:right>
            <span>Right</span>
          </:right>
        </Header>
      </template>,
    );

    assert.dom("header").exists();
    assert.dom("header").hasAttribute("data-position", "top");
  });

  test("it works with bottom positioning", async function (assert) {
    await render(
      <template>
        <Header @position="bottom">
          <:left>
            <span data-test-left>Footer Left</span>
          </:left>
          <:right>
            <span data-test-right>Footer Right</span>
          </:right>
        </Header>
      </template>,
    );

    assert.dom("header").exists();
    assert.dom("header").hasAttribute("data-position", "bottom");
    assert.dom("[data-test-left]").hasText("Footer Left");
    assert.dom("[data-test-right]").hasText("Footer Right");
  });

  test("left and right content are properly separated", async function (assert) {
    await render(
      <template>
        <Header>
          <:left>
            <a href="/">Home</a>
          </:left>
          <:right>
            <button type="button">Action</button>
          </:right>
        </Header>
      </template>,
    );

    assert.dom(".nvp__header__left").exists();
    assert.dom(".nvp__header__right").exists();
    assert.dom(".nvp__header__left a").hasText("Home");
    assert.dom(".nvp__header__right button").hasText("Action");
  });

  module("auto positioning (container queries)", function () {
    function headerStyles() {
      const header = document.querySelector(".nvp__header");

      if (!header) throw new Error("header not found");

      const styles = getComputedStyle(header);

      return { top: styles.top, bottom: styles.bottom, order: styles.order };
    }

    test("wide containers keep the header at the top", async function (assert) {
      await render(
        <template>
          <div
            style="container-type: size; width: 900px; height: 300px; display: flex; flex-direction: column;"
          >
            <Header>
              <:left>wide</:left>
            </Header>
          </div>
        </template>,
      );

      const { top, order } = headerStyles();

      assert.strictEqual(top, "0px", "sticks to the top");
      assert.strictEqual(order, "0", "keeps its DOM order");
    });

    test("narrow containers move the header to the bottom", async function (assert) {
      await render(
        <template>
          <div
            style="container-type: size; width: 320px; height: 480px; display: flex; flex-direction: column;"
          >
            <Header>
              <:left>narrow</:left>
            </Header>
          </div>
        </template>,
      );

      const { top, bottom, order } = headerStyles();

      assert.strictEqual(top, "auto", "no longer pinned to the top");
      assert.strictEqual(bottom, "0px", "sticks to the bottom");
      assert.strictEqual(order, "1", "column layouts place it last");
    });

    test("tall (portrait) containers move the header to the bottom, even when wider than the narrow breakpoint", async function (assert) {
      await render(
        <template>
          <div
            style="container-type: size; width: 600px; height: 700px; display: flex; flex-direction: column;"
          >
            <Header>
              <:left>tall</:left>
            </Header>
          </div>
        </template>,
      );

      const { bottom, order } = headerStyles();

      assert.strictEqual(bottom, "0px", "sticks to the bottom");
      assert.strictEqual(order, "1", "column layouts place it last");
    });

    test("inline-size containers (like ApplicationShell's wrapper) flip on width only", async function (assert) {
      await render(
        <template>
          <div style="container-type: inline-size; width: 400px;">
            <Header>
              <:left>narrow, width-only</:left>
            </Header>
          </div>
        </template>,
      );

      const { bottom, order } = headerStyles();

      assert.strictEqual(bottom, "0px", "narrow still flips without size containment");
      assert.strictEqual(order, "1", "column layouts place it last");
    });

    test("explicit @position='top' ignores the container", async function (assert) {
      await render(
        <template>
          <div
            style="container-type: size; width: 320px; height: 480px; display: flex; flex-direction: column;"
          >
            <Header @position="top">
              <:left>always top</:left>
            </Header>
          </div>
        </template>,
      );

      const { top, order } = headerStyles();

      assert.strictEqual(top, "0px", "stays at the top");
      assert.strictEqual(order, "0", "keeps its DOM order");
    });
  });
});
