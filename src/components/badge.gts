import "./badge.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * Color variant
     */
    variant?: "primary" | "secondary" | "danger" | "default";
    /**
     * Size variant
     */
    size?: "small" | "default";
  };
  Blocks: {
    default: [];
  };
}

export const Badge: TOC<Signature> = <template>
  <span class="nvp__badge" data-variant={{@variant}} data-size={{@size}} ...attributes>
    {{yield}}
  </span>
</template>;
