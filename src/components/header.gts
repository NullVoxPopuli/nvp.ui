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
  <header class="preem__header surface" data-position={{@position}} ...attributes>
    <span class="preem__header__left">
      {{yield to="left"}}
    </span>
    <span class="preem__header__right">
      {{yield to="right"}}
    </span>
  </header>
</template>;
