import "./polite-sticky.css";

import { modifier } from "ember-modifier";

function findScrollParent(el: HTMLElement): HTMLElement | Window {
  let node = el.parentElement;

  while (node && node !== document.documentElement) {
    const { overflowY } = getComputedStyle(node);

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

function getScrollY(target: HTMLElement | Window): number {
  return target instanceof Window ? target.scrollY : target.scrollTop;
}

function detectFooter(element: HTMLElement): boolean {
  return element.tagName.toLowerCase() === "footer";
}

function wireUp(element: HTMLElement) {
  const footer = detectFooter(element);
  const scrollTarget = findScrollParent(element);
  let lastScrollY = getScrollY(scrollTarget);
  let directionChangeY = lastScrollY;
  let isHidden = false;
  let wasScrollingDown = false;

  const threshold = 5;
  const hideTransform = footer ? "translate3d(0, 100%, 0)" : "translate3d(0, -100%, 0)";

  element.classList.add("nvp__polite", footer ? "nvp__polite__footer" : "nvp__polite__header");

  function show() {
    if (!isHidden) return;

    element.style.transform = "";
    isHidden = false;
  }

  function hide() {
    if (isHidden) return;

    element.style.transform = hideTransform;
    isHidden = true;
  }

  function onScroll() {
    const currentScrollY = getScrollY(scrollTarget);
    const scrollingDown = currentScrollY > lastScrollY;
    const scrollingUp = currentScrollY < lastScrollY;

    if (scrollingDown !== wasScrollingDown) {
      directionChangeY = lastScrollY;
      wasScrollingDown = scrollingDown;
    }

    const distance = Math.abs(currentScrollY - directionChangeY);

    lastScrollY = currentScrollY;

    if (footer) {
      if (scrollingDown && distance > threshold) show();
      if (scrollingUp && distance > threshold) hide();

      return;
    }

    if (currentScrollY <= 0) show();
    else if (scrollingDown && distance > threshold) hide();
    else if (scrollingUp && distance > threshold) show();
  }

  scrollTarget.addEventListener("scroll", onScroll, { passive: true });

  return () => {
    scrollTarget.removeEventListener("scroll", onScroll);
    element.style.transform = "";
    element.classList.remove("nvp__polite");
    element.classList.remove(footer ? "nvp__polite__footer" : "nvp__polite__header");
  };
}

/**
 * A modifier that makes a sticky header or footer "polite" —
 * it stays out of the way while reading content.
 *
 * On a `<header>` (or any non-footer element): hides on scroll down,
 * reveals on scroll up.
 *
 * On a `<footer>`: hides on scroll up, reveals on scroll down.
 *
 * The element type is detected automatically from the tag name.
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
export const politeSticky = modifier(wireUp);
