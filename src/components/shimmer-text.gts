import "./shimmer-text.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * Animation duration in seconds
     */
    duration?: number;
    /**
     * Delay before animation starts in seconds
     */
    delay?: number;
  };
  Blocks: {
    default: [];
  };
}

const shimmerStyle = (duration: number | undefined, delay: number | undefined) => {
  const parts: string[] = [];

  if (duration) parts.push(`--shimmer-duration: ${duration}s`);
  if (delay) parts.push(`--shimmer-delay: ${delay}s`);

  return parts.length ? parts.join(";") : undefined;
};

export const ShimmerText: TOC<Signature> = <template>
  {{! template-lint-disable no-inline-styles }}
  <span class="nvp__shimmer-text" style={{shimmerStyle @duration @delay}} ...attributes>
    {{yield}}
  </span>
</template>;
