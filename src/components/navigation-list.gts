import "./variables.css";
import "./focus.css";
import "./navigation-list.css";

import { hash, uniqueId } from "@ember/helper";

import type { TOC } from "@ember/component/template-only";

export interface SectionSignature {
  /**
   * The `<ul>` for one group of links.
   *
   * Its children are plain `<li>` elements that you render yourself --
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

const Section: TOC<SectionSignature> = <template>
  {{#let (uniqueId) as |labelId|}}
    {{#if @label}}
      <span class="nvp__navigation-list__label" id={{labelId}}>{{@label}}</span>
    {{/if}}
    <ul class="nvp__navigation-list__section" aria-labelledby={{if @label labelId}} ...attributes>
      {{yield}}
    </ul>
  {{/let}}
</template>;

export interface Signature {
  /**
   * The `<nav>` element.
   *
   * When there are multiple `<nav>` elements on a page,
   * pass an `aria-label` to distinguish them.
   */
  Element: HTMLElement;
  Blocks: {
    /**
     * Yields `Section` for composing groups of links.
     */
    default: [list: { Section: TOC<SectionSignature> }];
  };
}

/**
 * A styled navigation list (sidebars, docs navs, …): spaced groups
 * with uppercase section labels, and "chip" hover / current-page
 * styling for the links.
 *
 * Bring your own links -- plain `<a>`, `<LinkTo>`, ember-primitives
 * links all work. The current page is highlighted via `[aria-current]`
 * (or an `active` class, for routers that set one).
 *
 * @example
 * ```gts
 * import { NavigationList } from "nvp.ui/navigation-list";
 *
 * <template>
 *   <NavigationList aria-label="Documentation" as |l|>
 *     <l.Section @label="Get started">
 *       <li><a href="/intro" aria-current="page">Intro</a></li>
 *       <li><a href="/install">Installation</a></li>
 *     </l.Section>
 *   </NavigationList>
 * </template>
 * ```
 */
export const NavigationList: TOC<Signature> = <template>
  <nav class="nvp__navigation-list" ...attributes>
    {{yield (hash Section=Section)}}
  </nav>
</template>;
