import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Timeline, TimelineItem } from "#src/index.ts";

module("Timeline", function (hooks) {
  setupRenderingTest(hooks);

  test("renders a list", async function (assert) {
    await render(
      <template>
        <Timeline as |Item|>
          <Item>First</Item>
          <Item>Second</Item>
        </Timeline>
      </template>,
    );

    assert.dom("ol.nvp__timeline").exists();
    assert.dom("li.nvp__timeline__item").exists({ count: 2 });
  });

  test("renders label and title", async function (assert) {
    await render(
      <template>
        <Timeline as |Item|>
          <Item @label="Jan 2025" @title="Kickoff">
            Content here
          </Item>
        </Timeline>
      </template>,
    );

    assert.dom(".nvp__timeline__label").hasText("Jan 2025");
    assert.dom(".nvp__timeline__title").hasText("Kickoff");
    assert.dom(".nvp__timeline__body").hasText("Content here");
  });

  test("renders the default dot marker", async function (assert) {
    await render(
      <template>
        <Timeline as |Item|>
          <Item>Item</Item>
        </Timeline>
      </template>,
    );

    assert.dom(".nvp__timeline__dot").exists();
  });

  test("renders a custom icon when provided", async function (assert) {
    const MyIcon = <template>
      <span data-test-icon>★</span>
    </template>;

    await render(
      <template>
        <Timeline as |Item|>
          <Item @icon={{MyIcon}}>Item</Item>
        </Timeline>
      </template>,
    );

    assert.dom("[data-test-icon]").exists();
    assert.dom(".nvp__timeline__dot").doesNotExist();
  });

  test("TimelineItem can be used standalone", async function (assert) {
    await render(
      <template>
        <ol>
          <TimelineItem @label="2025" @title="Standalone">
            Body
          </TimelineItem>
        </ol>
      </template>,
    );

    assert.dom("li.nvp__timeline__item").exists();
    assert.dom(".nvp__timeline__label").hasText("2025");
    assert.dom(".nvp__timeline__title").hasText("Standalone");
  });
});
