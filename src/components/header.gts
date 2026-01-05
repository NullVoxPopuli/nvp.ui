import "./header.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Args: {
    /**
     * Position of the header bar.
     * Can be "top" (default) or "bottom".
     */
    position?: "top" | "bottom";
  };
  Blocks: {
    default: [];
  };
}

export const Header: TOC<Signature> = <template>
  <header class="preem__header" data-position={{@position}}>
    <span class="preem__header__left">
      {{yield to="left"}}
    </span>
    <span class="preem__header__right">
      {{yield to="right"}}
    </span>
  </header>
</template>;
