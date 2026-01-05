import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { BrowserWindow } from "#src/index.ts";

module("BrowserWindow", function (hooks) {
  setupRenderingTest(hooks);

  test("it renders with default chrome", async function (assert) {
    await render(
      <template>
        <BrowserWindow>
          <p>Content inside browser window</p>
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window").exists();
    assert.dom(".nvp__browser-window__chrome").exists();
    assert.dom(".nvp__browser-window__buttons").exists();
    assert.dom(".nvp__browser-window__button").exists({ count: 3 });
    assert.dom(".nvp__browser-window__content").exists();
    assert.dom(".nvp__browser-window__content").containsText("Content inside browser window");
  });

  test("it renders with a URL in the address bar", async function (assert) {
    await render(
      <template>
        <BrowserWindow @url="https://example.com">
          <p>Content</p>
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window__address-bar").exists();
    assert.dom(".nvp__browser-window__address-bar").hasText("https://example.com");
  });

  test("it can hide the chrome", async function (assert) {
    await render(
      <template>
        <BrowserWindow @showChrome={{false}}>
          <p>Content without chrome</p>
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window").exists();
    assert.dom(".nvp__browser-window__chrome").doesNotExist();
    assert.dom(".nvp__browser-window__content").exists();
  });

  test("it renders without address bar when no URL is provided", async function (assert) {
    await render(
      <template>
        <BrowserWindow>
          <p>Content</p>
        </BrowserWindow>
      </template>,
    );

    assert.dom(".nvp__browser-window__chrome").exists();
    assert.dom(".nvp__browser-window__address-bar").doesNotExist();
  });

  test("it passes through HTML attributes", async function (assert) {
    await render(
      <template>
        <BrowserWindow data-test-id="my-browser">
          <p>Content</p>
        </BrowserWindow>
      </template>,
    );

    assert.dom("[data-test-id='my-browser']").exists();
  });
});
