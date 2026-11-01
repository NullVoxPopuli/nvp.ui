# Table

A styled data table on top of [`@universal-ember/table`](https://github.com/universal-ember/table), which supplies the accessible structure, the column and row model, and the plugins. Columns are configuration, and rows come from data. The header row stays in view while the page scrolls. Long cell content wraps, so the table never scrolls sideways.

The table follows the [Tabular Data](/Docs/1-get-started/tabular-data) conventions. The data endpoint sorts, filters, and pages. The URL holds that state, and the table only shows it and links to the next state.

```gjs live no-shadow
import { Table } from "nvp.ui/table";
import { Button } from "nvp.ui/button";

const fruit = [
  { name: "Apple", count: 3, added: "Aug 1, 2026" },
  { name: "Banana", count: 12, added: "Aug 9, 2026" },
  { name: "Cherry", count: 140, added: "Sep 2, 2026" },
];

const Actions = <template>
  <Button>Edit</Button>
  <Button @variant="danger">Delete</Button>
</template>;

const columns = [
  { key: "name", name: "Name" },
  { key: "count", name: "Count", align: "end" },
  { key: "added", name: "Added", nowrap: true },
  { key: "actions", name: "Actions", align: "end", Cell: Actions },
];

<template>
  <Table @caption="Fruit in stock" @columns={{columns}} @data={{fruit}}>
    <:footer>3 of 3 shown</:footer>
  </Table>
</template>
```

## Columns

Each column is a `@universal-ember/table` column config plus layout:

| Key        |                                                                        |
| ---------- | ---------------------------------------------------------------------- |
| `key`      | the property read from each row, and the default sort key              |
| `name`     | the header text                                                        |
| `value`    | `({ row, column }) => value`, when the cell is not the property        |
| `Cell`     | a component receiving `@row` and `@column`, when the cell needs markup |
| `align`    | `start`, `center`, or `end`                                            |
| `nowrap`   | keep the cells on one line                                             |
| `sortable` | `true` makes the header a sort link; the sort field is `key`           |

Any other key is kept on the config, so a `Cell` can read it from `@column.config`.

## Sorting

The `sort` query param holds the sort, in the {json:api} syntax: `?sort=count` is ascending, `?sort=-count` is descending. Each sortable header is a link that sets `sort` for its column: ascending first, then it toggles. The link keeps every other query param, so the current page stays. The header carries `aria-sort`, from the `DataSorting` plugin.

The table does not sort the rows. The route passes `sort` to the endpoint, which sorts. Only columns that the endpoint can sort by opt in with `sortable: true`. See [Tabular Data](/Docs/1-get-started/tabular-data) for the route.

```gjs live no-shadow
import { Table } from "nvp.ui/table";
import { qp } from "ember-primitives/qp";

const fruit = [
  { name: "Apple", count: 3 },
  { name: "Banana", count: 12 },
  { name: "Cherry", count: 140 },
];

const columns = [
  { key: "name", name: "Name", sortable: true },
  { key: "count", name: "Count", align: "end", sortable: true },
];

// A real endpoint sorts. This demo has no endpoint.
function sorted(sort) {
  if (!sort) return fruit;

  const key = sort.replace(/^-/, "");
  const result = fruit.slice().sort((a, b) => (a[key] < b[key] ? -1 : a[key] > b[key] ? 1 : 0));

  return sort.startsWith("-") ? result.reverse() : result;
}

<template><Table @caption="Fruit" @columns={{columns}} @data={{sorted (qp "sort")}} /></template>
```

## Empty

With no data, the rows are not rendered and the `empty` block takes their place. The header stays, so the columns are still visible.

```gjs live no-shadow
import { Table } from "nvp.ui/table";

const columns = [
  { key: "name", name: "Name" },
  { key: "count", name: "Count" },
];
const none = [];

<template>
  <Table @caption="Fruit" @columns={{columns}} @data={{none}}>
    <:empty>No fruit yet. Add some above.</:empty>
  </Table>
</template>
```

## API Reference

### Arguments

| Argument   | Type            |                                                                                                                          |
| ---------- | --------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `@columns` | `TableColumn[]` | see Columns                                                                                                              |
| `@data`    | `T[]`           | one row per item                                                                                                         |
| `@caption` | `string`        | required, the accessible name, rendered as a visually hidden `<caption>`; a visible title is a heading outside the table |

The sort is not an argument. It comes from the `sort` query param.

### Blocks

| Block     | Yields |                             |
| --------- | ------ | --------------------------- |
| `:empty`  |        | shown when there is no data |
| `:footer` |        | below the table             |

### CSS API

| Variable                 |                         |
| ------------------------ | ----------------------- |
| `--table-cell-padding-y` | vertical cell padding   |
| `--table-cell-padding-x` | horizontal cell padding |
| `--table-border-color`   | row separator color     |
| `--table-header-color`   | header text color       |
| `--table-hover-color`    | row background on hover |

## Installation

```bash
pnpm add nvp.ui
```
