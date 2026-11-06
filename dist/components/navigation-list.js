import "./navigation-list.css"
import '../variables-goOgJf2v.js';
import '../focus-C7z7jBjO.js';
import { uniqueId } from '@ember/helper';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

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
const NavigationList = setComponentTemplate(precompileTemplate("{{#let (uniqueId) as |labelId|}}\n  {{#if @label}}\n    <span class=\"nvp__navigation-list__label\" id={{labelId}}>{{@label}}</span>\n  {{/if}}\n  <ul class=\"nvp__navigation-list\" aria-labelledby={{if @label labelId}} ...attributes>\n    {{yield}}\n  </ul>\n{{/let}}", {
  strictMode: true,
  scope: () => ({
    uniqueId
  })
}), templateOnly());

export { NavigationList };
//# sourceMappingURL=navigation-list.js.map
