import { tracked } from "@glimmer/tracking";
import Service from "@ember/service";

/**
 * `qp` and the sort state read `currentRoute`.
 * `withQP` reads `currentURL`.
 */
export class RouterStub extends Service {
  @tracked currentURL = "/";

  get currentRoute() {
    const params = new URL(this.currentURL, location.origin).searchParams;

    return { queryParams: Object.fromEntries(params) };
  }
}

export function visitStub(owner: { lookup(name: string): unknown }, url: string) {
  (owner.lookup("service:router") as RouterStub).currentURL = url;
}
