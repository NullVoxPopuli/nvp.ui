import { currentRouteName, currentURL, getSettledState, setApplication } from "@ember/test-helpers";
import { getPendingWaiterState } from "@ember/test-waiters";
import * as QUnit from "qunit";
import { setup as setupExtras } from "qunit-assertions-extra";
import { setup } from "qunit-dom";
import { start as qunitStart } from "ember-qunit";

import Application from "#app/app.js";
import config from "#app/config.ts";

export async function start() {
  QUnit.config.urlConfig.push({
    id: "debugA11yAudit",
    label: "Log a11y violations",
  });

  setApplication(Application.create(config.APP));

  setup(QUnit.assert);
  setupExtras(QUnit.assert);

  Object.assign(window, { getSettledState, getPendingWaiterState, currentURL, currentRouteName });

  const response = await fetch("/docs/manifest.json");
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
  const json = await response.json();
  // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access
  const pages = json.list.flat();

  // The accessibility page deliberately
  // has violations for demonstration
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-explicit-any, @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-call
  (window as any).__pages__ = pages.filter(
    (page: { path: string }) => !page.path.includes("accessibility"),
  );

  qunitStart();
}
