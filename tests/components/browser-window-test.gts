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

  module("Tabs", function () {
    const tabs = ["Home", "About", "Contact"];

    test("renders tab bar with tabs", async function (assert) {
      await render(
        <template>
          <BrowserWindow @tabs={{tabs}}>
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window__tabs").exists();
      assert.dom(".nvp__browser-window__tab").exists({ count: 3 });
      assert.dom(".nvp__browser-window__tab:nth-child(1)").hasText("Home");
      assert.dom(".nvp__browser-window__tab:nth-child(2)").hasText("About");
      assert.dom(".nvp__browser-window__tab:nth-child(3)").hasText("Contact");
    });

    test("marks the first tab as active", async function (assert) {
      await render(
        <template>
          <BrowserWindow @tabs={{tabs}}>
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window__tab:nth-child(1)").hasAttribute("data-active", "true");
      assert.dom(".nvp__browser-window__tab:nth-child(2)").doesNotHaveAttribute("data-active");
    });

    test("shows toolbar with nav buttons when tabs are present", async function (assert) {
      await render(
        <template>
          <BrowserWindow @tabs={{tabs}} @url="https://example.com">
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window__toolbar").exists();
      assert.dom(".nvp__browser-window__nav").exists({ count: 2 });
      assert.dom(".nvp__browser-window__toolbar .nvp__browser-window__url").exists();
    });

    test("moves URL from header to toolbar when tabs are present", async function (assert) {
      await render(
        <template>
          <BrowserWindow @tabs={{tabs}} @url="https://example.com">
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window__header .nvp__browser-window__url").doesNotExist();
      assert
        .dom(".nvp__browser-window__toolbar .nvp__browser-window__url")
        .hasText("https://example.com");
    });

    test("defaults to safari tab style on mac", async function (assert) {
      await render(
        <template>
          <BrowserWindow @tabs={{tabs}}>
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window").hasAttribute("data-tab-style", "safari");
    });

    test("defaults to firefox tab style on non-mac", async function (assert) {
      await render(
        <template>
          <BrowserWindow @os="windows" @tabs={{tabs}}>
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window").hasAttribute("data-tab-style", "firefox");
    });

    test("respects explicit @tabStyle", async function (assert) {
      await render(
        <template>
          <BrowserWindow @tabs={{tabs}} @tabStyle="chrome">
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window").hasAttribute("data-tab-style", "chrome");
    });

    test("does not render tabs or toolbar when @tabs is not provided", async function (assert) {
      await render(
        <template>
          <BrowserWindow @url="https://example.com">
            content
          </BrowserWindow>
        </template>,
      );

      assert.dom(".nvp__browser-window__tabs").doesNotExist();
      assert.dom(".nvp__browser-window__toolbar").doesNotExist();
      assert.dom(".nvp__browser-window__nav").doesNotExist();
    });
  });
});
