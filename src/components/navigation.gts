import "./variables.css";
import "./navigation.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  /**
   * The `<nav>` element.
   *
   * When there are multiple `<nav>` elements on a page,
   * pass an `aria-label` to distinguish them.
   */
  // there is no HTMLNavigationElement — <nav> is a plain HTMLElement
  Element: HTMLElement;
  Blocks: {
    /**
     * The navigation's content -- typically one or more
     * `<NavigationList>`s (with or without `@label`s).
     */
    default: [];
  };
}

/**
 * The navigation landmark: a `<nav>` that owns its own layout and
 * responsiveness, independent of what renders it.
 *
 * - **Sticky + scroll**: sticks `--navigation-top` (default `0px`)
 *   below the viewport top and scrolls its own overflow, so long
 *   navs never push the page around.
 * - **Responsive**: inside a size container (e.g. `<ApplicationShell>`),
 *   it keeps a comfortable `min-width` on wide containers and tightens
 *   its padding on narrow ones (like the shell's mobile tray).
 *
 * ### Contract with `<ApplicationShell>`
 *
 * The shell decides *where* navigation appears (the sidebar column on
 * wide viewports, the mobile tray + hamburger on narrow ones) and sets
 * `--navigation-top` to its sticky header's height. `<Navigation>`
 * owns everything about its own box: stickiness, overflow, padding,
 * and width. The shell does not style the nav's contents.
 *
 * @example
 * ```gts
 * import { Navigation, NavigationList } from "nvp.ui";
 *
 * <template>
 *   <Navigation aria-label="Documentation">
 *     <NavigationList @label="Get started">
 *       <li><a href="/intro" aria-current="page">Intro</a></li>
 *     </NavigationList>
 *   </Navigation>
 * </template>
 * ```
 */
export const Navigation: TOC<Signature> = <template>
  <nav class="nvp__navigation" ...attributes>
    {{yield}}
  </nav>
</template>;
