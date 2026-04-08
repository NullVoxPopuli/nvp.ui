import "./blur-reveal.css";

import { modifier } from "ember-modifier";

import type { TOC } from "@ember/component/template-only";

const splitCharsAndAnimate = modifier(
  (element: HTMLElement, _pos: unknown[], { speed, delay }: { speed?: number; delay?: number }) => {
    const text = (element.textContent ?? "").trim();
    const staggerMs = (0.03 / (speed ?? 1.5)) * 1000;
    const delayMs = (delay ?? 0) * 1000;

    element.textContent = "";

    const nodes: Node[] = [];

    for (let i = 0; i < text.length; i++) {
      const char = text[i] as string;

      if (char === " ") {
        const space = document.createElement("span");

        space.className = "nvp__blur-reveal__space";
        space.textContent = " ";
        element.appendChild(space);
        nodes.push(space);
      } else {
        const span = document.createElement("span");

        span.className = "nvp__blur-reveal__char";
        span.style.animationDelay = `${delayMs + i * staggerMs}ms`;
        span.textContent = char;
        element.appendChild(span);
        nodes.push(span);
      }
    }

    return () => {
      element.textContent = text;
    };
  },
);

export interface Signature {
  Element: HTMLParagraphElement;
  Args: {
    /**
     * Reveal speed multiplier (higher = faster)
     */
    speed?: number;
    /**
     * Delay before animation starts in seconds
     */
    delay?: number;
  };
  Blocks: {
    default: [];
  };
}

export const BlurReveal: TOC<Signature> = <template>
  <p class="nvp__blur-reveal" {{splitCharsAndAnimate speed=@speed delay=@delay}} ...attributes>
    {{yield}}
  </p>
</template>;
