import { findAll, render, settled } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { pageSlots, Pagination } from "#src/index.ts";

import { RouterStub, visitStub } from "../helpers/router-stub.ts";

function pagesShown() {
  return findAll("[data-page]").map((link) => link.textContent?.trim());
}

function hrefOf(selector: string) {
  const href = document.querySelector(selector)?.getAttribute("href") ?? "";

  /**
   * withQP builds an absolute URL.
   * Only the path and query matter here.
   */
  return href.replace(location.origin, "");
}

module("Pagination", function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(function () {
    this.owner.register("service:router", RouterStub);
    visitStub(this.owner, "/fruit?sort=name&page=2");
  });

  test("links set the page query param and keep the others", async function (assert) {
    await render(<template><Pagination @totalPages={{3}} /></template>);

    assert.dom("nav").hasAttribute("aria-label", "Pagination");
    assert.deepEqual(pagesShown(), ["1", "2", "3"]);
    assert.dom("a[data-page]").exists({ count: 3 });
    assert.dom("a[aria-current='page']").hasText("2");

    assert.strictEqual(hrefOf("[data-rel='first']"), "/fruit?sort=name&page=1");
    assert.strictEqual(hrefOf("[data-rel='prev']"), "/fruit?sort=name&page=1");
    assert.strictEqual(hrefOf("[data-page='3']"), "/fruit?sort=name&page=3");
    assert.strictEqual(hrefOf("[data-rel='next']"), "/fruit?sort=name&page=3");
    assert.strictEqual(hrefOf("[data-rel='last']"), "/fruit?sort=name&page=3");
  });

  test("without a page param, the first page is current", async function (assert) {
    visitStub(this.owner, "/fruit");

    await render(<template><Pagination @totalPages={{3}} /></template>);

    assert.dom("a[aria-current='page']").hasText("1");
  });

  test("aria-label renames the nav", async function (assert) {
    await render(<template><Pagination @totalPages={{3}} aria-label="Fruit pages" /></template>);

    assert.dom("nav").hasAttribute("aria-label", "Fruit pages");
  });

  test("the edges stay in place and go nowhere at the ends", async function (assert) {
    visitStub(this.owner, "/fruit?page=1");

    await render(<template><Pagination @totalPages={{3}} /></template>);

    assert.dom("li").exists({ count: 7 });
    assert.dom("[data-rel='first']").doesNotHaveAttribute("href");
    assert.dom("[data-rel='first']").hasAria("disabled", "true");
    assert.dom("[data-rel='prev']").doesNotHaveAttribute("href");
    assert.dom("[data-rel='next']").hasAttribute("href");
    assert.dom("[data-rel='last']").hasAttribute("href");

    visitStub(this.owner, "/fruit?page=3");
    await settled();

    assert.dom("li").exists({ count: 7 });
    assert.dom("[data-rel='next']").doesNotHaveAttribute("href");
    assert.dom("[data-rel='last']").doesNotHaveAttribute("href");
    assert.dom("[data-rel='prev']").hasAttribute("href");
    assert.dom("[data-rel='first']").hasAttribute("href");
  });

  test("a page outside the collection shows as the nearest page", async function (assert) {
    visitStub(this.owner, "/fruit?page=99");

    await render(<template><Pagination @totalPages={{3}} /></template>);

    assert.dom("a[aria-current='page']").hasText("3");
    assert.dom("[data-rel='next']").doesNotHaveAttribute("href");
    assert.strictEqual(hrefOf("[data-rel='prev']"), "/fruit?page=2");

    visitStub(this.owner, "/fruit?page=nonsense");
    await settled();

    assert.dom("a[aria-current='page']").hasText("1");
  });

  test("an empty collection has nowhere to go", async function (assert) {
    visitStub(this.owner, "/fruit");

    await render(<template><Pagination @totalPages={{0}} /></template>);

    assert.dom("[data-page]").doesNotExist();
    assert.dom("[href]").doesNotExist();
  });

  test("the symbol leads on backward controls and trails on forward ones", async function (assert) {
    await render(<template><Pagination @totalPages={{3}} /></template>);

    assert.dom("[data-rel='prev']").hasText("‹ Previous");
    assert.dom("[data-rel='next']").hasText("Next ›");
    assert.dom("[data-rel='last']").hasText("Last »");
  });

  test("the row of pages slides but keeps its size", async function (assert) {
    visitStub(this.owner, "/fruit?page=1");

    await render(<template><Pagination @totalPages={{20}} /></template>);

    assert.deepEqual(pagesShown(), ["1", "2", "3", "4", "5"]);

    visitStub(this.owner, "/fruit?page=10");
    await settled();

    assert.deepEqual(pagesShown(), ["8", "9", "10", "11", "12"]);

    visitStub(this.owner, "/fruit?page=20");
    await settled();

    assert.deepEqual(pagesShown(), ["16", "17", "18", "19", "20"]);
  });
});

module("pageSlots", function () {
  test("centers the window on the current page and clamps it to the ends", function (assert) {
    assert.deepEqual(pageSlots(1, 20, 5), [1, 2, 3, 4, 5]);
    assert.deepEqual(pageSlots(3, 20, 5), [1, 2, 3, 4, 5]);
    assert.deepEqual(pageSlots(4, 20, 5), [2, 3, 4, 5, 6]);
    assert.deepEqual(pageSlots(19, 20, 5), [16, 17, 18, 19, 20]);
    assert.deepEqual(pageSlots(2, 2, 5), [1, 2]);
    assert.deepEqual(pageSlots(1, 0, 5), []);
  });
});
