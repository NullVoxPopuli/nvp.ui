import "./variables.css";
import "./focus.css";
import "./navigation-list.css";

import { uniqueId } from "@ember/helper";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  /**
   * The `<ul>` -- the component *is* the list.
   *
   * Its children are plain `<li>` elements that you render yourself:
   * the stylesheet targets the direct-descendant `li`s and the links
   * inside them. Any link element works: a plain `<a>`, `<LinkTo>`,
   * an ember-primitives link, etc. The current page is highlighted
   * when its link has an `aria-current` attribute (or an `active`
   * class, for routers that set one).
   */
  Element: HTMLUListElement;
  Args: {
    /**
     * Optional group heading, rendered in an uppercase "section label"
     * treatment above the list.
     *
     * The label is programmatically associated with the list via
     * `aria-labelledby`, so screen readers announce the list by name.
     * It is styled text, not a heading, so it never affects the page's
     * heading outline.
     *
     * Omit for a plain (unlabelled) list of links.
     */
    label?: string;
  };
  Blocks: {
    /**
     * One or more `<li>`s, each containing a link.
     */
    default: [];
  };
}

/**
 * A navigation list is nothing more than a (optionally labelled) `<ul>`:
 * spaced link "chips" with hover / current-page styling, and an
 * uppercase group label when `@label` is passed.
 *
 * There is no wrapper element -- the label `<span>` (when present) and
 * the `<ul>` are rendered as siblings. Consecutive `<NavigationList>`s
 * space themselves apart, so several labelled lists stack into a
 * grouped nav. Wrap them in `<Navigation>` (or your own `<nav>`) to
 * form a navigation landmark.
 *
 * @example
 * ```gts
 * import { NavigationList } from "nvp.ui/navigation-list";
 *
 * <template>
 *   <NavigationList @label="Get started">
 *     <li><a href="/intro" aria-current="page">Intro</a></li>
 *     <li><a href="/install">Installation</a></li>
 *   </NavigationList>
 * </template>
 * ```
 */
export const NavigationList: TOC<Signature> = <template>
  {{#let (uniqueId) as |labelId|}}
    {{#if @label}}
      <span class="nvp__navigation-list__label" id={{labelId}}>{{@label}}</span>
    {{/if}}
    <ul class="nvp__navigation-list" aria-labelledby={{if @label labelId}} ...attributes>
      {{yield}}
    </ul>
  {{/let}}
</template>;
