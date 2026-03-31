import "./timeline.css";

import type { TOC } from "@ember/component/template-only";

interface ItemSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Visual status of this timeline entry.
     *
     * - `complete` — green indicator
     * - `current`  — primary-color indicator with a pulse ring
     * - `incomplete` (default) — neutral indicator
     */
    status?: "complete" | "current" | "incomplete";
  };
  Blocks: {
    /**
     * The icon or symbol inside the indicator dot.
     * If omitted, a plain dot is rendered.
     */
    indicator: [];
    /**
     * Main content for this timeline entry.
     */
    content: [];
    /**
     * Optional expanded block (e.g. an inline comment card).
     * Placed below the content, aligned to the content column
     * via CSS subgrid.
     */
    block: [];
  };
}

const TimelineItem: TOC<ItemSignature> = <template>
  <div class="nvp__timeline__item" data-status={{@status}} ...attributes>
    <div class="nvp__timeline__indicator">
      <div class="nvp__timeline__dot" data-status={{@status}}>
        {{yield to="indicator"}}
      </div>
    </div>

    <div class="nvp__timeline__content">
      {{yield to="content"}}
    </div>

    {{#if (has-block "block")}}
      <div class="nvp__timeline__block">
        {{yield to="block"}}
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
 *     <Item @status="complete">
 *       <:indicator>✓</:indicator>
 *       <:content>
 *         <p><strong>alice</strong> merged the PR</p>
 *       </:content>
 *     </Item>
 *     <Item @status="current">
 *       <:indicator>→</:indicator>
 *       <:content>
 *         <p>Deploying to production…</p>
 *       </:content>
 *     </Item>
 *   </Timeline>
 * </template>
 * ```
 *
 * @example Horizontal stepper
 * ```gts
 * <Timeline @horizontal={{true}} as |Item|>
 *   <Item @status="complete">
 *     <:content>Confirmed</:content>
 *   </Item>
 *   <Item @status="current">
 *     <:content>On its way</:content>
 *   </Item>
 *   <Item>
 *     <:content>Delivered</:content>
 *   </Item>
 * </Timeline>
 * ```
 */
export const Timeline: TOC<TimelineSignature> = <template>
  <div class="nvp__timeline" data-horizontal={{if @horizontal "true"}} role="list" ...attributes>
    {{yield TimelineItem}}
  </div>
</template>;
