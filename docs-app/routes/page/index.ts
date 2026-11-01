import Route from "@ember/routing/route";

export default class PageIndexRoute extends Route {
  /**
   * The router drops a query param that no route declares.
   * The Table and Pagination demos keep their state in these.
   *
   * These live here because the parent route has a dynamic segment named `page`.
   */
  queryParams = {
    sort: {},
    page: {},
  };
}
