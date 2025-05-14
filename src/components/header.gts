import "./header.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Blocks: {
    default: [];
  };
}

export const Header: TOC<Signature> = <template>
  <header class="preem__header">
    <span class="preem__header__left">
      {{yield to="left"}}
    </span>
    <span class="preem__header__right">
      {{yield to="right"}}
    </span>
  </header>
</template>;
