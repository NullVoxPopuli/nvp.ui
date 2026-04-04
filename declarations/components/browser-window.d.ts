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
export declare const BrowserWindow: TOC<BrowserWindowSignature>;
//# sourceMappingURL=browser-window.d.ts.map