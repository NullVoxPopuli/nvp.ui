import "./polite-sticky.css";
/**
 * A modifier that makes a sticky header or footer "polite" —
 * it stays out of the way while reading content.
 *
 * On a `<header>` (or any non-footer element): slides up as the
 * user scrolls down, slides back as they scroll up.
 *
 * On a `<footer>`: slides down as the user scrolls up, slides
 * back as they scroll down.
 *
 * The element type is detected automatically from the tag name.
 * The animation is scroll-linked — the element tracks the scroll
 * position 1:1 via a CSS custom property `--polite-offset`.
 *
 * @example
 * ```gts
 * import { politeSticky } from "nvp.ui/polite-sticky";
 *
 * <template>
 *   <header {{politeSticky}}>
 *     My App
 *   </header>
 *
 *   <footer {{politeSticky}}>
 *     Footer content
 *   </footer>
 * </template>
 * ```
 */
export declare const politeSticky: import("ember-modifier").FunctionBasedModifier<{
    Args: {
        Positional: unknown[];
        Named: import("ember-modifier/-private/signature").EmptyObject;
    };
    Element: HTMLElement;
}>;
//# sourceMappingURL=polite-sticky.d.ts.map