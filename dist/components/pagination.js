import "./pagination.css"
import '../variables-goOgJf2v.js';
import '../focus-C7z7jBjO.js';
import { withQP, qp } from 'ember-primitives/qp';
import { pageSlots } from './-private/page-slots.js';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

/**
 * Anyone can type a query param,
 * and a collection can shrink after a link to its last page is shared.
 */
function pageOf(param, totalPages) {
  return Math.max(1, Math.min(Number(param) || 1, totalPages));
}
function slotsOf(page, totalPages) {
  return pageSlots(page, totalPages, 5);
}
function asString(page) {
  return String(page);
}
function isCurrent(page, current) {
  return page === current;
}
function isLast(page, totalPages) {
  return page >= totalPages;
}
function before(page) {
  return page - 1;
}
function after(page) {
  return page + 1;
}
/**
 * First, previous, next, last.
 *
 * Always rendered, so the row never changes shape.
 * At the ends, the control is a link without an href,
 * which is how HTML spells a link that goes nowhere.
 */
const Edge = setComponentTemplate(precompileTemplate("<li>\n  <a class=\"nvp__pagination__link\" data-rel={{@rel}} href={{unless @disabled @href}} role={{if @disabled \"link\"}} aria-disabled={{if @disabled \"true\"}}>\n    {{#unless @symbolAfter}}\n      <span aria-hidden=\"true\">{{@symbol}}</span>\n    {{/unless}}\n    <span class=\"nvp__pagination__label\">{{@label}}</span>\n    {{#if @symbolAfter}}\n      <span aria-hidden=\"true\">{{@symbol}}</span>\n    {{/if}}\n  </a>\n</li>", {
  strictMode: true
}), templateOnly());
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
const Pagination = setComponentTemplate(precompileTemplate("<nav class=\"nvp__pagination\" aria-label=\"Pagination\" ...attributes>\n  {{#let (pageOf (qp \"page\") @totalPages) as |current|}}\n    <ul class=\"nvp__pagination__list\">\n      <Edge @rel=\"first\" @href={{withQP \"page\" \"1\"}} @label=\"First\" @symbol=\"\xAB\" @disabled={{isCurrent current 1}} />\n      <Edge @rel=\"prev\" @href={{withQP \"page\" (asString (before current))}} @label=\"Previous\" @symbol=\"\u2039\" @disabled={{isCurrent current 1}} />\n\n      {{#each (slotsOf current @totalPages) as |page|}}\n        <li>\n          <a class=\"nvp__pagination__link\" data-page={{page}} aria-current={{if (isCurrent page current) \"page\"}} href={{withQP \"page\" (asString page)}}>\n            {{page}}\n          </a>\n        </li>\n      {{/each}}\n\n      <Edge @rel=\"next\" @href={{withQP \"page\" (asString (after current))}} @label=\"Next\" @symbol=\"\u203A\" @symbolAfter={{true}} @disabled={{isLast current @totalPages}} />\n      <Edge @rel=\"last\" @href={{withQP \"page\" (asString @totalPages)}} @label=\"Last\" @symbol=\"\xBB\" @symbolAfter={{true}} @disabled={{isLast current @totalPages}} />\n    </ul>\n  {{/let}}\n</nav>", {
  strictMode: true,
  scope: () => ({
    pageOf,
    qp,
    Edge,
    withQP,
    isCurrent,
    asString,
    before,
    slotsOf,
    after,
    isLast
  })
}), templateOnly());

export { Pagination, pageSlots };
//# sourceMappingURL=pagination.js.map
