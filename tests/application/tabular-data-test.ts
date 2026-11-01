import { click, currentURL, find, visit, waitFor } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupApplicationTest } from "ember-qunit";

const PAGE = "/Docs/3-components/table";
const COUNT_HEADER = "th:nth-child(2):has(a)";

module("Application | Tabular data", function (hooks) {
  setupApplicationTest(hooks);

  test("a sort header drives the real router", async function (assert) {
    await visit(`${PAGE}?page=2`);
    await waitFor(`${COUNT_HEADER} a`);

    assert.dom(COUNT_HEADER).hasAttribute("aria-sort", "none");

    await click(`${COUNT_HEADER} a`);

    assert.strictEqual(currentURL(), `${PAGE}?page=2&sort=count`);
    assert.dom(COUNT_HEADER).hasAttribute("aria-sort", "ascending");

    await click(`${COUNT_HEADER} a`);

    assert.strictEqual(currentURL(), `${PAGE}?page=2&sort=-count`);
    assert.dom(COUNT_HEADER).hasAttribute("aria-sort", "descending");
    assert.strictEqual(
      find(`${COUNT_HEADER}`)?.closest("table")?.querySelector("td")?.textContent?.trim(),
      "Cherry",
    );
  });

  test("a page link drives the real router", async function (assert) {
    await visit("/Docs/3-components/pagination?sort=name");
    await waitFor("[data-page='3']");

    await click("[data-page='3']");

    assert.strictEqual(currentURL(), "/Docs/3-components/pagination?page=3&sort=name");
    assert.dom(".nvp__pagination a[aria-current='page']").hasText("3");
  });
});
