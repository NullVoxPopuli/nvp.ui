import { find, render, triggerEvent, waitUntil } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Table } from "#src/index.ts";

import { createHelpers } from "@universal-ember/table/test-support";

import { RouterStub, visitStub } from "../helpers/router-stub.ts";

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

const { dragRight } = createHelpers({ resizeHandle: "button" });

function widthOf(selector: string) {
  return parseFloat((find(selector) as HTMLElement).style.width);
}

/**
 * The plugin measures the container in a ResizeObserver,
 * which test waiters do not know about.
 */
async function waitForLayout() {
  await waitUntil(() => widthOf("th:nth-child(1)") > 64);
}

module("Table", function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(function () {
    this.owner.register("service:router", RouterStub);
    visitStub(this.owner, "/fruit?sort=-count&page=3");
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
    visitStub(this.owner, "/fruit?sort=count");

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

  module("resizing", function () {
    const resizable: TableColumn<Fruit>[] = [
      { key: "name", name: "Name", resizable: true },
      { key: "count", name: "Count", resizable: true },
      { key: "notes", name: "Notes" },
    ];

    test("columns do not resize unless they opt in", async function (assert) {
      await render(
        <template><Table @caption="Fruit" @columns={{columns}} @data={{rows}} /></template>,
      );

      assert.dom("th button").doesNotExist();
      assert.dom("table").doesNotHaveAttribute("data-resizable");
      assert.strictEqual((find("th") as HTMLElement).style.width, "");
    });

    test("an edge needs a resizable column on both sides", async function (assert) {
      await render(
        <template><Table @caption="Fruit" @columns={{resizable}} @data={{rows}} /></template>,
      );

      assert.dom("th:nth-child(1) button").hasAria("label", "Resize Name");
      assert.dom("th:nth-child(2) button").doesNotExist();
      assert.dom("th:nth-child(3) button").doesNotExist();
    });

    test("dragging an edge moves width between the columns", async function (assert) {
      await render(
        <template><Table @caption="Fruit" @columns={{resizable}} @data={{rows}} /></template>,
      );
      await waitForLayout();

      const name = widthOf("th:nth-child(1)");
      const count = widthOf("th:nth-child(2)");

      await dragRight(find("th:nth-child(1)") as Element, 30);

      assert.strictEqual(widthOf("th:nth-child(1)"), name + 30);
      assert.strictEqual(widthOf("th:nth-child(2)"), count - 30);
    });

    test("every column shrinks with the container after a drag", async function (assert) {
      await render(
        <template>
          <div id="container">
            <Table @caption="Fruit" @columns={{resizable}} @data={{rows}} />
          </div>
        </template>,
      );
      await waitForLayout();

      await dragRight(find("th:nth-child(1)") as Element, 10);

      const notes = widthOf("th:nth-child(3)");
      const container = find("#container") as HTMLElement;

      container.style.width = `${container.clientWidth - 60}px`;

      await waitUntil(() => widthOf("th:nth-child(3)") < notes);

      const total =
        widthOf("th:nth-child(1)") + widthOf("th:nth-child(2)") + widthOf("th:nth-child(3)");

      /**
       * The test container is scaled, and the plugin measures the scaled size.
       */
      const available = container.getBoundingClientRect().width;

      assert.true(Math.abs(total - available) < 1, "the columns fill the container");
    });

    test("the arrow keys move a focused edge", async function (assert) {
      await render(
        <template><Table @caption="Fruit" @columns={{resizable}} @data={{rows}} /></template>,
      );
      await waitForLayout();

      const name = widthOf("th:nth-child(1)");

      await triggerEvent("th:nth-child(1) button", "keydown", { code: "ArrowLeft" });
      await waitUntil(() => widthOf("th:nth-child(1)") !== name);

      assert.strictEqual(widthOf("th:nth-child(1)"), name - 1);
    });
  });
});
