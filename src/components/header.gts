import "./header.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Blocks: {
    default: [];
  };
}

export const Header: TOC<Signature> = <template>
  <header class="preem__header">
    {{yield}}
  </header>
</template>;
