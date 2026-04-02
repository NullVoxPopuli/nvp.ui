import "./browser-window.css";

import type { TOC } from "@ember/component/template-only";

export interface BrowserWindowSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * URL displayed in the address bar.
     * If omitted, no URL bar is shown.
     */
    url?: string;

    /**
     * Which browser chrome style to render.
     *
     * - `"mac"` (default) — macOS traffic-light circles
     * - `"windows"` — Windows-style minimize / maximize / close icons (right-aligned)
     * - `"ubuntu"` — Ubuntu/GNOME-style with rounded close / minimize / maximize buttons
     * - `"generic"` — Plain bar with no window controls
     */
    os?: "mac" | "windows" | "ubuntu" | "generic";

    /**
     * Tab labels to display in a tab bar.
     * The first tab is rendered as active.
     */
    tabs?: string[];

    /**
     * Which tab visual style to use.
     *
     * - `"safari"` — rounded pill tabs (default when `@os` is `"mac"`)
     * - `"chrome"` — Material-style rounded rectangle tabs
     * - `"firefox"` — Proton-style rounded rectangle tabs
     *
     * Defaults to `"safari"` when `@os` is `"mac"`, `"firefox"` otherwise.
     */
    tabStyle?: "safari" | "chrome" | "firefox";

    /**
     * Remove padding from the content area and let content
     * (images, iframes) fill edge-to-edge.
     */
    flush?: boolean;

    /**
     * Add a layered drop shadow to the window.
     */
    shadow?: boolean;

    /**
     * Render the traffic-light circles in grayscale (macOS style only).
     */
    grayscale?: boolean;
  };
  Blocks: {
    /**
     * The content rendered inside the browser window body.
     */
    default: [];
  };
}

/**
 * A browser window mockup for demos and documentation.
 *
 * Inspired by [zachleat/browser-window](https://github.com/zachleat/browser-window).
 *
 * @example Basic usage (macOS style)
 * ```gts
 * import { BrowserWindow } from "nvp.ui/browser-window";
 *
 * <template>
 *   <BrowserWindow @url="https://example.com">
 *     <p>Hello world!</p>
 *   </BrowserWindow>
 * </template>
 * ```
 *
 * @example With tabs
 * ```gts
 * import { BrowserWindow } from "nvp.ui/browser-window";
 *
 * <template>
 *   <BrowserWindow
 *     @url="https://example.com"
 *     @tabs={{(Array "Home" "About" "Contact")}}
 *   >
 *     <p>Hello world!</p>
 *   </BrowserWindow>
 * </template>
 * ```
 */
