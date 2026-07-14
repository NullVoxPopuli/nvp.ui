import "./variables.css";
import "./focus.css";
import "./navigation-list.css";

import { hash } from "@ember/helper";

import type { TOC } from "@ember/component/template-only";

export interface ItemSignature {
  /**
   * The `<li>` wrapper for a single navigation entry.
   *
   * Render any link element inside — a plain `<a>`, `<LinkTo>`,
   * an ember-primitives link, etc. The link is styled via CSS,
   * and the current page is highlighted when the link has an
   * `aria-current` attribute or an `active` class.
   */
  Element: HTMLLIElement;
  Blocks: {
    /**
     * The link (or other content) for this entry.
     */
    default: [];
  };
}

const Item: TOC<ItemSignature> = <template>
  <li class="nvp__navigation-list__item" ...attributes>
    {{yield}}
  </li>
</template>;

export interface SectionSignature {
  /**
   * The wrapper around one group of links.
   */
  Element: HTMLDivElement;
  Args: {
    /**
     * Optional group heading, rendered in an uppercase
     * "section label" treatment above the links.
     *
     * Omit for a plain (unlabelled) list of links.
     */
    label?: string;
  };
  Blocks: {
    /**
     * One or more `<Item>`s.
     */
    default: [section: { Item: TOC<ItemSignature> }];
  };
}

const Section: TOC<SectionSignature> = <template>
  <div class="nvp__navigation-list__section" ...attributes>
    {{#if @label}}
      <p class="nvp__navigation-list__label">{{@label}}</p>
    {{/if}}
    <ul>
      {{yield (hash Item=Item)}}
    </ul>
  </div>
</template>;

/**
 * Two usage modes:
 *
 * **Composed:** the default block yields `Section` (which yields `Item`) —
 * the component renders the `<nav>` for you.
 *
 * **Bring your own nav:** the `<:nav>` block renders a plain styling
 * container instead, for content that already renders its own `<nav>`
 * (e.g. kolay's `PageNav`, or a hand-written `<nav><ul>…`).
 */
export type Signature =
  | {
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
        nav: never;
      };
    }
  | {
      /**
       * The styling container (a `<div>`) around your own `<nav>`.
       */
      Element: HTMLDivElement;
      Blocks: {
        /**
         * Content that renders its own `<nav>` + `<ul>` structure.
         *
         * Nested lists are styled like sections: text (or a link)
         * directly inside a top-level `<li>` gets the section-label
         * treatment, and links get the same hover / current styling
         * as composed `Item`s.
         */
        nav: [];
        default: never;
      };
    };

/**
 * A styled container for navigation lists (sidebars, docs navs, …):
 * plain lists, spaced groups with uppercase section labels, and
 * "chip" hover / current-page styling for the links.
 *
 * Bring your own links — plain `<a>`, `<LinkTo>`, ember-primitives
 * links, and generated navs all work. The current page is highlighted
 * via `[aria-current]` (or an `active` class, for routers that set one).
 *
 * @example Composed
 * ```gts
 * import { NavigationList } from "nvp.ui/navigation-list";
 *
 * <template>
 *   <NavigationList aria-label="Documentation" as |l|>
 *     <l.Section @label="Get started" as |s|>
 *       <s.Item><a href="/intro" aria-current="page">Intro</a></s.Item>
 *       <s.Item><a href="/install">Installation</a></s.Item>
 *     </l.Section>
 *   </NavigationList>
 * </template>
 * ```
 *
 * @example Bring your own nav
 * ```gts
 * <NavigationList>
 *   <:nav>
 *     <PageNav aria-label="Documentation" />
 *   </:nav>
 * </NavigationList>
 * ```
 */
export const NavigationList: TOC<Signature> = <template>
  {{#if (has-block "nav")}}
    <div class="nvp__navigation-list" ...attributes>
      {{yield to="nav"}}
    </div>
  {{else}}
    <nav class="nvp__navigation-list" ...attributes>
      {{yield (hash Section=Section)}}
    </nav>
  {{/if}}
</template>;
