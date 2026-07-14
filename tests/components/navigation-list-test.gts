import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { NavigationList } from "#src/index.ts";

module("NavigationList", function (hooks) {
  setupRenderingTest(hooks);

  test("renders a nav element", async function (assert) {
    await render(
      <template>
        <NavigationList as |l|>
          <l.Section as |s|>
            <s.Item><a href="/a">A</a></s.Item>
          </l.Section>
        </NavigationList>
      </template>,
    );

    assert.dom("nav.nvp__navigation-list").exists();
  });

  test("splats attributes on the nav", async function (assert) {
    await render(
      <template>
        <NavigationList aria-label="Documentation" data-test-nav as |l|>
          <l.Section as |s|>
            <s.Item><a href="/a">A</a></s.Item>
          </l.Section>
        </NavigationList>
      </template>,
    );

    assert.dom("[data-test-nav]").hasTagName("nav");
    assert.dom("[data-test-nav]").hasClass("nvp__navigation-list");
    assert.dom("[data-test-nav]").hasAria("label", "Documentation");
  });

  module("Section", function () {
    test("renders the label", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section @label="Components" as |s|>
              <s.Item><a href="/button">Button</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__label").hasText("Components");
    });

    test("omits the label element when no @label is given", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section as |s|>
              <s.Item><a href="/button">Button</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__label").doesNotExist();
    });

    test("splats attributes on the section", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section @label="Components" data-test-section as |s|>
              <s.Item><a href="/button">Button</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom("[data-test-section]").hasClass("nvp__navigation-list__section");
    });

    test("supports multiple sections", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section @label="Get started" as |s|>
              <s.Item><a href="/intro">Intro</a></s.Item>
            </l.Section>
            <l.Section @label="Components" as |s|>
              <s.Item><a href="/button">Button</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__section").exists({ count: 2 });
      assert.dom(".nvp__navigation-list__label").exists({ count: 2 });
    });
  });

  module("Item", function () {
    test("items are list items within the section's list", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section as |s|>
              <s.Item><a href="/a">A</a></s.Item>
              <s.Item><a href="/b">B</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__section > ul > li.nvp__navigation-list__item").exists({
        count: 2,
      });
    });

    test("works with plain <a> children", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section as |s|>
              <s.Item><a href="/somewhere">Somewhere</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__item > a[href='/somewhere']").hasText("Somewhere");
    });

    test("splats attributes on the item", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section as |s|>
              <s.Item data-test-item><a href="/a">A</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom("[data-test-item]").hasTagName("li");
      assert.dom("[data-test-item]").hasClass("nvp__navigation-list__item");
    });
  });

  module("current page styling hooks", function () {
    test("aria-current is preserved on consumer-rendered links", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section as |s|>
              <s.Item><a href="/here" aria-current="page">Here</a></s.Item>
              <s.Item><a href="/there">There</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list a[aria-current='page']").exists({ count: 1 });
      assert.dom(".nvp__navigation-list a[aria-current='page']").hasText("Here");
    });

    test("active-class links (as routers render them) are addressable", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section as |s|>
              <s.Item><a href="/here" class="active">Here</a></s.Item>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list a.active").exists();
    });
  });

  module("bring your own nav (<:nav>)", function () {
    test("renders a styling container instead of a second <nav>", async function (assert) {
      await render(
        <template>
          <NavigationList data-test-container>
            <:nav>
              <nav aria-label="Documentation">
                <ul>
                  <li>
                    Group
                    <ul>
                      <li><a href="/a" class="active">A</a></li>
                      <li><a href="/b">B</a></li>
                    </ul>
                  </li>
                </ul>
              </nav>
            </:nav>
          </NavigationList>
        </template>,
      );

      assert.dom("[data-test-container]").hasTagName("div");
      assert.dom("[data-test-container]").hasClass("nvp__navigation-list");
      assert.dom("[data-test-container] nav").exists({ count: 1 });
      assert.dom("[data-test-container] nav a").exists({ count: 2 });
    });
  });
});
