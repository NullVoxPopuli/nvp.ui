import "./gradient-wave-text.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * Animation speed in seconds
     */
    speed?: number;
    /**
     * Custom gradient colors (4 hex values)
     */
    colors?: string[];
  };
  Blocks: {
    default: [];
  };
}

const waveStyle = (speed: number | undefined, colors: string[] | undefined) => {
  const parts: string[] = [];

  if (speed) parts.push(`--wave-speed: ${speed}s`);

  if (colors && colors.length >= 4) {
    parts.push(`--wave-color-1: ${colors[0]}`);
    parts.push(`--wave-color-2: ${colors[1]}`);
    parts.push(`--wave-color-3: ${colors[2]}`);
    parts.push(`--wave-color-4: ${colors[3]}`);
  }

  return parts.length ? parts.join(";") : undefined;
};

export const GradientWaveText: TOC<Signature> = <template>
  {{! template-lint-disable no-inline-styles }}
  <span class="nvp__gradient-wave-text" style={{waveStyle @speed @colors}} ...attributes>
    {{yield}}
  </span>
</template>;
