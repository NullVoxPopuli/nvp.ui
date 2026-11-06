import "./variables.css";
import "./focus.css";
import "./range-slider.css";

import Component from "@glimmer/component";
import { on } from "@ember/modifier";

import { Slider } from "ember-primitives/components/slider";

export interface Signature {
  /**
   * The outer element, with `role="group"`.
   */
  Element: HTMLSpanElement;
  Args: {
    /**
     * Accessible name for the group of two thumbs.
     */
    label: string;

    /**
     * The lowest value. Default: `0`.
     */
    min?: number;

    /**
     * The highest value.
     */
    max: number;

    /**
     * The value of the first thumb.
     */
    start: number;

    /**
     * The value of the second thumb.
     */
    end: number;

    /**
     * Values snap to multiples of `@step`, counted from `@min`. Default: `1`.
     *
     * Arrow keys move a thumb by one step.
     */
    step?: number;

    /**
     * The smallest distance between the two thumbs. Default: `@step`.
     */
    minGap?: number;

    /**
     * Called with the new values when a thumb moves.
     *
     * The slider is controlled: it shows `@start` and `@end`,
     * so pass the new values back in.
     */
    onChange: (start: number, end: number) => void;

    /**
     * Turns a value into text for assistive technology (`aria-valuetext`)
     * and for the visible thumb labels.
     *
     * Default: the number as is.
     */
    formatValue?: (value: number) => string;

    /**
     * Accessible name of the first thumb. Default: `"Start"`.
     */
    startLabel?: string;

    /**
     * Accessible name of the second thumb. Default: `"End"`.
     */
    endLabel?: string;
  };
  Blocks: {
    /**
     * Extra content inside the track, under the thumbs,
     * for example a playhead.
     *
     * `position` turns a value into a percentage of the track width.
     */
    default: [{ position: (value: number) => number }];
  };
}

function clamp(value: number, low: number, high: number) {
  if (value < low) return low;
  if (value > high) return high;

  return value;
}

/**
 * Counts the decimals of the step, so that snapped values
 * do not carry float noise such as 0.30000000000000004.
 */
function decimalsOf(step: number) {
  const text = String(step);
  const dot = text.indexOf(".");

  return dot === -1 ? 0 : text.length - dot - 1;
}

export class RangeSlider extends Component<Signature> {
  get min() {
    return this.args.min ?? 0;
  }

  get step() {
    return this.args.step ?? 1;
  }

  get minGap() {
    return this.args.minGap ?? this.step;
  }

  get values() {
    return [this.args.start, this.args.end];
  }

  get startLabel() {
    return this.args.startLabel ?? "Start";
  }

  get endLabel() {
    return this.args.endLabel ?? "End";
  }

  get blockArgs() {
    return { position: this.position };
  }

  position = (value: number) => {
    const span = this.args.max - this.min;

    if (span <= 0) return 0;

    return ((clamp(value, this.min, this.args.max) - this.min) / span) * 100;
  };

  format = (value: number) => {
    return this.args.formatValue ? this.args.formatValue(value) : String(value);
  };

  /**
   * Slider keeps the thumbs in order, and `@minGap` keeps them apart.
   * The thumb that moved stops at the gap. The other thumb stays.
   */
  change = (value: number | number[]) => {
    if (!Array.isArray(value)) return;

    const { start, end, max } = this.args;
    const gap = Math.min(this.minGap, max - this.min);
    const decimals = decimalsOf(this.step);
    let [nextStart = start, nextEnd = end] = value;

    if (nextStart !== start) {
      nextStart = clamp(nextStart, this.min, end - gap);
    } else if (nextEnd !== end) {
      nextEnd = clamp(nextEnd, start + gap, max);
    }

    nextStart = Number(nextStart.toFixed(decimals));
    nextEnd = Number(nextEnd.toFixed(decimals));

    if (nextStart === start && nextEnd === end) return;

    this.args.onChange(nextStart, nextEnd);
  };

  /**
   * The native input moves before `@onChange` decides.
   * If the thumb stays, the input goes back to it,
   * so that the next key press and assistive technology use the real value.
   */
  resync = (event: Event) => {
    const input = event.target as HTMLInputElement;
    const part = input.dataset["part"];

    if (part !== "start" && part !== "end") return;

    const value = String(part === "start" ? this.args.start : this.args.end);

    if (input.value !== value) input.value = value;
  };

  <template>
    <Slider
      class="nvp__range-slider"
      role="group"
      aria-label={{@label}}
      @value={{this.values}}
      @min={{this.min}}
      @max={{@max}}
      @step={{this.step}}
      @onValueChange={{this.change}}
      {{on "input" this.resync}}
      {{on "change" this.resync}}
      ...attributes
      as |s|
    >
      <s.Track class="nvp__range-slider__track">
        <s.Range class="nvp__range-slider__range" />

        {{yield this.blockArgs}}

        <s.Thumb
          @index={{0}}
          @value={{@start}}
          aria-label={{this.startLabel}}
          aria-valuetext={{this.format @start}}
          data-part="start"
        >
          <span class="nvp__range-slider__value">{{this.format @start}}</span>
        </s.Thumb>

        <s.Thumb
          @index={{1}}
          @value={{@end}}
          aria-label={{this.endLabel}}
          aria-valuetext={{this.format @end}}
          data-part="end"
        >
          <span class="nvp__range-slider__value">{{this.format @end}}</span>
        </s.Thumb>
      </s.Track>
    </Slider>
  </template>
}
