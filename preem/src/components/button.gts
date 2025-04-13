import './button.css';

import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';

export interface Signature {
  /**
   * The underlying button element is not exposed,
   * as doing so could lead to misuse.
   */
  Element: null;
  Args: {
    /**
     * The `@disabled` describes why a button is disabled.
     * This information will appear in a focusable tooltip so that users may
     * understand why their button is disabled.
     *
     * Additionally, when clicking the button, the `@disabled` information will appear.
     *
     * Sets the `aria-disabled` attribute as well.
     */
    disabled: string | ComponentLike;

    /**
     * What action to perform upon click
     */
    onClick: (event: Event) => void;

    /**
     * What colors to make the button.
     */
    variant?: 'danger' | 'primary' | 'secondary' | 'default' | undefined;
  };
  Blocks: {
    default: [];
  };
}

export const Button: TOC<Signature> = <template>
  <button class='preem__button' data-variant={{@variant}} aria-disabled={{Boolean @disabled}}>
    {{yield}}
  </button>
</template>;