export const BrowserWindow: TOC<BrowserWindowSignature> = <template>
  <div
    class="nvp__browser-window"
    data-os={{if @os @os "mac"}}
    data-tab-style={{if @tabs (resolveTabStyle @tabStyle @os)}}
    data-flush={{if @flush "true"}}
    data-shadow={{if @shadow "true"}}
    data-grayscale={{if @grayscale "true"}}
    ...attributes
  >
    <div class="nvp__browser-window__header">
      {{#if (isWindows @os)}}
        {{#if @tabs}}
          <div class="nvp__browser-window__tabs" role="tablist">
            {{#each @tabs as |tab index|}}
              <div
                class="nvp__browser-window__tab"
                data-active={{if (isFirst index) "true"}}
                role="tab"
              >{{tab}}
                <svg class="nvp__browser-window__tab-close" viewBox="0 0 16 16" aria-hidden="true"><path
                    d="M4.5 4.5l7 7M11.5 4.5l-7 7"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                  /></svg>
              </div>
            {{/each}}
          </div>
          {{! new tab button }}
          <svg class="nvp__browser-window__new-tab" viewBox="0 0 16 16" aria-hidden="true"><path
              d="M8 3v10M3 8h10"
              stroke="currentColor"
              stroke-width="1.3"
              stroke-linecap="round"
            /></svg>
        {{else}}
          {{#if @url}}
            <div class="nvp__browser-window__url">{{@url}}</div>
          {{/if}}
        {{/if}}
        <div class="nvp__browser-window__controls">
          {{! minimize }}
          <svg viewBox="0 0 12 12" aria-hidden="true"><rect
              y="5.5"
              width="12"
              height="1"
              fill="currentColor"
            /></svg>
          {{! maximize }}
          <svg viewBox="0 0 12 12" aria-hidden="true"><rect
              x="1"
              y="1"
              width="10"
              height="10"
              stroke="currentColor"
              stroke-width="1"
              fill="none"
            /></svg>
          {{! close }}
          <svg viewBox="0 0 12 12" aria-hidden="true"><path
              d="M1 1l10 10M11 1L1 11"
              stroke="currentColor"
              stroke-width="1.2"
            /></svg>
        </div>
      {{else if (isUbuntu @os)}}
        {{#if @tabs}}
          <div class="nvp__browser-window__tabs" role="tablist">
            {{#each @tabs as |tab index|}}
              <div
                class="nvp__browser-window__tab"
                data-active={{if (isFirst index) "true"}}
                role="tab"
              >{{tab}}
                <svg class="nvp__browser-window__tab-close" viewBox="0 0 16 16" aria-hidden="true"><path
                    d="M4.5 4.5l7 7M11.5 4.5l-7 7"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                  /></svg>
              </div>
            {{/each}}
          </div>
          {{! new tab button }}
          <svg class="nvp__browser-window__new-tab" viewBox="0 0 16 16" aria-hidden="true"><path
              d="M8 3v10M3 8h10"
              stroke="currentColor"
              stroke-width="1.3"
              stroke-linecap="round"
            /></svg>
        {{else}}
          {{#if @url}}
            <div class="nvp__browser-window__url">{{@url}}</div>
          {{/if}}
        {{/if}}
        <div class="nvp__browser-window__controls">
          {{! minimize }}
          <svg viewBox="0 0 16 16" aria-hidden="true"><path
              d="M4 8h8"
              stroke="currentColor"
              stroke-width="1.2"
              stroke-linecap="round"
            /></svg>
          {{! maximize }}
          <svg viewBox="0 0 16 16" aria-hidden="true"><rect
              x="3"
              y="3"
              width="10"
              height="10"
              rx="1.5"
              stroke="currentColor"
              stroke-width="1.2"
              fill="none"
            /></svg>
          {{! close }}
          <svg viewBox="0 0 16 16" aria-hidden="true"><path
              d="M4.5 4.5l7 7M11.5 4.5l-7 7"
              stroke="currentColor"
              stroke-width="1.2"
              stroke-linecap="round"
            /></svg>
        </div>
      {{else if (isGeneric @os)}}
        {{#if @tabs}}
          <div class="nvp__browser-window__tabs" role="tablist">
            {{#each @tabs as |tab index|}}
              <div
                class="nvp__browser-window__tab"
                data-active={{if (isFirst index) "true"}}
                role="tab"
              >{{tab}}</div>
            {{/each}}
          </div>
        {{else}}
          {{#if @url}}
            <div class="nvp__browser-window__url">{{@url}}</div>
          {{/if}}
        {{/if}}
      {{else}}
        <div class="nvp__browser-window__circles">
          <div class="nvp__browser-window__circle"></div>
          <div class="nvp__browser-window__circle"></div>
          <div class="nvp__browser-window__circle"></div>
        </div>

        {{#if @tabs}}
          <div class="nvp__browser-window__tabs" role="tablist">
            {{#each @tabs as |tab index|}}
              <div
                class="nvp__browser-window__tab"
                data-active={{if (isFirst index) "true"}}
                role="tab"
              >{{tab}}</div>
            {{/each}}
          </div>
        {{else}}
          {{#if @url}}
            <div class="nvp__browser-window__url">{{@url}}</div>
          {{/if}}
        {{/if}}
      {{/if}}
    </div>

    {{#if @tabs}}
      <div class="nvp__browser-window__toolbar">
        {{! back }}
        <svg class="nvp__browser-window__nav" viewBox="0 0 16 16" aria-hidden="true"><path
            d="M10 3L5 8l5 5"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            fill="none"
          /></svg>
        {{! forward }}
        <svg class="nvp__browser-window__nav" viewBox="0 0 16 16" aria-hidden="true"><path
            d="M6 3l5 5-5 5"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            fill="none"
          /></svg>
        {{! reload }}
        <svg class="nvp__browser-window__nav" viewBox="0 0 16 16" aria-hidden="true"><path
            d="M13.5 8a5.5 5.5 0 1 1-1.3-3.5M12.5 2v3h-3"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            fill="none"
          /></svg>

        {{#if @url}}
          <div class="nvp__browser-window__url">{{@url}}</div>
        {{/if}}
      </div>
    {{/if}}

    <div class="nvp__browser-window__body">
      {{yield}}
    </div>
  </div>
</template>;

const isWindows = (os: string | undefined) => os === "windows";
const isUbuntu = (os: string | undefined) => os === "ubuntu";
const isGeneric = (os: string | undefined) => os === "generic";
const isFirst = (index: number) => index === 0;

function resolveTabStyle(tabStyle: string | undefined, os: string | undefined): string {
  if (tabStyle) return tabStyle;

  return os === "mac" || !os ? "safari" : "firefox";
}
