import "./spinner.css";

import type { TOC } from "@ember/component/template-only";

const or = (a: unknown, b: unknown) => a || b;

export interface Signature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Size of the spinner
     */
    size?: "small" | "medium" | "large";
    /**
     * Rotation speed
     */
    speed?: "slow" | "normal" | "fast";
  };
}

export const Spinner: TOC<Signature> = <template>
  <div
    class="nvp__spinner"
    role="status"
    aria-label="Loading"
    data-size={{or @size "medium"}}
    data-speed={{or @speed "normal"}}
    ...attributes
  >
    <span class="nvp__spinner__ring"></span>
  </div>
</template>;
