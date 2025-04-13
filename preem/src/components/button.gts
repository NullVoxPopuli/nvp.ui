import './button.css';

import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';

export interface Signature {
  Element: HTMLButtonElement;
  Args: {
    disabled: string | ComponentLike;
  };
  Blocks: {
    default: [];
  };
}

export const Button: TOC<Signature> = <template>
  <button ...attributes>

  </button>
</template>;
