import { find, render, settled } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { politeSticky as polite } from "#src/index.ts";

function scrollContainer(): Element {
  const el = find(".scroll-container");

  if (!el) throw new Error("scroll container not found");

  return el;
}

function politeElement(): HTMLElement {
  const el = find(".nvp__polite") as HTMLElement | null;

  if (!el) throw new Error("polite element not found");

  return el;
}

async function scroll(container: Element, top: number) {
  container.scrollTo({ top, behavior: "instant" });
  // scroll events are async
  await new Promise((r) => setTimeout(r, 50));
  await settled();
}

module("polite", function (hooks) {
  setupRenderingTest(hooks);

  module("header", function () {
    test("adds polite classes to a header element", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <header {{polite}}>Header</header>
            <div style="height: 1000px;"></div>
          </div>
        </template>,
      );

      assert.dom("header").hasClass("nvp__polite");
      assert.dom("header").hasClass("nvp__polite__header");
    });

    test("hides on scroll down", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <header {{polite}}>Header</header>
            <div style="height: 1000px;"></div>
          </div>
        </template>,
      );

      await scroll(scrollContainer(), 200);

      assert.strictEqual(politeElement().style.transform, "translate3d(0px, -101%, 0px)");
    });

    test("reveals on scroll up", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <header {{polite}}>Header</header>
            <div style="height: 1000px;"></div>
          </div>
        </template>,
      );

      const container = scrollContainer();

      await scroll(container, 200);
      assert.strictEqual(politeElement().style.transform, "translate3d(0px, -101%, 0px)");

      await scroll(container, 50);
      assert.strictEqual(politeElement().style.transform, "");
    });

    test("always visible at scroll top", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <header {{polite}}>Header</header>
            <div style="height: 1000px;"></div>
          </div>
        </template>,
      );

      const container = scrollContainer();

      await scroll(container, 200);
      assert.strictEqual(politeElement().style.transform, "translate3d(0px, -101%, 0px)");

      await scroll(container, 0);
      assert.strictEqual(politeElement().style.transform, "");
    });
  });

  module("footer", function () {
    test("adds polite classes to a footer element", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <div style="height: 1000px;"></div>
            <footer {{polite}}>Footer</footer>
          </div>
        </template>,
      );

      assert.dom("footer").hasClass("nvp__polite");
      assert.dom("footer").hasClass("nvp__polite__footer");
    });

    test("hides on scroll up", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <div style="height: 1000px;"></div>
            <footer {{polite}}>Footer</footer>
          </div>
        </template>,
      );

      const container = scrollContainer();

      await scroll(container, 500);
      assert.strictEqual(politeElement().style.transform, "");

      await scroll(container, 200);
      assert.strictEqual(politeElement().style.transform, "translate3d(0px, 101%, 0px)");
    });

    test("reveals on scroll down", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <div style="height: 1000px;"></div>
            <footer {{polite}}>Footer</footer>
          </div>
        </template>,
      );

      const container = scrollContainer();

      await scroll(container, 500);
      await scroll(container, 200);
      assert.strictEqual(politeElement().style.transform, "translate3d(0px, 101%, 0px)");

      await scroll(container, 400);
      assert.strictEqual(politeElement().style.transform, "");
    });
  });

  module("non-footer element", function () {
    test("treats non-footer elements as headers", async function (assert) {
      await render(
        <template>
          <div class="scroll-container" style="height: 100px; overflow-y: scroll;">
            <nav {{polite}}>Nav bar</nav>
            <div style="height: 1000px;"></div>
          </div>
        </template>,
      );

      assert.dom("[class*=polite]").hasClass("nvp__polite__header");
    });
  });
});
