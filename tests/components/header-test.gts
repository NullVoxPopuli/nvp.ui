import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Header } from "#src/index.ts";

module("Header", function (hooks) {
  setupRenderingTest(hooks);

  test("it works with default (top) positioning", async function (assert) {
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
    assert.dom("header").doesNotHaveAttribute("data-position");
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
});
