import "./polite-sticky.css"
import { modifier } from 'ember-modifier';

;

function findScrollParent(el) {
  let node = el.parentElement;
  while (node && node !== document.documentElement) {
    const {
      overflowY
    } = getComputedStyle(node);
    if (overflowY === "auto" || overflowY === "scroll") {
      return node;
    }
    const inlineOverflow = node.style.overflowY || node.style.overflow;
    if (inlineOverflow === "auto" || inlineOverflow === "scroll") {
      return node;
    }
    node = node.parentElement;
  }
  return window;
}
function getScrollY(target) {
  return target instanceof Window ? target.scrollY : target.scrollTop;
}
function detectFooter(element) {
  return element.tagName.toLowerCase() === "footer";
}
function clamp(value, min, max) {
  return Math.min(Math.max(value, min), max);
}
function wireUp(element) {
  const footer = detectFooter(element);
  const scrollTarget = findScrollParent(element);
  let lastScrollY = getScrollY(scrollTarget);
  let offset = 0;
  element.classList.add("nvp__polite", footer ? "nvp__polite__footer" : "nvp__polite__header");
  function onScroll() {
    const currentScrollY = getScrollY(scrollTarget);
    const delta = currentScrollY - lastScrollY;
    const height = element.offsetHeight;
    lastScrollY = currentScrollY;
    if (footer) {
      // Footer: scrolling up pushes it down (positive offset), scrolling down pulls it back
      offset = clamp(offset - delta, 0, height);
    } else {
      // Header: scrolling down pushes it up (negative offset), scrolling up pulls it back
      // At scroll top, always fully visible
      if (currentScrollY <= 0) {
        offset = 0;
      } else {
        offset = clamp(offset - delta, -height, 0);
      }
    }
    element.style.setProperty("--polite-offset", `${offset}px`);
  }
  scrollTarget.addEventListener("scroll", onScroll, {
    passive: true
  });
  return () => {
    scrollTarget.removeEventListener("scroll", onScroll);
    element.style.removeProperty("--polite-offset");
    element.classList.remove("nvp__polite");
    element.classList.remove(footer ? "nvp__polite__footer" : "nvp__polite__header");
  };
}
/**
 * A modifier that makes a sticky header or footer "polite" —
 * it stays out of the way while reading content.
 *
 * On a `<header>` (or any non-footer element): slides up as the
 * user scrolls down, slides back as they scroll up.
 *
 * On a `<footer>`: slides down as the user scrolls up, slides
 * back as they scroll down.
 *
 * The element type is detected automatically from the tag name.
 * The animation is scroll-linked — the element tracks the scroll
 * position 1:1 via a CSS custom property `--polite-offset`.
 *
 * @example
 * ```gts
 * import { politeSticky } from "nvp.ui/polite-sticky";
 *
 * <template>
 *   <header {{politeSticky}}>
 *     My App
 *   </header>
 *
 *   <footer {{politeSticky}}>
 *     Footer content
 *   </footer>
 * </template>
 * ```
 */
const politeSticky = modifier(wireUp);

export { politeSticky };
//# sourceMappingURL=polite-sticky.js.map
