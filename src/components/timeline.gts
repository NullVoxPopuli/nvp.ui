import "./timeline.css";

import { modifier } from "ember-modifier";

import type { TOC } from "@ember/component/template-only";
import type { ComponentLike, WithBoundArgs } from "@glint/template";

const isString = (x: unknown): x is string => typeof x === "string";

/**
 * A single shared IntersectionObserver that marks each item with `data-visible`
 * the first time it enters the viewport, then stops watching it.
 * Using one observer for all items is more efficient than creating one per item.
 */
let sharedObserver: IntersectionObserver | undefined;

function getObserver(): IntersectionObserver {
  if (!sharedObserver) {
    sharedObserver = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (entry.isIntersecting) {
            entry.target.setAttribute("data-visible", "");
            sharedObserver?.unobserve(entry.target);
          }
        }
      },
      { threshold: 0.1 },
    );
  }

  return sharedObserver;
}

/**
 * Observes when an element scrolls into the viewport and marks it with
 * `data-visible` so CSS animations can trigger. Uses a shared observer
 * instance across all timeline items for efficiency.
 */
const inView = modifier((element: Element) => {
  const observer = getObserver();

  observer.observe(element);

  return () => observer.unobserve(element);
});

export interface TimelineItemSignature {
  Element: HTMLLIElement;
  Args: {
    /**
     * An optional label shown above the content (e.g. a date or category).
     * Can be a string or a component.
     */
    label?: string | ComponentLike;

    /**
     * An optional title shown for the timeline item.
     * Can be a string or a component.
     */
    title?: string | ComponentLike;

    /**
     * An optional custom icon or marker to display instead of the default dot.
     * Should be a component.
     */
    icon?: ComponentLike;
  };
  Blocks: {
    /**
     * The main content of the timeline item
     */
    default: [];
  };
}

export const TimelineItem: TOC<TimelineItemSignature> = <template>
  <li class="nvp__timeline__item" {{inView}} ...attributes>
    <div class="nvp__timeline__marker">
      {{#if @icon}}
        <@icon />
      {{else}}
        <div class="nvp__timeline__dot"></div>
      {{/if}}
    </div>

    <div class="nvp__timeline__content">
      {{#if @label}}
        <span class="nvp__timeline__label">
          {{#if (isString @label)}}
            {{@label}}
          {{else}}
            <@label />
          {{/if}}
        </span>
      {{/if}}

      {{#if @title}}
        <p class="nvp__timeline__title">
          {{#if (isString @title)}}
            {{@title}}
          {{else}}
            <@title />
          {{/if}}
        </p>
      {{/if}}

      {{#if (has-block)}}
        <div class="nvp__timeline__body">
          {{yield}}
        </div>
      {{/if}}
    </div>
  </li>
</template>;

export interface TimelineSignature {
  Element: HTMLOListElement;
  Blocks: {
    /**
     * Yields the `TimelineItem` component pre-bound to this timeline
     */
    default: [WithBoundArgs<typeof TimelineItem, never>];
  };
}

export const Timeline: TOC<TimelineSignature> = <template>
  <ol class="nvp__timeline" ...attributes>
    {{yield TimelineItem}}
  </ol>
</template>;
