import { tracked } from "@glimmer/tracking";
import Service from "@ember/service";
import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Table } from "#src/index.ts";

import type { TOC } from "@ember/component/template-only";
import type { CellSignature, TableColumn } from "#src/index.ts";

interface Fruit {
  name: string;
  count: number;
}

const rows: Fruit[] = [
  { name: "Apple", count: 3 },
  { name: "Banana", count: 12 },
];

const CountCell: TOC<CellSignature<Fruit>> = <template>
  <strong>{{@row.data.count}}</strong>
</template>;

const columns: TableColumn<Fruit>[] = [
  { key: "name", name: "Name" },
  { key: "count", name: "Count", align: "end", nowrap: true, Cell: CountCell },
];

function hrefOf(selector: string) {
  const href = document.querySelector(selector)?.getAttribute("href") ?? "";

  return href.replace(location.origin, "");
}

module("Table", function (hooks) {
  setupRenderingTest(hooks);

  // The sort comes from currentRoute and the sort hrefs from currentURL
  class RouterStub extends Service {
    @tracked currentURL = "/fruit?sort=-count&page=3";

    get currentRoute() {
      const params = new URL(this.currentURL, location.origin).searchParams;

      return { queryParams: Object.fromEntries(params) };
    }
  }

  hooks.beforeEach(function () {
    this.owner.register("service:router", RouterStub);
  });

  test("renders a head, rows, cells, and a hidden caption", async function (assert) {
    await render(
      <template><Table @caption="Fruit" @columns={{columns}} @data={{rows}} /></template>,
    );

    assert.dom("table").exists();
    assert.dom("caption").hasText("Fruit");
    assert.dom("caption").hasClass("nvp__table__caption");
    assert.dom("thead th").exists({ count: 2 });
    assert.dom("thead th:nth-child(1)").hasText("Name");
    assert.dom("thead th:nth-child(2)").hasAttribute("data-align", "end");
    assert.dom("tbody tr").exists({ count: 2 });
    assert.dom("tbody tr:first-child td:first-child").hasText("Apple");
  });

  test("a column with a Cell renders it; the rest render the value", async function (assert) {
    await render(
      <template><Table @caption="Fruit" @columns={{columns}} @data={{rows}} /></template>,
    );

    assert.dom("tbody tr:first-child td:nth-child(2) strong").hasText("3");
    assert.dom("tbody tr:first-child td:nth-child(2)").hasAttribute("data-align", "end");
    assert.dom("tbody tr:first-child td:nth-child(2)").hasAttribute("data-nowrap");
    assert.dom("tbody tr:first-child td:first-child strong").doesNotExist();
  });

  test("sort links toggle the direction and keep the other query params", async function (assert) {
    const sortable: TableColumn<Fruit>[] = [
      { key: "name", name: "Name", sortable: true },
      { key: "count", name: "Count", sortable: true },
      { key: "notes", name: "Notes" },
    ];

    await render(
      <template><Table @caption="Fruit" @columns={{sortable}} @data={{rows}} /></template>,
    );

    assert.dom("th:nth-child(1)").hasAttribute("aria-sort", "none");
    assert.strictEqual(hrefOf("th:nth-child(1) a"), "/fruit?sort=name&page=3");
    assert.dom("th:nth-child(2)").hasAttribute("aria-sort", "descending");
    assert.strictEqual(hrefOf("th:nth-child(2) a"), "/fruit?sort=count&page=3");
    assert.dom("th:nth-child(3) a").doesNotExist();
  });

  test("an ascending column links to descending", async function (assert) {
    (this.owner.lookup("service:router") as RouterStub).currentURL = "/fruit?sort=count";

    const sortable: TableColumn<Fruit>[] = [{ key: "count", name: "Count", sortable: true }];

    await render(
      <template><Table @caption="Fruit" @columns={{sortable}} @data={{rows}} /></template>,
    );

    assert.dom("th").hasAttribute("aria-sort", "ascending");
    assert.strictEqual(hrefOf("th a"), "/fruit?sort=-count");
  });

  test("columns do not sort unless they opt in", async function (assert) {
    await render(
      <template><Table @caption="Fruit" @columns={{columns}} @data={{rows}} /></template>,
    );

    assert.dom("th a").doesNotExist();
  });

  test("no data shows the empty block instead of rows", async function (assert) {
    const none: Fruit[] = [];

    await render(
      <template>
        <Table @caption="Fruit" @columns={{columns}} @data={{none}}>
          <:empty>Nothing here yet.</:empty>
        </Table>
      </template>,
    );

    assert.dom("thead th").exists({ count: 2 });
    assert.dom("tbody").doesNotExist();
    assert.dom(".nvp__table__empty").hasText("Nothing here yet.");
    assert.dom(".nvp__table").hasAttribute("data-empty");
  });

  test("the footer block renders below the table", async function (assert) {
    await render(
      <template>
        <Table @caption="Fruit" @columns={{columns}} @data={{rows}}>
          <:footer>Page 1 of 3</:footer>
        </Table>
      </template>,
    );

    assert.dom(".nvp__table__footer").hasText("Page 1 of 3");
  });
});
