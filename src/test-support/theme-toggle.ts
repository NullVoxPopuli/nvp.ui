import { assert } from "@ember/debug";
import { click, find } from "@ember/test-helpers";

const selectors = {
  root: "preem__site-theme-toggle",
  checkbox: '[name="color-scheme"]',
};

/**
 * Test utility for interacting with the
 * ThemeToggle component.
 *
 * Simulates user behavior and provides high level functions so you don't need to worry about the DOM.
 *
 * Actual elements are not exposed, as the elements are private API.
 */
export function themeToggle(selector?: string) {
  const root = `${selector ?? ""}${selectors.root}`;

  return new ThemeToggle(root);
}

export class ThemeToggle {
  #root: string;

  constructor(root: string) {
    this.#root = root;
  }

  get #rootElement() {
    const element = find(this.#root);

    assert(
      `Could not find the root element for the <ThemeToggle> component. Used the selector \`${this.#root}\`. Was it rendered?`,
      element,
    );

    return element;
  }

  get #checkbox() {
    const selector = this.#root + " " + selectors.checkbox;
    const element = find(selector);

    assert(
      `Could not find the checkbox element for the <ThemeToggle> component. Used the selector \`${this.#root}\`. Was it rendered?`,
      element,
    );

    return element;
  }

  async light() {
    if (this.isLight) return;

    await this.toggle();
  }
  async dark() {
    if (this.isDark) return;

    await this.toggle();
  }

  get current() {
    const isDark = !!this.#checkbox.getAttribute("checked");

    return isDark ? "dark" : "light";
  }

  get isDark() {
    return this.current === "dark";
  }

  get isLight() {
    return this.current === "light";
  }

  async toggle() {
    await click(this.#rootElement);
  }
}
