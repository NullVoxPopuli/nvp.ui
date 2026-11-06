import "./range-slider.css"
import '../variables-goOgJf2v.js';
import '../focus-C7z7jBjO.js';
import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { Slider } from 'ember-primitives/components/slider';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';

;

function clamp(value, low, high) {
  if (value < low) return low;
  if (value > high) return high;
  return value;
}
/**
 * Counts the decimals of the step, so that snapped values
 * do not carry float noise such as 0.30000000000000004.
 */
function decimalsOf(step) {
  const text = String(step);
  const dot = text.indexOf(".");
  return dot === -1 ? 0 : text.length - dot - 1;
}
class RangeSlider extends Component {
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
    return {
      position: this.position
    };
  }
  position = value => {
    const span = this.args.max - this.min;
    if (span <= 0) return 0;
    return (clamp(value, this.min, this.args.max) - this.min) / span * 100;
  };
  format = value => {
    return this.args.formatValue ? this.args.formatValue(value) : String(value);
  };
  /**
  * Slider keeps the thumbs in order, and `@minGap` keeps them apart.
  * The thumb that moved stops at the gap. The other thumb stays.
  */
  change = value => {
    if (!Array.isArray(value)) return;
    const {
      start,
      end,
      max
    } = this.args;
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
  * Slider reports a commit after the change,
  * so `@start` and `@end` already have the values that `@onChange` accepted.
  */
  commit = () => {
    this.args.onCommit?.(this.args.start, this.args.end);
  };
  /**
  * The native input moves before `@onChange` decides.
  * If the thumb stays, the input goes back to it,
  * so that the next key press and assistive technology use the real value.
  */
  resync = event => {
    const input = event.target;
    const part = input.dataset["part"];
    if (part !== "start" && part !== "end") return;
    const value = String(part === "start" ? this.args.start : this.args.end);
    if (input.value !== value) input.value = value;
  };
  static {
    setComponentTemplate(precompileTemplate("<Slider class=\"nvp__range-slider\" role=\"group\" aria-label={{@label}} @value={{this.values}} @min={{this.min}} @max={{@max}} @step={{this.step}} @onValueChange={{this.change}} @onValueCommit={{this.commit}} {{on \"input\" this.resync}} {{on \"change\" this.resync}} ...attributes as |s|>\n  <s.Track class=\"nvp__range-slider__track\">\n    <s.Range class=\"nvp__range-slider__range\" />\n\n    {{yield this.blockArgs}}\n\n    <s.Thumb @index={{0}} @value={{@start}} aria-label={{this.startLabel}} aria-valuetext={{this.format @start}} data-part=\"start\">\n      <span class=\"nvp__range-slider__value\">{{this.format @start}}</span>\n    </s.Thumb>\n\n    <s.Thumb @index={{1}} @value={{@end}} aria-label={{this.endLabel}} aria-valuetext={{this.format @end}} data-part=\"end\">\n      <span class=\"nvp__range-slider__value\">{{this.format @end}}</span>\n    </s.Thumb>\n  </s.Track>\n</Slider>", {
      strictMode: true,
      scope: () => ({
        Slider,
        on
      })
    }), this);
  }
}

export { RangeSlider };
//# sourceMappingURL=range-slider.js.map
