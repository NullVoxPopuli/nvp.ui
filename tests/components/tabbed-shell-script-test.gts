import { click, render, resetOnerror, setupOnerror } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { TabbedShellScript } from "#src/index.ts";

module("TabbedShellScript", function (hooks) {
  setupRenderingTest(hooks);

  test("one tab per script", async function (assert) {
    await render(
      <template>
        <TabbedShellScript as |Tab|>
          <Tab @label="pnpm" @script="pnpm add nvp.ui" />
          <Tab @label="npm" @script="npm install nvp.ui" />
        </TabbedShellScript>
      </template>,
    );

    assert.dom('[role="tab"]').exists({ count: 2 });
    assert.dom('[role="tab"]:nth-of-type(1)').hasText("pnpm");
    assert.dom('[role="tabpanel"] pre code').hasText("pnpm add nvp.ui");

    await click('[role="tab"]:nth-of-type(2)');

    assert.dom('[role="tabpanel"] pre code').hasText("npm install nvp.ui");
  });

  test("line breaks in the script stay", async function (assert) {
    const script = "pnpm install\npnpm test";

    await render(
      <template>
        <TabbedShellScript as |Tab|>
          <Tab @label="pnpm" @script={{script}} />
        </TabbedShellScript>
      </template>,
    );

    const code = document.querySelector('[role="tabpanel"] pre code');

    assert.strictEqual(code?.textContent, "pnpm install\npnpm test");
  });

  test("@scripts", async function (assert) {
    const scripts = [
      { label: "pnpm", script: "pnpm add nvp.ui" },
      { label: "npm", script: "npm install nvp.ui" },
    ];

    await render(<template><TabbedShellScript @scripts={{scripts}} /></template>);

    assert.dom('[role="tab"]').exists({ count: 2 });
    assert.dom('[role="tab"]:nth-of-type(2)').hasText("npm");
    assert.dom('[role="tabpanel"] pre code').hasText("pnpm add nvp.ui");

    await click('[role="tab"]:nth-of-type(2)');

    assert.dom('[role="tabpanel"] pre code').hasText("npm install nvp.ui");
  });

  test("@scripts and a block together throw", async function (assert) {
    const scripts = [{ label: "pnpm", script: "pnpm add nvp.ui" }];

    setupOnerror((error: Error) => {
      assert.step(error.message);
    });

    await render(
      <template>
        <TabbedShellScript @scripts={{scripts}} as |Tab|>
          <Tab @label="npm" @script="npm install nvp.ui" />
        </TabbedShellScript>
      </template>,
    );

    resetOnerror();

    assert.verifySteps([
      "Assertion Failed: <TabbedShellScript> takes @scripts or a block, not both",
    ]);
  });
});
