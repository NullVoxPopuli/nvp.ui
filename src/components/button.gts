import "./variables.css";
import "./focus.css";
import "./button.css";

import { Popover } from "ember-primitives";

import type { TOC } from "@ember/component/template-only";
import type { ComponentLike } from "@glint/template";

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
    variant?: "danger" | "primary" | "secondary" | "default" | undefined;

    /**
     * Content before the button contents (such as for an icon)
     *
     * The `<:start>` block should not be used if using this arg
     */
    start?: string;
    /**
     * Content after the button contents (such as for an icon)
     *
     * The `<:end>` block should not be used if using this arg
     */
    end?: string;
  };
  Blocks: {
    /**
     * Default content for button contents
     */
    default: [];
    /**
     * Default content for button contents
     */
    text: [];
    /**
     * Content before the button contents (such as for an icon)
     *
     * The `@start` arg should not be used if using this block
     */
    start: [];
    /**
     * Content after the button contents (such as for an icon)
     *
     * The `@end` arg should not be used if using this block
     */
    end: [];
  };
}

const or = (a: unknown, b: unknown) => a || b;
const isString = (x: unknown) => typeof x === "string";

export const Button: TOC<Signature> = <template>
  <Popover @inline={{true}} as |popover|>
    <button
      class="preem__button"
      data-variant={{@variant}}
      aria-disabled={{Boolean @disabled}}
      type="button"
      {{popover.reference}}
    >
      {{#if @disabled}}
        {{! Needs more work -- maybe using a menu instead of popover }}
        {{! template-lint-disable no-nested-interactive }}
        <popover.Content tabindex="0" class="preem__button__disabled-reason">
          {{#if (isString @disabled)}}
            {{@disabled}}
          {{else}}
            <@disabled />
          {{/if}}
          <div class="arrow" {{popover.arrow}}></div>
        </popover.Content>
      {{/if}}

      {{#if (or (has-block "start") @start)}}
        <span>{{@start}}{{yield to="start"}}</span>
      {{/if}}

      {{#if (or (has-block) (has-block "text"))}}
        <span class="preem__button__text">{{yield}}{{yield to="text"}}</span>
      {{/if}}

      {{#if (or (has-block "end") @end)}}
        <span>{{@end}}{{yield to="end"}}</span>
      {{/if}}
    </button>
  </Popover>
</template>;
