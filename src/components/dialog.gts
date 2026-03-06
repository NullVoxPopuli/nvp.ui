import "./dialog.css";
import "./focus.css";
import "./variables.css";

import { on } from "@ember/modifier";

import { Dialog as PrimitiveDialog } from "ember-primitives/components/dialog";

import type { TOC } from "@ember/component/template-only";
import type { WithBoundArgs } from "@glint/template";
import type { Signature as PrimitiveSignature } from "ember-primitives/components/dialog";

type PrimitiveDialogYields = PrimitiveSignature["Blocks"]["default"][0];

const CloseIcon: TOC<Record<string, never>> = <template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    height="1em"
    viewBox="0 0 384 512"
    fill="currentColor"
    aria-hidden="true"
  >
    {{! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. }}
    <path
      d="M342.6 150.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 210.7 86.6 105.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L146.7 256 41.4 361.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L192 301.3 297.4 406.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L237.3 256 342.6 150.6z"
    />
  </svg>
</template>;

export interface Signature {
  Args: {
    /**
     * Optionally set the open state of the dialog.
     * The state will still be managed internally.
     */
    open?: boolean;
    /**
     * When the dialog is closed, this function will be called.
     */
    onClose?: (returnValue: string) => void;
  };
  Blocks: {
    default: [
      {
        /**
         * Whether the dialog is open.
         */
        isOpen: boolean;

        /**
         * Opens the dialog.
         */
        open: () => void;

        /**
         * Closes the dialog.
         */
        close: () => void;

        /**
         * Apply to the element that should receive focus when the dialog closes.
         */
        focusOnClose: PrimitiveDialogYields["focusOnClose"];

        /**
         * The dialog element. Must be rendered for the dialog to work.
         */
        Dialog: WithBoundArgs<typeof StyledDialog, "PrimitiveDialog" | "close">;
      },
    ];
  };
}

const StyledDialog: TOC<{
  Args: {
    PrimitiveDialog: PrimitiveDialogYields["Dialog"];
    close: () => void;
  };
  Blocks: {
    /**
     * The title of the dialog, shown in the header.
     */
    title: [];
    /**
     * The main content of the dialog.
     */
    default: [];
    /**
     * Optional footer content (e.g., action buttons).
     */
    footer: [];
  };
}> = <template>
  <@PrimitiveDialog class="nvp__dialog">
    <div class="nvp__dialog__header">
      <div class="nvp__dialog__title">
        {{yield to="title"}}
      </div>
      <button
        type="button"
        class="nvp__dialog__close"
        aria-label="Close dialog"
        {{on "click" @close}}
      >
        <CloseIcon />
      </button>
    </div>
    {{#if (has-block)}}
      <div class="nvp__dialog__body">
        {{yield}}
      </div>
    {{/if}}
    {{#if (has-block "footer")}}
      <div class="nvp__dialog__footer">
        {{yield to="footer"}}
      </div>
    {{/if}}
  </@PrimitiveDialog>
</template>;

export const Dialog: TOC<Signature> = <template>
  <PrimitiveDialog @open={{@open}} @onClose={{@onClose}} as |d|>
    {{yield
      (object
        isOpen=d.isOpen
        open=d.open
        close=d.close
        focusOnClose=d.focusOnClose
        Dialog=(component StyledDialog PrimitiveDialog=d.Dialog close=d.close)
      )
    }}
  </PrimitiveDialog>
</template>;

function object<T extends object>(obj: T): T {
  return obj;
}
