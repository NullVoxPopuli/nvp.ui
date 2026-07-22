import "./navigation.css"
import '../variables-goOgJf2v.js';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

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
const Navigation = setComponentTemplate(precompileTemplate("<nav class=\"nvp__navigation\" ...attributes>\n  {{yield}}\n</nav>", {
  strictMode: true
}), templateOnly());

export { Navigation };
//# sourceMappingURL=navigation.js.map
