import "./slide-up-text.css";

import { modifier } from "ember-modifier";

import type { TOC } from "@ember/component/template-only";

const splitAndAnimate = modifier(
  (
    element: HTMLElement,
    _pos: unknown[],
    { stagger, delay }: { stagger?: number; delay?: number },
  ) => {
    const text = element.textContent ?? "";
    const words = text.split(/\s+/).filter(Boolean);
    const staggerMs = (stagger ?? 0.08) * 1000;
    const delayMs = (delay ?? 0) * 1000;

    element.textContent = "";

    const spans: HTMLSpanElement[] = [];

    words.forEach((word, i) => {
      if (i > 0) {
        element.appendChild(document.createTextNode(" "));
      }

      const span = document.createElement("span");

      span.className = "nvp__slide-up-text__word";
      span.style.animationDelay = `${delayMs + i * staggerMs}ms`;
      span.textContent = word;
      element.appendChild(span);
      spans.push(span);
    });

    return () => {
      element.textContent = text;
    };
  },
);

export interface Signature {
  Element: HTMLParagraphElement;
  Args: {
    /**
     * Delay between each word animation in seconds
     */
    stagger?: number;
    /**
     * Initial delay before animation starts in seconds
     */
    delay?: number;
  };
  Blocks: {
    default: [];
  };
}

export const SlideUpText: TOC<Signature> = <template>
  <p
    class="nvp__slide-up-text"
    {{splitAndAnimate stagger=@stagger delay=@delay}}
    ...attributes
  >
    {{yield}}
  </p>
</template>;
