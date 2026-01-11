import Route from "@ember/routing/route";
import { service } from "@ember/service";

import { docsManager } from "kolay";

import type RouterService from "@ember/routing/router-service";

type Transition = ReturnType<RouterService["transitionTo"]>;

export default class ApplicationRoute extends Route {
  @service declare router: RouterService;

  /**
   * Does our target destination exist? if not,
   * redirect to the first page on the namespace
   */
  beforeModel(transition: Transition) {
    if (transition.to?.localName !== "index") return;

    const docs = docsManager(this);

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-explicit-any
    const yolo = transition as any;
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
    const groupName = yolo.to.parent?.params?.page;

    if (!groupName) return;
    // eslint-disable-next-line @typescript-eslint/no-unsafe-argument
    if (!docs.availableGroups.includes(groupName)) return;

    // eslint-disable-next-line @typescript-eslint/no-unsafe-argument
    const group = docs.groupFor(groupName);

    const first = group.list[0];

    if (!first) {
      console.warn(`Could not determine first page in group: ${groupName}`);

      return;
    }

    this.router.transitionTo(first.path);
  }
}
