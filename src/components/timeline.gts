import "./timeline.css";

import type { TOC } from "@ember/component/template-only";
import type { ComponentLike } from "@glint/template";

const or = (a: unknown, b: unknown) => a || b;
const isString = (x: unknown) => typeof x === "string";

/**
 * Two usage modes:
 *
 * **Compact:** `@indicator` arg + default block for content.
 *
 * **Named blocks:** `<:indicator>`, `<:summary>`, and `<:content>` for full control.
 */
export type ItemSignature =
  | {
      Element: HTMLDivElement;
      Args: {
        /**
         * Controls the **color** of the indicator dot.
         *
         * - `complete` — green dot
         * - `current`  — primary-color dot with a pulse ring
         * - `incomplete` (default) — neutral dot
         */
        status?: "complete" | "current" | "incomplete";

        /**
         * Icon or symbol rendered **inside** the indicator dot.
         *
         * Accepts a string (e.g. an emoji) or a component.
         */
        indicator: string | ComponentLike;
      };
      Blocks: {
        /**
         * Main content for this timeline entry.
         */
        default: [];
        indicator: never;
        summary: never;
        content: never;
      };
    }
  | {
      Element: HTMLDivElement;
      Args: {
        /**
         * Controls the **color** of the indicator dot.
         *
         * - `complete` — green dot
         * - `current`  — primary-color dot with a pulse ring
         * - `incomplete` (default) — neutral dot
         */
        status?: "complete" | "current" | "incomplete";

        indicator?: undefined;
      };
      Blocks: {
        /**
         * Custom icon or symbol rendered **inside** the indicator dot.
         *
         * If omitted, a smaller plain dot is rendered instead.
         */
        indicator: [];
        /**
         * Brief headline for this timeline entry.
         */
        summary: [];
        /**
         * Optional expanded content (e.g. an inline comment card).
         * Placed below the summary, aligned to the content column
         * via CSS subgrid.
         */
        content: [];
        default: never;
      };
    };

const TimelineItem: TOC<ItemSignature> = <template>
  <div class="nvp__timeline__item" role="listitem" data-status={{@status}} ...attributes>
    <div class="nvp__timeline__indicator">
      <div class="nvp__timeline__dot" data-status={{@status}}>
        {{#if (or (has-block "indicator") @indicator)}}
          {{#if (isString @indicator)}}
            {{@indicator}}
          {{else if @indicator}}
            <@indicator />
          {{/if}}
          {{yield to="indicator"}}
        {{/if}}
      </div>
    </div>

    <div class="nvp__timeline__summary">
      {{yield to="summary"}}
      {{yield}}
    </div>

    {{#if (has-block "content")}}
      <div class="nvp__timeline__content">
        {{yield to="content"}}
      </div>
    {{/if}}
  </div>
</template>;

export interface TimelineSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Lay items out left-to-right instead of top-to-bottom.
     */
    horizontal?: boolean;
  };
  Blocks: {
    default: [typeof TimelineItem];
  };
}

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
export const Timeline: TOC<TimelineSignature> = <template>
  <div class="nvp__timeline" data-horizontal={{if @horizontal "true"}} role="list" ...attributes>
    {{yield TimelineItem}}
  </div>
</template>;
