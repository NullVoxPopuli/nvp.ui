import "./variables.css";
import "./focus.css";
import "./pagination.css";

import { qp, withQP } from "ember-primitives/qp";

import { pageSlots } from "./-private/page-slots.ts";

import type { TOC } from "@ember/component/template-only";

export { pageSlots };

/**
 * Anyone can type a query param,
 * and a collection can shrink after a link to its last page is shared.
 */
function pageOf(param: string | undefined, totalPages: number) {
  return Math.max(1, Math.min(Number(param) || 1, totalPages));
}

function slotsOf(page: number, totalPages: number) {
  return pageSlots(page, totalPages, 5);
}

function asString(page: number) {
  return String(page);
}

function isCurrent(page: number, current: number) {
  return page === current;
}

function isLast(page: number, totalPages: number) {
  return page >= totalPages;
}

function before(page: number) {
  return page - 1;
}

function after(page: number) {
  return page + 1;
}

interface EdgeSignature {
  Args: {
    rel: "first" | "prev" | "next" | "last";
    href: string;
    label: string;
    symbol: string;
    /**
     * Whether the symbol comes after the label.
     *
     * Forward controls point right, so their symbol trails.
     */
    symbolAfter?: boolean;
    disabled: boolean;
  };
}

/**
 * First, previous, next, last.
 *
 * Always rendered, so the row never changes shape.
 * At the ends, the control is a link without an href,
 * which is how HTML spells a link that goes nowhere.
 */
const Edge: TOC<EdgeSignature> = <template>
  <li>
    <a
      class="nvp__pagination__link"
      data-rel={{@rel}}
      href={{unless @disabled @href}}
      role={{if @disabled "link"}}
      aria-disabled={{if @disabled "true"}}
    >
      {{#unless @symbolAfter}}
        <span aria-hidden="true">{{@symbol}}</span>
      {{/unless}}
      <span class="nvp__pagination__label">{{@label}}</span>
      {{#if @symbolAfter}}
        <span aria-hidden="true">{{@symbol}}</span>
      {{/if}}
    </a>
  </li>
</template>;

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
export const Pagination: TOC<Signature> = <template>
  <nav class="nvp__pagination" aria-label="Pagination" ...attributes>
    {{#let (pageOf (qp "page") @totalPages) as |current|}}
      <ul class="nvp__pagination__list">
        <Edge
          @rel="first"
          @href={{withQP "page" "1"}}
          @label="First"
          @symbol="«"
          @disabled={{isCurrent current 1}}
        />
        <Edge
          @rel="prev"
          @href={{withQP "page" (asString (before current))}}
          @label="Previous"
          @symbol="‹"
          @disabled={{isCurrent current 1}}
        />

        {{#each (slotsOf current @totalPages) as |page|}}
          <li>
            <a
              class="nvp__pagination__link"
              data-page={{page}}
              aria-current={{if (isCurrent page current) "page"}}
              href={{withQP "page" (asString page)}}
            >
              {{page}}
            </a>
          </li>
        {{/each}}

        <Edge
          @rel="next"
          @href={{withQP "page" (asString (after current))}}
          @label="Next"
          @symbol="›"
          @symbolAfter={{true}}
          @disabled={{isLast current @totalPages}}
        />
        <Edge
          @rel="last"
          @href={{withQP "page" (asString @totalPages)}}
          @label="Last"
          @symbol="»"
          @symbolAfter={{true}}
          @disabled={{isLast current @totalPages}}
        />
      </ul>
    {{/let}}
  </nav>
</template>;
