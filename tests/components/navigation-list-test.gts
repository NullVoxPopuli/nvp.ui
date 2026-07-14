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
          <l.Section>
            <li><a href="/a">A</a></li>
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
          <l.Section>
            <li><a href="/a">A</a></li>
          </l.Section>
        </NavigationList>
      </template>,
    );

    assert.dom("[data-test-nav]").hasTagName("nav");
    assert.dom("[data-test-nav]").hasClass("nvp__navigation-list");
    assert.dom("[data-test-nav]").hasAria("label", "Documentation");
  });

  module("Section", function () {
    test("renders the label, associated with the list via aria-labelledby", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section @label="Components">
              <li><a href="/button">Button</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__label").hasText("Components");

      const label = document.querySelector(".nvp__navigation-list__label");
      const list = document.querySelector(".nvp__navigation-list__section");

      assert.ok(label?.id, "the label has an id");
      assert.dom(list).hasAria("labelledby", label?.id ?? "", "the list is labelled by the label");
    });

    test("omits the label (and aria-labelledby) when no @label is given", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section>
              <li><a href="/button">Button</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__label").doesNotExist();
      assert.dom(".nvp__navigation-list__section").doesNotHaveAria("labelledby");
    });

    test("splats attributes on the section's list", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section @label="Components" data-test-section>
              <li><a href="/button">Button</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom("[data-test-section]").hasTagName("ul");
      assert.dom("[data-test-section]").hasClass("nvp__navigation-list__section");
    });

    test("supports multiple sections, each with their own label association", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section @label="Get started">
              <li><a href="/intro">Intro</a></li>
            </l.Section>
            <l.Section @label="Components">
              <li><a href="/button">Button</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__section").exists({ count: 2 });
      assert.dom(".nvp__navigation-list__label").exists({ count: 2 });

      const labels = [...document.querySelectorAll(".nvp__navigation-list__label")];
      const lists = [...document.querySelectorAll(".nvp__navigation-list__section")];

      assert.notStrictEqual(labels[0]?.id, labels[1]?.id, "label ids are unique");
      assert.strictEqual(
        lists[0]?.getAttribute("aria-labelledby"),
        labels[0]?.id,
        "first list points at first label",
      );
      assert.strictEqual(
        lists[1]?.getAttribute("aria-labelledby"),
        labels[1]?.id,
        "second list points at second label",
      );
    });
  });

  module("items", function () {
    test("plain <li> children are direct descendants of the section's list", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section>
              <li><a href="/a">A</a></li>
              <li><a href="/b">B</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__section > li").exists({ count: 2 });
    });

    test("works with plain <a> children", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section>
              <li><a href="/somewhere">Somewhere</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__section > li > a[href='/somewhere']").hasText("Somewhere");
    });
  });

  module("current page styling hooks", function () {
    test("aria-current is preserved on consumer-rendered links", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section>
              <li><a href="/here" aria-current="page">Here</a></li>
              <li><a href="/there">There</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list li > a[aria-current='page']").exists({ count: 1 });
      assert.dom(".nvp__navigation-list li > a[aria-current='page']").hasText("Here");
    });

    test("active-class links (as routers render them) are addressable", async function (assert) {
      await render(
        <template>
          <NavigationList as |l|>
            <l.Section>
              <li><a href="/here" class="active">Here</a></li>
            </l.Section>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list li > a.active").exists();
    });
  });
});
