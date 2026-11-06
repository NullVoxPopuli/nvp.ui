import { fillIn, render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { TrackedObject } from "tracked-built-ins";

import { RangeSlider } from "#src/index.ts";

module("RangeSlider", function (hooks) {
  setupRenderingTest(hooks);

  test("renders two sliders with their values", async function (assert) {
    const format = (value: number) => `${value}s`;
    const noop = () => {};

    await render(
      <template>
        <RangeSlider
          @label="Loop"
          @max={{10}}
          @start={{2}}
          @end={{8}}
          @formatValue={{format}}
          @onChange={{noop}}
        />
      </template>,
    );

    assert.dom('[role="group"]').hasAria("label", "Loop");
    assert.dom('[data-part="start"]').hasAttribute("type", "range");
    assert.dom('[data-part="start"]').hasAria("label", "Start");
    assert.dom('[data-part="start"]').hasValue("2");
    assert.dom('[data-part="start"]').hasAria("valuetext", "2s");
    assert.dom('[data-part="end"]').hasAria("label", "End");
    assert.dom('[data-part="end"]').hasValue("8");
    assert.dom('[data-part="end"]').hasAttribute("max", "10");
    assert.dom(".nvp__range-slider__value").exists({ count: 2 });
    assert.dom('[data-part="start"] + * .nvp__range-slider__value').hasText("2s");
    assert.dom('[data-part="end"] + * .nvp__range-slider__value').hasText("8s");
  });

  test("moving a thumb reports both values, and the thumbs stay apart", async function (assert) {
    const state = new TrackedObject({ start: 2, end: 4 });
    const change = (start: number, end: number) => {
      assert.step(`change ${start} ${end}`);
      state.start = start;
      state.end = end;
    };

    await render(
      <template>
        <RangeSlider
          @label="Loop"
          @max={{10}}
          @start={{state.start}}
          @end={{state.end}}
          @onChange={{change}}
        />
      </template>,
    );

    await fillIn('[data-part="start"]', "3");
    assert.verifySteps(["change 3 4"]);

    await fillIn('[data-part="start"]', "4");
    assert.verifySteps([], "the start stays one step below the end");
    assert.dom('[data-part="start"]').hasValue("3");

    await fillIn('[data-part="end"]', "10");
    assert.verifySteps(["change 3 10"]);

    await fillIn('[data-part="start"]', "0");
    assert.verifySteps(["change 0 10"]);

    await fillIn('[data-part="end"]', "0");
    assert.verifySteps(["change 0 1"], "the end stays one step above the start");

    assert.dom('[data-part="end"]').hasValue("1");
  });

  test("@minGap keeps the thumbs apart", async function (assert) {
    const state = new TrackedObject({ start: 2, end: 8 });
    const change = (start: number, end: number) => {
      assert.step(`change ${start} ${end}`);
      state.start = start;
      state.end = end;
    };

    await render(
      <template>
        <RangeSlider
          @label="Loop"
          @max={{10}}
          @minGap={{3}}
          @start={{state.start}}
          @end={{state.end}}
          @onChange={{change}}
        />
      </template>,
    );

    await fillIn('[data-part="start"]', "7");
    assert.verifySteps(["change 5 8"]);

    await fillIn('[data-part="end"]', "6");
    assert.verifySteps([]);
    assert.dom('[data-part="end"]').hasValue("8");
  });

  test("@step snaps values without float noise", async function (assert) {
    const state = new TrackedObject({ start: 0.1, end: 1 });
    const change = (start: number, end: number) => {
      assert.step(`change ${start} ${end}`);
      state.start = start;
      state.end = end;
    };

    await render(
      <template>
        <RangeSlider
          @label="Loop"
          @max={{1}}
          @step={{0.1}}
          @start={{state.start}}
          @end={{state.end}}
          @onChange={{change}}
        />
      </template>,
    );

    await fillIn('[data-part="start"]', "0.3");
    await fillIn('[data-part="end"]', "0.7");
    assert.verifySteps(["change 0.3 1", "change 0.3 0.7"]);
  });

  test("the block can place content on the track", async function (assert) {
    const noop = () => {};

    await render(
      <template>
        <RangeSlider @label="Loop" @max={{10}} @start={{0}} @end={{10}} @onChange={{noop}} as |r|>
          <span data-test-playhead>{{r.position 2.5}}</span>
        </RangeSlider>
      </template>,
    );

    assert.dom(".nvp__range-slider__track [data-test-playhead]").hasText("25");
  });
});
