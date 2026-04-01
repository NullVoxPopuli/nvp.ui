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
     * Remove padding from the content area and let content
     * (images, iframes) fill edge-to-edge.
     */
    flush?: boolean;

    /**
     * Add a layered drop shadow to the window.
     */
    shadow?: boolean;

    /**
     * Render the traffic-light circles in grayscale.
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
 * A Safari-esque browser window mockup for demos and documentation.
 *
 * Inspired by [zachleat/browser-window](https://github.com/zachleat/browser-window).
 *
 * @example Basic usage
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
 * @example Flush content with shadow
 * ```gts
 * import { BrowserWindow } from "nvp.ui/browser-window";
 *
 * <template>
 *   <BrowserWindow @url="https://example.com" @flush={{true}} @shadow={{true}}>
 *     <img src="/screenshot.png" alt="Screenshot" />
 *   </BrowserWindow>
 * </template>
 * ```
 */
export const BrowserWindow: TOC<BrowserWindowSignature> = <template>
  <div
    class="nvp__browser-window"
    data-flush={{if @flush "true"}}
    data-shadow={{if @shadow "true"}}
    data-grayscale={{if @grayscale "true"}}
    ...attributes
  >
    <div class="nvp__browser-window__header">
      <div class="nvp__browser-window__circles">
        <div class="nvp__browser-window__circle"></div>
        <div class="nvp__browser-window__circle"></div>
        <div class="nvp__browser-window__circle"></div>
      </div>

      {{#if @url}}
        <div class="nvp__browser-window__url">{{@url}}</div>
      {{/if}}
    </div>

    <div class="nvp__browser-window__body">
      {{yield}}
    </div>
  </div>
</template>;
