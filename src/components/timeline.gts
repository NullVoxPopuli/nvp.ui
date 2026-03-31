import "./timeline.css";

import type { TOC } from "@ember/component/template-only";

export interface ItemSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Controls the **color** of the indicator dot.
     *
     * This is independent of the `<:indicator>` block, which controls
     * the **content** (icon/text) rendered inside the dot.
     *
     * - `complete` — green dot
     * - `current`  — primary-color dot with a pulse ring
     * - `incomplete` (default) — neutral dot
     */
    status?: "complete" | "current" | "incomplete";
  };
  Blocks: {
    /**
     * Custom icon or symbol rendered **inside** the indicator dot.
     *
     * If omitted, a smaller plain dot is rendered instead.
     * This is independent of `@status`, which controls the dot's **color**.
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
  <div class="nvp__timeline__item" role="listitem" data-status={{@status}} ...attributes>
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
