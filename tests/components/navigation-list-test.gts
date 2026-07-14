import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { NavigationList } from "#src/index.ts";

module("NavigationList", function (hooks) {
  setupRenderingTest(hooks);

  test("is exactly a <ul>", async function (assert) {
    await render(
      <template>
        <NavigationList>
          <li><a href="/a">A</a></li>
        </NavigationList>
      </template>,
    );

    assert.dom("ul.nvp__navigation-list").exists();
    assert.dom("ul.nvp__navigation-list").doesNotHaveAria("labelledby", "no label, no association");
    assert.dom(".nvp__navigation-list__label").doesNotExist();
  });

  test("splats attributes on the ul", async function (assert) {
    await render(
      <template>
        <NavigationList data-test-list aria-label="Quick links">
          <li><a href="/a">A</a></li>
        </NavigationList>
      </template>,
    );

    assert.dom("[data-test-list]").hasTagName("ul");
    assert.dom("[data-test-list]").hasClass("nvp__navigation-list");
    assert.dom("[data-test-list]").hasAria("label", "Quick links");
  });

  test("plain <li> / <a> children are direct descendants", async function (assert) {
    await render(
      <template>
        <NavigationList>
          <li><a href="/a">A</a></li>
          <li><a href="/somewhere">Somewhere</a></li>
        </NavigationList>
      </template>,
    );

    assert.dom("ul.nvp__navigation-list > li").exists({ count: 2 });
    assert.dom("ul.nvp__navigation-list > li > a[href='/somewhere']").hasText("Somewhere");
  });

  module("@label", function () {
    test("renders the label as a preceding sibling, associated via aria-labelledby", async function (assert) {
      await render(
        <template>
          <NavigationList @label="Components">
            <li><a href="/button">Button</a></li>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list__label").hasText("Components");
      assert.dom(".nvp__navigation-list__label").hasTagName("span");

      const label = document.querySelector(".nvp__navigation-list__label");
      const list = document.querySelector(".nvp__navigation-list");

      assert.ok(label?.id, "the label has an id");
      assert.strictEqual(
        label?.nextElementSibling,
        list,
        "the label immediately precedes its list (no wrapper element)",
      );
      assert.dom(list).hasAria("labelledby", label?.id ?? "", "the list is labelled by the label");
    });

    test("multiple lists each get their own label association", async function (assert) {
      await render(
        <template>
          <NavigationList @label="Get started">
            <li><a href="/intro">Intro</a></li>
          </NavigationList>
          <NavigationList @label="Components">
            <li><a href="/button">Button</a></li>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list").exists({ count: 2 });
      assert.dom(".nvp__navigation-list__label").exists({ count: 2 });

      const labels = [...document.querySelectorAll(".nvp__navigation-list__label")];
      const lists = [...document.querySelectorAll(".nvp__navigation-list")];

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

  module("current page styling hooks", function () {
    test("aria-current is preserved on consumer-rendered links", async function (assert) {
      await render(
        <template>
          <NavigationList>
            <li><a href="/here" aria-current="page">Here</a></li>
            <li><a href="/there">There</a></li>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list li > a[aria-current='page']").exists({ count: 1 });
      assert.dom(".nvp__navigation-list li > a[aria-current='page']").hasText("Here");
    });

    test("active-class links (as routers render them) are addressable", async function (assert) {
      await render(
        <template>
          <NavigationList>
            <li><a href="/here" class="active">Here</a></li>
          </NavigationList>
        </template>,
      );

      assert.dom(".nvp__navigation-list li > a.active").exists();
    });
  });
});
