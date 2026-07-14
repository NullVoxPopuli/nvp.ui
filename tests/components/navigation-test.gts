import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Navigation, NavigationList } from "#src/index.ts";

module("Navigation", function (hooks) {
  setupRenderingTest(hooks);

  test("renders a nav element", async function (assert) {
    await render(
      <template>
        <Navigation>
          <NavigationList>
            <li><a href="/a">A</a></li>
          </NavigationList>
        </Navigation>
      </template>,
    );

    assert.dom("nav.nvp__navigation").exists();
  });

  test("splats attributes on the nav", async function (assert) {
    await render(
      <template>
        <Navigation aria-label="Documentation" data-test-nav>
          <NavigationList>
            <li><a href="/a">A</a></li>
          </NavigationList>
        </Navigation>
      </template>,
    );

    assert.dom("[data-test-nav]").hasTagName("nav");
    assert.dom("[data-test-nav]").hasClass("nvp__navigation");
    assert.dom("[data-test-nav]").hasAria("label", "Documentation");
  });

  test("contains navigation lists as direct children (no extra wrappers)", async function (assert) {
    await render(
      <template>
        <Navigation aria-label="Documentation">
          <NavigationList @label="Get started">
            <li><a href="/intro" aria-current="page">Intro</a></li>
          </NavigationList>
          <NavigationList @label="Components">
            <li><a href="/button">Button</a></li>
          </NavigationList>
        </Navigation>
      </template>,
    );

    assert.dom("nav.nvp__navigation > span.nvp__navigation-list__label").exists({ count: 2 });
    assert.dom("nav.nvp__navigation > ul.nvp__navigation-list").exists({ count: 2 });
    assert.dom("nav.nvp__navigation a[aria-current='page']").hasText("Intro");
  });

  test("owns its own scroll behavior", async function (assert) {
    await render(
      <template>
        <Navigation aria-label="Documentation">
          <NavigationList>
            <li><a href="/a">A</a></li>
          </NavigationList>
        </Navigation>
      </template>,
    );

    const nav = document.querySelector("nav.nvp__navigation");
    const styles = nav ? getComputedStyle(nav) : null;

    assert.strictEqual(styles?.position, "sticky", "the nav is sticky");
    assert.strictEqual(styles?.overflowY, "auto", "the nav scrolls its own overflow");
  });
});
