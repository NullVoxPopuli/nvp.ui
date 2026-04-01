import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { BrowserWindow } from "#src/index.ts";

module("BrowserWindow", function (hooks) {
  setupRenderingTest(hooks);

  test("renders with default macOS style", async function (assert) {
    await render(
      <template>
        <BrowserWindow>
          <p>Hello</p>
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window").exists();
    assert.dom(".nvp__browser-window").hasAttribute("data-os", "mac");
    assert.dom(".nvp__browser-window__header").exists();
    assert.dom(".nvp__browser-window__circles").exists();
    assert.dom(".nvp__browser-window__circle").exists({ count: 3 });
    assert.dom(".nvp__browser-window__body").hasText("Hello");
  });

  test("shows URL bar when @url is provided", async function (assert) {
    await render(
      <template>
        <BrowserWindow @url="https://example.com">
          content
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window__url").exists();
    assert.dom(".nvp__browser-window__url").hasText("https://example.com");
  });

  test("hides URL bar when @url is omitted", async function (assert) {
    await render(
      <template>
        <BrowserWindow>
          content
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window__url").doesNotExist();
  });

  test("sets data-flush attribute", async function (assert) {
    await render(
      <template>
        <BrowserWindow @flush={{true}}>
          content
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window").hasAttribute("data-flush", "true");
  });

  test("sets data-shadow attribute", async function (assert) {
    await render(
      <template>
        <BrowserWindow @shadow={{true}}>
          content
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window").hasAttribute("data-shadow", "true");
  });

  test("sets data-grayscale attribute", async function (assert) {
    await render(
      <template>
        <BrowserWindow @grayscale={{true}}>
          content
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window").hasAttribute("data-grayscale", "true");
  });

  test("spreads attributes", async function (assert) {
    await render(
      <template>
        <BrowserWindow data-test-id="my-window">
          content
        </BrowserWindow>
      </template>,
    );

    assert.dom("[data-test-id='my-window']").exists();
  });

  module("Windows style", function () {
    test("renders window controls instead of circles", async function (assert) {
      await render(
        <template>
          <BrowserWindow @os="windows" @url="https://example.com">
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window").hasAttribute("data-os", "windows");
      assert.dom(".nvp__browser-window__circles").doesNotExist();
      assert.dom(".nvp__browser-window__controls").exists();
      assert.dom(".nvp__browser-window__controls svg").exists({ count: 3 });
      assert.dom(".nvp__browser-window__url").exists();
    });
  });

  module("Ubuntu style", function () {
    test("renders controls on the right with URL bar", async function (assert) {
      await render(
        <template>
          <BrowserWindow @os="ubuntu" @url="https://example.com">
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window").hasAttribute("data-os", "ubuntu");
      assert.dom(".nvp__browser-window__circles").doesNotExist();
      assert.dom(".nvp__browser-window__controls").exists();
      assert.dom(".nvp__browser-window__controls svg").exists({ count: 3 });
      assert.dom(".nvp__browser-window__url").exists();
    });
  });

  module("Generic style", function () {
    test("renders no window controls", async function (assert) {
      await render(
        <template>
          <BrowserWindow @os="generic" @url="https://example.com">
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window").hasAttribute("data-os", "generic");
      assert.dom(".nvp__browser-window__circles").doesNotExist();
      assert.dom(".nvp__browser-window__controls").doesNotExist();
      assert.dom(".nvp__browser-window__url").exists();
    });
  });
});
