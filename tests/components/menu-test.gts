import { click, render, triggerKeyEvent } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { PortalTargets } from "ember-primitives";

import { Menu } from "#src/index.ts";

module("Menu", function (hooks) {
  setupRenderingTest(hooks);

  test("renders a trigger button", async function (assert) {
    await render(
      <template>
        <PortalTargets />
        <Menu as |menu|>
          <menu.Trigger>Actions</menu.Trigger>
          <menu.Content as |Items|>
            <Items.Item>One</Items.Item>
          </menu.Content>
        </Menu>
      </template>,
    );

    assert.dom(".nvp__menu__trigger").exists();
    assert.dom(".nvp__menu__trigger").hasText("Actions");
  });

  test("opens content on trigger click", async function (assert) {
    await render(
      <template>
        <PortalTargets />
        <Menu as |menu|>
          <menu.Trigger>Open</menu.Trigger>
          <menu.Content as |Items|>
            <Items.Item>Item 1</Items.Item>
          </menu.Content>
        </Menu>
      </template>,
    );

    assert.dom(".nvp__menu__content").doesNotExist();

    await click(".nvp__menu__trigger");

    assert.dom(".nvp__menu__content").exists();
    assert.dom(".nvp__menu__item").hasText("Item 1");
  });

  test("renders keyboard hints when open", async function (assert) {
    await render(
      <template>
        <PortalTargets />
        <Menu as |menu|>
          <menu.Trigger>Open</menu.Trigger>
          <menu.Content as |Items|>
            <Items.Item>Item 1</Items.Item>
          </menu.Content>
        </Menu>
      </template>,
    );

    await click(".nvp__menu__trigger");

    assert.dom(".nvp__menu__kbd-hints").exists();
    assert.dom(".nvp__menu__kbd-hints kbd").exists({ count: 3 });
  });

  test("renders items, link items, and separators", async function (assert) {
    await render(
      <template>
        <PortalTargets />
        <Menu as |menu|>
          <menu.Trigger>Menu</menu.Trigger>
          <menu.Content as |Items|>
            <Items.Item>Action</Items.Item>
            <Items.Separator />
            <Items.LinkItem @href="/settings">Settings</Items.LinkItem>
          </menu.Content>
        </Menu>
      </template>,
    );

    await click(".nvp__menu__trigger");

    assert.dom(".nvp__menu__item").exists();
    assert.dom(".nvp__menu__separator").exists();
    assert.dom(".nvp__menu__link-item").exists();
    assert.dom(".nvp__menu__link-item").hasText("Settings");
  });

  test("applies variant to trigger", async function (assert) {
    await render(
      <template>
        <PortalTargets />
        <Menu @variant="primary" as |menu|>
          <menu.Trigger>Primary</menu.Trigger>
          <menu.Content as |Items|>
            <Items.Item>Item</Items.Item>
          </menu.Content>
        </Menu>
      </template>,
    );

    assert.dom(".nvp__menu__trigger").hasAttribute("data-variant", "primary");
  });

  test("closes on Escape", async function (assert) {
    await render(
      <template>
        <PortalTargets />
        <Menu as |menu|>
          <menu.Trigger>Open</menu.Trigger>
          <menu.Content as |Items|>
            <Items.Item>Item 1</Items.Item>
          </menu.Content>
        </Menu>
      </template>,
    );

    await click(".nvp__menu__trigger");
    assert.dom(".nvp__menu__content").exists();

    await triggerKeyEvent(".nvp__menu__content", "keydown", "Escape");
    assert.dom(".nvp__menu__content").doesNotExist();
  });
});
