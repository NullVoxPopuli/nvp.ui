import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Timeline } from "#src/index.ts";

module("Timeline", function (hooks) {
  setupRenderingTest(hooks);

  test("renders as a list container", async function (assert) {
    await render(
      <template>
        <Timeline as |Item|>
          <Item @indicator="✓">First</Item>
        </Timeline>
      </template>,
    );

    assert.dom(".nvp__timeline").exists();
    assert.dom(".nvp__timeline").hasAttribute("role", "list");
  });

  test("yields Item that renders with role=listitem", async function (assert) {
    await render(
      <template>
        <Timeline as |Item|>
          <Item @indicator="A">Alpha</Item>
          <Item @indicator="B">Beta</Item>
        </Timeline>
      </template>,
    );

    assert.dom(".nvp__timeline__item").exists({ count: 2 });
    assert.dom(".nvp__timeline__item").hasAttribute("role", "listitem");
  });

  module("compact mode (@indicator + default block)", function () {
    test("renders a string indicator inside the dot", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item @indicator="✓">Done</Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline__dot").hasText("✓");
      assert.dom(".nvp__timeline__summary").hasText("Done");
    });

    test("renders a component indicator", async function (assert) {
      const Icon = <template><span data-test-icon>icon</span></template>;

      await render(
        <template>
          <Timeline as |Item|>
            <Item @indicator={{Icon}}>With component</Item>
          </Timeline>
        </template>,
      );

      assert.dom("[data-test-icon]").exists();
    });
  });

  module("named blocks mode", function () {
    test("renders indicator and summary blocks", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item>
              <:indicator>★</:indicator>
              <:summary>Summary text</:summary>
            </Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline__dot").hasText("★");
      assert.dom(".nvp__timeline__summary").hasText("Summary text");
    });

    test("renders optional content block", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item>
              <:indicator>💬</:indicator>
              <:summary>Comment</:summary>
              <:content><div data-test-detail>Detail here</div></:content>
            </Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline__content").exists();
      assert.dom("[data-test-detail]").hasText("Detail here");
    });

    test("omits content wrapper when content block is not provided", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item>
              <:indicator>✓</:indicator>
              <:summary>No detail</:summary>
            </Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline__content").doesNotExist();
    });
  });

  module("status", function () {
    test("sets data-status on the item and dot", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item @status="complete" @indicator="✓">Done</Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline__item").hasAttribute("data-status", "complete");
      assert.dom(".nvp__timeline__dot").hasAttribute("data-status", "complete");
    });

    test("supports current status", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item @status="current" @indicator="→">In progress</Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline__dot").hasAttribute("data-status", "current");
    });

    test("no data-status when status is not provided", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item @indicator="?">Pending</Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline__dot").doesNotHaveAttribute("data-status");
    });
  });

  module("horizontal", function () {
    test("sets data-horizontal attribute", async function (assert) {
      await render(
        <template>
          <Timeline @horizontal={{true}} as |Item|>
            <Item @indicator="1">Step 1</Item>
            <Item @indicator="2">Step 2</Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline").hasAttribute("data-horizontal", "true");
    });

    test("does not set data-horizontal when false", async function (assert) {
      await render(
        <template>
          <Timeline as |Item|>
            <Item @indicator="1">Step 1</Item>
          </Timeline>
        </template>,
      );

      assert.dom(".nvp__timeline").doesNotHaveAttribute("data-horizontal");
    });
  });

  test("plain dot when no indicator is provided", async function (assert) {
    await render(
      <template>
        <Timeline as |Item|>
          <Item @status="complete">No icon</Item>
        </Timeline>
      </template>,
    );

    assert.dom(".nvp__timeline__dot").exists();
    assert.dom(".nvp__timeline__dot").hasNoText();
  });

  test("splats attributes on the item", async function (assert) {
    await render(
      <template>
        <Timeline as |Item|>
          <Item @indicator="✓" data-test-custom>Content</Item>
        </Timeline>
      </template>,
    );

    assert.dom("[data-test-custom]").exists();
    assert.dom("[data-test-custom]").hasClass("nvp__timeline__item");
  });

  test("splats attributes on the timeline container", async function (assert) {
    await render(
      <template>
        <Timeline data-test-timeline as |Item|>
          <Item @indicator="✓">Content</Item>
        </Timeline>
      </template>,
    );

    assert.dom("[data-test-timeline]").exists();
    assert.dom("[data-test-timeline]").hasClass("nvp__timeline");
  });
});
