import './variables.css';
import './focus.css';
import './button.css';

import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';
import { Popover } from 'ember-primitives';
import { on } from '@ember/modifier';
import { tracked } from '@glimmer/tracking';

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
    /**
     * Default content to make the button
     */
    default: [];
  };
}

const or = (a: unknown, b: unknown) => a || b;
const isString = (x: unknown) => typeof x === 'string';

export class Button extends Component<Signature> {
  @tracked isFocused = false;
  handleFocus = () => (this.isFocused = true);
  handleBlur = () => (this.isFocused = true);

  <template>
    <Popover @inline={{true}} as as |popover|>
      <style>
        .floatybit {
          width: max-content;
          position: absolute;
          top: 0;
          left: 0;
          background: #222;
          color: white;
          font-weight: bold;
          padding: 5px;
          border-radius: 4px;
          font-size: 90%;
          filter: drop-shadow(0 0 0.75rem rgba(0, 0, 0, 0.4));
          z-index: 10;
        }
        .arrow {
          position: absolute;
          background: #222;
          width: 8px;
          height: 8px;
          transform: rotate(45deg);
        }
      </style>

      <button
        class='preem__button'
        data-variant={{@variant}}
        aria-disabled={{Boolean @disabled}}
        {{popover.reference}}
        {{on 'mouseover' this.handleFocus}}
        {{on 'mouseleave' this.handleBlur}}
        {{on 'focus' this.handleFocus}}
        {{on 'blur' this.handleBlur}}
      >
        {{#if this.isFocused}}
          {{#if @disabled}}
            <popover.Content class='floatybit'>
              {{#if (isString @disabled)}}
                {{@disabled}}
              {{else}}
                <@disabled />
              {{/if}}
              <div class='arrow' {{popover.arrow}}></div>
            </popover.Content>
          {{/if}}
        {{/if}}
        {{#if (or (has-block 'start') @start)}}
          <span>{{@start}}{{yield to='start'}}</span>
        {{/if}}

        {{#if (or (has-block) (has-block 'text'))}}
          <span>{{yield}}{{yield to='text'}}</span>
        {{/if}}

        {{#if (or (has-block 'end') @end)}}
          <span>{{@end}}{{yield to='end'}}</span>
        {{/if}}
      </button>
    </Popover>
  </template>
}
