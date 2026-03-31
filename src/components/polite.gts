import "./polite.css";

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

function detectFooter(element: HTMLElement): boolean {
  return element.tagName.toLowerCase() === "footer" || element.hasAttribute("data-polite-footer");
}

function wireUp(element: HTMLElement) {
  const footer = detectFooter(element);
  const scrollTarget = findScrollParent(element);
  let lastScrollY = getScrollY(scrollTarget);
  let isHidden = false;

  const hiddenClass = footer ? "nvp__polite--footer-hidden" : "nvp__polite--header-hidden";
  const hideTransform = footer ? "translate3d(0, 100%, 0)" : "translate3d(0, -100%, 0)";

  element.classList.add("nvp__polite", footer ? "nvp__polite--footer" : "nvp__polite--header");

  function show() {
    if (!isHidden) return;

    element.style.transform = "";
    element.classList.remove(hiddenClass);
    isHidden = false;
  }

  function hide() {
    if (isHidden) return;

    element.style.transform = hideTransform;
    element.classList.add(hiddenClass);
    isHidden = true;
  }

  scrollTarget.addEventListener(
    "scroll",
    () => {
      const currentScrollY = getScrollY(scrollTarget);
      const scrollingDown = currentScrollY > lastScrollY;
      const scrollingUp = currentScrollY < lastScrollY;

      lastScrollY = currentScrollY;

      if (footer) {
        if (scrollingDown) show();
        if (scrollingUp) hide();

        return;
      }

      if (currentScrollY <= 0) show();
      else if (scrollingDown) hide();
      else if (scrollingUp) show();
    },
    { passive: true },
  );
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
 * import { polite } from "nvp.ui/polite";
 * import { Header } from "nvp.ui/header";
 *
 * <template>
 *   <Header {{polite}}>
 *     <:left>My App</:left>
 *   </Header>
 *
 *   <footer {{polite}}>
 *     Footer content
 *   </footer>
 * </template>
 * ```
 */
export const polite = modifier((element: HTMLElement) => {
  wireUp(element);
});

// Custom element for docs demos where ember-modifier
// can't be used in Kolay's live code blocks.
class PoliteElement extends HTMLElement {
  connectedCallback() {
    requestAnimationFrame(() => {
      if (this.isConnected) {
        wireUp(this);
      }
    });
  }
}

if (typeof customElements !== "undefined" && !customElements.get("nvp-polite")) {
  customElements.define("nvp-polite", PoliteElement);
}

export interface PoliteHeaderSignature {
  Element: HTMLElement;
  Blocks: {
    default: [];
  };
}

/**
 * A polite header component for use in docs demos.
 * Prefer using the `polite` modifier directly with `<Header {{polite}}>`.
 */
export const PoliteHeader: TOC<PoliteHeaderSignature> = <template>
  {{! @glint-ignore: custom element }}
  <nvp-polite class="nvp__polite" ...attributes>
    {{yield}}
  </nvp-polite>
</template>;

export interface PoliteFooterSignature {
  Element: HTMLElement;
  Blocks: {
    default: [];
  };
}

/**
 * A polite footer component for use in docs demos.
 * Prefer using the `polite` modifier directly with `<footer {{polite}}>`.
 */
export const PoliteFooter: TOC<PoliteFooterSignature> = <template>
  {{! @glint-ignore: custom element }}
  <nvp-polite data-polite-footer class="nvp__polite" ...attributes>
    {{yield}}
  </nvp-polite>
</template>;
