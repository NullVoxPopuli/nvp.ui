import "./variables.css";
import "./focus.css";
import "./pagination.css";
import { pageSlots } from "./-private/page-slots.ts";
import type { TOC } from "@ember/component/template-only";
export { pageSlots };
export interface Signature {
    /**
     * The `<nav>` around the links.
     *
     * Its accessible name is "Pagination".
     * Set `aria-label` to change it.
     */
    Element: HTMLElement;
    Args: {
        totalPages: number;
    };
}
/**
 * Page links, driven by the router.
 *
 * The current page is the `page` query param, counted from 1.
 * Each link is a plain anchor whose href is the current URL
 * with `page` set and every other query param kept.
 * The router is the click handler.
 *
 * The app must:
 * - hand anchor clicks to the router, with `properLinks`
 *   from `ember-primitives/proper-links`
 * - declare `page` on the route that reads it
 *
 * The layout never changes shape as the page changes:
 * - first, previous, next and last are always rendered
 * - five page links slide around the current page
 */
export declare const Pagination: TOC<Signature>;
//# sourceMappingURL=pagination.d.ts.map