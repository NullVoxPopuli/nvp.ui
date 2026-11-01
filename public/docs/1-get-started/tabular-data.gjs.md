# Tabular Data

Every list of records that a user reads supports sort, filter, and page. This is a base requirement of the data endpoint, as accessibility is a base requirement of the UI. A collection that cannot sort, filter, or page is not finished.

[Table](/Docs/3-components/table) and [Pagination](/Docs/3-components/pagination) depend on these conventions. They have no options to do it another way.

## Query params

The endpoint and the app URL use the same query params, with no brackets. The route passes them through unchanged.

| Param    | Example               |                                                              |
| -------- | --------------------- | ------------------------------------------------------------ |
| `sort`   | `sort=-created,title` | comma separated fields, `-` for descending, as in {json:api} |
| `page`   | `page=2`              | the page, counted from 1; the server sets the page size      |
| a filter | `status=active`       | one param per field, named after the field                   |

The [{json:api} `sort` syntax](https://jsonapi.org/format/#fetching-sorting) is the sort format.

The response tells the client how many pages there are, for example in `meta.totalPages`. Without the total, the UI cannot render the last page link.

The server does the work. The client never sorts, filters, or pages a full collection in memory, because the full collection does not fit on the client as the data grows.

## The route

The app URL holds the state, so a user can reload, share, or go back and get the same view. The components write the params with plain links. The route declares them and sends them to the endpoint:

```ts
import Route from "@ember/routing/route";

export default class LinksRoute extends Route {
  queryParams = {
    sort: { refreshModel: true },
    page: { refreshModel: true },
    status: { refreshModel: true },
  };

  model(params: Record<string, string | undefined>) {
    const query = new URLSearchParams();

    for (const [name, value] of Object.entries(params)) {
      if (value) query.set(name, value);
    }

    return fetch(`/api/links?${query}`).then((response) => response.json());
  }
}
```

The route needs no controller. Ember makes one for query params declared only on the route.

Anchor clicks must reach the router. `properLinks` from ember-primitives does that for every anchor in the app:

```ts
import EmberRouter from "@ember/routing/router";
import { properLinks } from "ember-primitives/proper-links";

@properLinks
export default class Router extends EmberRouter {}
```

## Rules the components follow

- A link never removes a query param. It sets its own param and keeps every other param, including ones that other parts of the UI own.
- A sort change keeps the current page. The first page link is always there.
- A column sorts only if it opts in with `sortable: true`, because the endpoint decides which fields it can sort by.
- A header sorts by one column: ascending first, then it toggles between ascending and descending.
