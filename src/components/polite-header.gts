import "./polite-header.css";

import { modifier } from "ember-modifier";

/**
 * A modifier that makes a sticky/fixed header "polite" —
 * it hides when the user scrolls down and reveals when
 * the user scrolls up, staying out of the way while reading.
 *
 * The header is always visible at the top of the page.
 *
 * @example
 * ```gts
 * import { politeHeader } from "nvp.ui/polite-header";
 *
 * <template>
 *   <header {{politeHeader}}>
 *     My Header
 *   </header>
 * </template>
 * ```
 */
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

export const politeHeader = modifier((element: HTMLElement) => {
  const scrollTarget = findScrollParent(element);
  let lastScrollY = getScrollY(scrollTarget);
  let isHidden = false;

  element.classList.add("preem__polite-header");

  function update() {
    const currentScrollY = getScrollY(scrollTarget);

    if (currentScrollY <= 0) {
      // At the top — always show
      if (isHidden) {
        element.classList.remove("preem__polite-header--hidden");
        isHidden = false;
      }
    } else if (currentScrollY > lastScrollY) {
      // Scrolling down — hide
      if (!isHidden) {
        element.classList.add("preem__polite-header--hidden");
        isHidden = true;
      }
    } else {
      // Scrolling up — show
      if (isHidden) {
        element.classList.remove("preem__polite-header--hidden");
        isHidden = false;
      }
    }

    lastScrollY = currentScrollY;
  }

  scrollTarget.addEventListener("scroll", update, { passive: true });

  return () => {
    scrollTarget.removeEventListener("scroll", update);
    element.classList.remove("preem__polite-header", "preem__polite-header--hidden");
  };
});
