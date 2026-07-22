import type { Signature as ButtonSignature } from './button';
import type { TOC } from "@ember/component/template-only";
export interface Signature {
    /**
     * The underlying `<button>` element, provided by `<Button>`.
     */
    Element: ButtonSignature["Element"];
    Args: {
        /**
         * Whether the toggle is currently pressed (on).
         *
         * Rendered as the `aria-pressed` attribute, which is what identifies
         * the button to assistive technology as a toggle button, and whether
         * that toggle is currently on or off.
         */
        pressed: boolean;
        /**
         * The `@disabled` describes why the toggle is disabled.
         * This information will appear in a focusable tooltip so that users may
         * understand why their button is disabled.
         *
         * Additionally, when clicking the button, the `@disabled` information will appear.
         *
         * Sets the `aria-disabled` attribute as well.
         */
        disabled?: ButtonSignature["Args"]["disabled"];
        /**
         * What action to perform upon click, typically flipping the state
         * passed to `@pressed`.
         */
        onClick?: ButtonSignature["Args"]["onClick"];
        /**
         * What colors to make the button.
         */
        variant?: ButtonSignature["Args"]["variant"];
        /**
         * Content before the button contents (such as for an icon)
         */
        start?: ButtonSignature["Args"]["start"];
        /**
         * Content after the button contents (such as for an icon)
         */
        end?: ButtonSignature["Args"]["end"];
    };
    Blocks: {
        /**
         * Default content for button contents
         */
        default: [];
    };
}
export declare const ToggleButton: TOC<Signature>;
//# sourceMappingURL=toggle-button.d.ts.map