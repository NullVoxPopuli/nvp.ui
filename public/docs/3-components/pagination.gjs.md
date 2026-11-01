# Pagination

Page links: first, previous, a row of page numbers, next, last. The current page is marked with `aria-current`.

Pagination follows the [Tabular Data](/Docs/1-get-started/tabular-data) conventions. The `page` query param holds the current page, counted from 1. The component reads it from the URL, so it takes only the total.

The links are plain anchors, and the router is the click handler. Each href is the current URL with `page` set, and every other query param stays.

The links never move. The four edge links are always rendered, and at the ends they go nowhere. The row of five page numbers slides with the current page but never changes size.

```gjs live no-shadow
import { Pagination } from "nvp.ui/pagination";
import { qp } from "ember-primitives/qp";

const current = (page) => Number(page ?? 1);

<template>
  <p>Page {{current (qp "page")}} of 12</p>
  <Pagination @totalPages={{12}} />
</template>
```

## Setup

The app needs two things, both described on [Tabular Data](/Docs/1-get-started/tabular-data):

- `properLinks` from ember-primitives, so that anchor clicks reach the router
- `page` declared in the `queryParams` of the route, so that a page change loads the new page from the endpoint

The endpoint returns the total, and the template passes it through:

```gjs
<Pagination @totalPages={{@model.meta.totalPages}} />
```

A table puts the pagination in its `:footer` block:

```gjs
<Table @caption="Links" @columns={{columns}} @data={{@model.data}}>
  <:footer><Pagination @totalPages={{@model.meta.totalPages}} /></:footer>
</Table>
```

## API Reference

### Arguments

| Argument      | Type     |                          |
| ------------- | -------- | ------------------------ |
| `@totalPages` | `number` | how many pages there are |

The current page is not an argument. It comes from the `page` query param. The `<nav>` has the accessible name "Pagination". Set `aria-label` on the component to change it.

### `pageSlots(page, totalPages, count)`

The page numbers the component shows: `count` consecutive pages around the current one, clamped to the collection.

### Classes & Attributes

| Selector                |                                                   |
| ----------------------- | ------------------------------------------------- |
| `[data-rel="first"]`    | the first link, without an href on the first page |
| `[data-rel="prev"]`     | the previous link, likewise                       |
| `[data-rel="next"]`     | the next link, without an href on the last page   |
| `[data-rel="last"]`     | the last link, likewise                           |
| `[data-page]`           | a page link, with the page number                 |
| `[aria-current="page"]` | the current page's link                           |
| `[aria-disabled]`       | an edge link that goes nowhere                    |

## Installation

```bash
pnpm add nvp.ui
```
