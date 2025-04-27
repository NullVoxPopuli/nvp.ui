import { currentRouteName, currentURL, getSettledState, setApplication } from "@ember/test-helpers";
import { getPendingWaiterState } from "@ember/test-waiters";
import * as QUnit from "qunit";
import { setup as setupExtras } from "qunit-assertions-extra";
import { setup } from "qunit-dom";
import { start as qunitStart } from "ember-qunit";

import Application from "#app/app.ts";
import config from "#app/config.ts";

Object.assign(window, { getSettledState, getPendingWaiterState, currentURL, currentRouteName });

export function start() {
  QUnit.config.urlConfig.push({
    id: "debugA11yAudit",
    label: "Log a11y violations",
  });

  setApplication(Application.create(config.APP));

  setup(QUnit.assert);
  setupExtras(QUnit.assert);

  qunitStart();
}
