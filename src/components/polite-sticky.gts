import "./polite-sticky.css";

import { modifier } from "ember-modifier";

function findScrollParent(el: HTMLElement): HTMLElement | Window {
  let node = el.parentElement;

  while (node && node !== document.documentElement) {
    // Check both computed style and inline style attribute.
    // In some rendering contexts (e.g. live code demos), computed
    // styles may not be resolved yet when the modifier runs.
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

const DURATION = 400;

function animateTransform(
  element: HTMLElement,
  from: number,
  to: number,
  footer: boolean,
): { cancel: () => void } {
  const start = performance.now();
  let rafId = 0;

  function tick(now: number) {
    const elapsed = now - start;
    const progress = Math.min(elapsed / DURATION, 1);
    // ease-out: 1 - (1 - t)^3
    const eased = 1 - Math.pow(1 - progress, 3);
    const current = from + (to - from) * eased;
    const axis = footer ? `0, ${current}%, 0` : `0, ${current}%, 0`;

    element.style.transform = current === 0 ? "" : `translate3d(${axis})`;

    if (progress < 1) {
      rafId = requestAnimationFrame(tick);
    }
  }

  rafId = requestAnimationFrame(tick);

  return {
    cancel: () => cancelAnimationFrame(rafId),
  };
}

function wireUp(element: HTMLElement) {
  const footer = detectFooter(element);
  const scrollTarget = findScrollParent(element);
  let lastScrollY = getScrollY(scrollTarget);
  let directionChangeY = lastScrollY;
  let isHidden = false;
  let wasScrollingDown = false;
  let currentAnimation: { cancel: () => void } | null = null;

  const threshold = 5;
  const hiddenClass = footer ? "nvp__polite__footer-hidden" : "nvp__polite__header-hidden";
  const hideTarget = footer ? 100 : -100;

  element.classList.add("nvp__polite", footer ? "nvp__polite__footer" : "nvp__polite__header");

  function show() {
    if (!isHidden) return;

    if (currentAnimation) currentAnimation.cancel();

    currentAnimation = animateTransform(element, hideTarget, 0, footer);
    element.classList.remove(hiddenClass);
    isHidden = false;
  }

  function hide() {
    if (isHidden) return;

    if (currentAnimation) currentAnimation.cancel();

    currentAnimation = animateTransform(element, 0, hideTarget, footer);
    element.classList.add(hiddenClass);
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

    if (currentAnimation) currentAnimation.cancel();

    element.style.transform = "";
    element.classList.remove("nvp__polite", hiddenClass);
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
