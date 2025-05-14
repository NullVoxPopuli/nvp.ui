import "./progress-circle.css";

import { Progress } from "ember-primitives/components/progress";

import type { TOC } from "@ember/component/template-only";

const r = 60;
const size = Math.PI * 2 * r;
const toOffset = (x: number) => ((100 - x) / 100) * size;

export interface Signature {
  Element: HTMLElement;
  Args: {
    value: number;
    color: string;
  };
}

export const ProgressCircle: TOC<Signature> = <template>
  <Progress @value={{@value}} ...attributes as |x|>
    <x.Indicator class="preem_progress" />
    <svg width="200" height="200" viewPort="0 0 100 100">
      <circle
        r={{r}}
        cx="100"
        cy="100"
        fill="transparent"
        stroke-dasharray={{size}}
        stroke-dashoffset="0"
      ></circle>
      <circle
        r={{r}}
        cx="100"
        cy="100"
        fill="transparent"
        {{! template-lint-disable no-inline-styles style-concatenation }}
        style="stroke: {{@color}}"
        stroke-linecap="round"
        stroke-dasharray={{size}}
        stroke-dashoffset="{{toOffset x.percent}}"
      ></circle>
    </svg>
  </Progress>
</template>;
