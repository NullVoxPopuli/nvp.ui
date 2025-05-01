import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { ExternalLink } from "#src/index.ts";

module("ExternalLink", function (hooks) {
  setupRenderingTest(hooks);

  test("it works", async function (assert) {
    await render(
      <template>
        <ExternalLink href="google.com">
          hello
        </ExternalLink>
      </template>,
    );

    assert.dom("a").exists();
    assert.dom("a").hasText("hello");
    assert.dom("svg").exists();
  });
});
