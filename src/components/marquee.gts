import "./marquee.css";

import { modifier } from "ember-modifier";

import type { TOC } from "@ember/component/template-only";

const or = (a: unknown, b: unknown) => a || b;

const duplicateContent = modifier((element: HTMLElement) => {
  const content = element.querySelector(".nvp__marquee__content");

  if (!content) return;

  const clone = content.cloneNode(true) as HTMLElement;

  clone.setAttribute("aria-hidden", "true");
  element.appendChild(clone);

  return () => {
    clone.remove();
  };
});

const durationStyle = (duration: string | undefined) => {
  if (!duration) return undefined;

  return `--marquee-duration: ${duration}`;
};

export interface Signature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Scroll direction
     */
    direction?: "left" | "right" | "up" | "down";
    /**
     * Animation duration as a CSS value (e.g. "20s", "30s")
     */
    duration?: string;
    /**
     * Pause scrolling on hover
     */
    pauseOnHover?: boolean;
    /**
     * Fade content at the edges
     */
    fade?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export const Marquee: TOC<Signature> = <template>
  {{! template-lint-disable no-inline-styles }}
  <div
    class="nvp__marquee"
    data-direction={{or @direction "left"}}
    {{! only set these attributes when truthy }}
    data-pause-on-hover={{if @pauseOnHover "true"}}
    data-fade={{if @fade "true"}}
    style={{durationStyle @duration}}
    ...attributes
  >
    <div class="nvp__marquee__track" {{duplicateContent}}>
      <div class="nvp__marquee__content">
        {{yield}}
      </div>
    </div>
  </div>
</template>;
