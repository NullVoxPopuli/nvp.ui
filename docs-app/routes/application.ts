import Route from "@ember/routing/route";

import { setupTabster } from "ember-primitives/tabster";
import { setupKolay } from "kolay/setup";

import type { Manifest } from "kolay";

export default class ApplicationRoute extends Route {
  async model(): Promise<{ manifest: Manifest }> {
    await setupTabster(this);

    const manifest = await setupKolay(this, {});

    return { manifest };
  }
}
