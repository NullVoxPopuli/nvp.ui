import "./header.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLElement;
  Args: {
    /**
     * Position of the header bar.
     * Can be "top" (default) or "bottom".
     */
    position?: "top" | "bottom";
  };
  Blocks: {
    left: [];
    right: [];
  };
}

export const Header: TOC<Signature> = <template>
  <header class="nvp__header surface elevation-xl2" data-position={{@position}} ...attributes>
    <span class="nvp__header__left">
      {{yield to="left"}}
    </span>
    <span class="nvp__header__right">
      {{yield to="right"}}
    </span>
  </header>
</template>;
