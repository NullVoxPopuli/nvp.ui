import "./timeline.css"
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

const or = (a, b) => a || b;
const isString = x => typeof x === "string";
/**
 * Two usage modes:
 *
 * **Compact:** `@indicator` arg + default block for content.
 *
 * **Named blocks:** `<:indicator>`, `<:summary>`, and `<:content>` for full control.
 */

const TimelineItem = setComponentTemplate(precompileTemplate("<div class=\"nvp__timeline__item\" role=\"listitem\" data-status={{@status}} ...attributes>\n  <div class=\"nvp__timeline__indicator\">\n    <div class=\"nvp__timeline__dot\" data-status={{@status}}>\n      {{#if (or (has-block \"indicator\") @indicator)}}\n        {{#if (isString @indicator)}}\n          {{@indicator}}\n        {{else if @indicator}}\n          <@indicator />\n        {{/if}}\n        {{yield to=\"indicator\"}}\n      {{/if}}\n    </div>\n  </div>\n\n  <div class=\"nvp__timeline__summary\">\n    {{yield to=\"summary\"}}\n    {{yield}}\n  </div>\n\n  {{#if (has-block \"content\")}}\n    <div class=\"nvp__timeline__content\">\n      {{yield to=\"content\"}}\n    </div>\n  {{/if}}\n</div>", {
  strictMode: true,
  scope: () => ({
    or,
    isString
  })
}), templateOnly());
/**
 * A timeline component built on CSS grid + subgrid.
 *
 * Supports vertical (default) and horizontal orientations,
 * status indicators, and inline block content.
 *
 * @example Vertical activity feed
 * ```gts
 * import { Timeline } from "nvp.ui/timeline";
 *
 * <template>
 *   <Timeline as |Item|>
 *     <Item @status="complete" @indicator="✓">
 *       <strong>alice</strong> merged the PR
 *     </Item>
 *     <Item @status="current" @indicator="→">
 *       Deploying to production…
 *     </Item>
 *   </Timeline>
 * </template>
 * ```
 *
 * @example Horizontal stepper
 * ```gts
 * <Timeline @horizontal={{true}} as |Item|>
 *   <Item @status="complete" @indicator="💳">Confirmed</Item>
 *   <Item @status="current" @indicator="🚚">On its way</Item>
 *   <Item @indicator="🏠">Delivered</Item>
 * </Timeline>
 * ```
 */
const Timeline = setComponentTemplate(precompileTemplate("<div class=\"nvp__timeline\" data-horizontal={{if @horizontal \"true\"}} role=\"list\" ...attributes>\n  {{yield TimelineItem}}\n</div>", {
  strictMode: true,
  scope: () => ({
    TimelineItem
  })
}), templateOnly());

export { Timeline };
//# sourceMappingURL=timeline.js.map
