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
     * - `"generic"` — Plain bar with no window controls
     */
    os?: "mac" | "windows" | "generic";

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
 * @example Windows style
 * ```gts
 * import { BrowserWindow } from "nvp.ui/browser-window";
 *
 * <template>
 *   <BrowserWindow @os="windows" @url="https://example.com">
 *     <p>Hello world!</p>
 *   </BrowserWindow>
 * </template>
 * ```
 *
 * @example Generic (no window controls)
 * ```gts
 * import { BrowserWindow } from "nvp.ui/browser-window";
 *
 * <template>
 *   <BrowserWindow @os="generic" @url="https://example.com">
 *     <p>Hello world!</p>
 *   </BrowserWindow>
 * </template>
 * ```
 */
export const BrowserWindow: TOC<BrowserWindowSignature> = <template>
  <div
    class="nvp__browser-window"
    data-os={{if @os @os "mac"}}
    data-flush={{if @flush "true"}}
    data-shadow={{if @shadow "true"}}
    data-grayscale={{if @grayscale "true"}}
    ...attributes
  >
    <div class="nvp__browser-window__header">
      {{#if (isWindows @os)}}
        {{#if @url}}
          <div class="nvp__browser-window__url">{{@url}}</div>
        {{/if}}
        <div class="nvp__browser-window__controls">
          {{! minimize }}
          <svg viewBox="0 0 12 12" aria-hidden="true"><rect y="5.5" width="12" height="1" fill="currentColor" /></svg>
          {{! maximize }}
          <svg viewBox="0 0 12 12" aria-hidden="true"><rect x="1" y="1" width="10" height="10" stroke="currentColor" stroke-width="1" fill="none" /></svg>
          {{! close }}
          <svg viewBox="0 0 12 12" aria-hidden="true"><path d="M1 1l10 10M11 1L1 11" stroke="currentColor" stroke-width="1.2" /></svg>
        </div>
      {{else if (isGeneric @os)}}
        {{#if @url}}
          <div class="nvp__browser-window__url">{{@url}}</div>
        {{/if}}
      {{else}}
        <div class="nvp__browser-window__circles">
          <div class="nvp__browser-window__circle"></div>
          <div class="nvp__browser-window__circle"></div>
          <div class="nvp__browser-window__circle"></div>
        </div>

        {{#if @url}}
          <div class="nvp__browser-window__url">{{@url}}</div>
        {{/if}}
      {{/if}}
    </div>

    <div class="nvp__browser-window__body">
      {{yield}}
    </div>
  </div>
</template>;

const isWindows = (os: string | undefined) => os === "windows";
const isGeneric = (os: string | undefined) => os === "generic";
