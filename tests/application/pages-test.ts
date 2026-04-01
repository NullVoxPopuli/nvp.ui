import { findAll, settled, visit, waitUntil } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupApplicationTest } from "ember-qunit";

import { colorScheme } from "ember-primitives/color-scheme";

import { a11yAudit } from "ember-a11y-testing/test-support";

// @ts-expect-error virtual module provided by kolay's vite plugin
// eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
const { manifest } = await import("kolay/compiled-docs:virtual");
// eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-call
const pages = manifest.groups.flatMap((g: { list: { path: string }[] }) => g.list) as {
  path: string;
}[];

/**
 * a11yAudit halts tests, this gets around that
 */
async function checkA11y(assert: Assert, path: string, theme: string) {
  await settled();

  try {
    await a11yAudit({
      rules: {
        // TODO: find a syntax highlighting theme
        //       with better contrast
        "color-contrast": {
          enabled: false,
        },
        "button-name": {
          enabled: false,
        },
        "landmark-no-duplicate-main": {
          enabled: false,
        },
        /**
         * We know how to do this
         */
        "nested-interactive": {
          enabled: false,
        },
        /**
         * Disabled because markdown tables don't have titles, and usually using <h1-h6>
         * to provide that information.
         */
        "empty-table-header": {
          enabled: false,
        },
      },
    });
    assert.ok(true, `no a11y errors found for ${path} using the ${theme} theme`);
  } catch (e) {
    let errorText = "";

    if (typeof e === "object") {
      if (e && "message" in e && typeof e.message === "string") {
        errorText = e.message;
      }
    }

    const message =
      `no a11y errors found for ${path} using the ${theme} theme` + `\n\n` + errorText;

    if (window.location.search.includes("debugA11yAudit")) {
      console.error(errorText);
    }

    assert.ok(false, message);
  }
}

module("Application | Pages", function (hooks) {
  setupApplicationTest(hooks);

  for (const page of pages) {
    test(`${page.path}`, async function (assert) {
      const path = page.path.replace(".md", "");

      await visit(path);
      await waitUntil(() => findAll("nav a").length !== 0);
      await checkA11y(assert, path, "default");

      colorScheme.update("dark");
      await checkA11y(assert, path, "dark");

      colorScheme.update("light");
      await checkA11y(assert, path, "light");
    });
  }
});
