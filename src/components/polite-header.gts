import "./polite-header.css";

import { modifier } from "ember-modifier";

import type { TOC } from "@ember/component/template-only";

function findScrollParent(el: HTMLElement): HTMLElement | Window {
  let node = el.parentElement;

  while (node && node !== document.documentElement) {
    const { overflowY } = getComputedStyle(node);

    if (overflowY === "auto" || overflowY === "scroll") {
      return node;
    }

    node = node.parentElement;
  }

  return window;
}

function getScrollY(target: HTMLElement | Window): number {
  return target instanceof Window ? target.scrollY : target.scrollTop;
}

function wireUp(element: HTMLElement) {
  const scrollTarget = findScrollParent(element);
  let lastScrollY = getScrollY(scrollTarget);
  let isHidden = false;

  scrollTarget.addEventListener(
    "scroll",
    () => {
      const currentScrollY = getScrollY(scrollTarget);

      if (currentScrollY <= 0) {
        if (isHidden) {
          element.style.transform = "";
          element.classList.remove("nvp__polite-header--hidden");
          isHidden = false;
        }
      } else if (currentScrollY > lastScrollY) {
        if (!isHidden) {
          element.style.transform = "translate3d(0, -100%, 0)";
          element.classList.add("nvp__polite-header--hidden");
          isHidden = true;
        }
      } else if (currentScrollY < lastScrollY) {
        if (isHidden) {
          element.style.transform = "";
          element.classList.remove("nvp__polite-header--hidden");
          isHidden = false;
        }
      }

      lastScrollY = currentScrollY;
    },
    { passive: true },
  );
}

/**
 * A modifier that makes any sticky/fixed element "polite" —
 * hides on scroll down, reveals on scroll up.
 */
export const politeHeader = modifier((element: HTMLElement) => {
  element.classList.add("nvp__polite-header");

  // Defer to next frame so ancestor styles (overflow-y) are resolved
  // and findScrollParent can locate the correct scroll container.
  requestAnimationFrame(() => {
    if (element.isConnected) {
      wireUp(element);
    }
  });
});

export interface PoliteHeaderSignature {
  Element: HTMLElement;
  Blocks: {
    default: [];
  };
}

/**
 * A component that renders a polite sticky header —
 * it hides when the user scrolls down and reveals when
 * the user scrolls up, staying out of the way while reading.
 *
 * @example
 * ```gts
 * import { PoliteHeader } from "nvp.ui/polite-header";
 *
 * <template>
 *   <PoliteHeader>
 *     My Header Content
 *   </PoliteHeader>
 * </template>
 * ```
 */
export const PoliteHeader: TOC<PoliteHeaderSignature> = <template>
  <header class="nvp__polite-header" {{politeHeader}} ...attributes>
    {{yield}}
  </header>
</template>;
