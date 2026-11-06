import "./browser-window.css"
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

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
const BrowserWindow = setComponentTemplate(precompileTemplate("<div class=\"nvp__browser-window\" data-os={{if @os @os \"mac\"}} data-tab-style={{if @tabs (resolveTabStyle @tabStyle @os)}} data-flush={{if @flush \"true\"}} data-shadow={{if @shadow \"true\"}} data-grayscale={{if @grayscale \"true\"}} ...attributes>\n  <div class=\"nvp__browser-window__header\">\n    {{#if (isWindows @os)}}\n      {{#if @tabs}}\n        <div class=\"nvp__browser-window__tabs\" role=\"tablist\">\n          {{#each @tabs as |tab index|}}\n            <div class=\"nvp__browser-window__tab\" data-active={{if (isFirst index) \"true\"}} role=\"tab\"><span class=\"nvp__browser-window__tab-label\">{{tab}}</span>\n              <svg class=\"nvp__browser-window__tab-close\" viewBox=\"0 0 16 16\" aria-hidden=\"true\" role=\"presentation\"><path role=\"presentation\" d=\"M4.5 4.5l7 7M11.5 4.5l-7 7\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" /></svg>\n            </div>\n          {{/each}}\n          <svg class=\"nvp__browser-window__new-tab\" viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M8 3v10M3 8h10\" stroke=\"currentColor\" stroke-width=\"1.3\" stroke-linecap=\"round\" /></svg>\n        </div>\n      {{else}}\n        {{#if @url}}\n          <div class=\"nvp__browser-window__url\">{{@url}}</div>\n        {{/if}}\n      {{/if}}\n      <div class=\"nvp__browser-window__controls\">\n        {{!-- minimize --}}\n        <svg viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M4 8h8\" stroke=\"currentColor\" stroke-width=\"1.2\" /></svg>\n        {{!-- maximize --}}\n        <svg viewBox=\"0 0 16 16\" aria-hidden=\"true\"><rect x=\"3\" y=\"3\" width=\"10\" height=\"10\" stroke=\"currentColor\" stroke-width=\"1.2\" fill=\"none\" /></svg>\n        {{!-- close --}}\n        <svg viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M4.5 4.5l7 7M11.5 4.5l-7 7\" stroke=\"currentColor\" stroke-width=\"1.2\" /></svg>\n      </div>\n    {{else if (isUbuntu @os)}}\n      {{#if @tabs}}\n        <div class=\"nvp__browser-window__tabs\" role=\"tablist\">\n          {{#each @tabs as |tab index|}}\n            <div class=\"nvp__browser-window__tab\" data-active={{if (isFirst index) \"true\"}} role=\"tab\"><span class=\"nvp__browser-window__tab-label\">{{tab}}</span>\n              <svg class=\"nvp__browser-window__tab-close\" viewBox=\"0 0 16 16\" aria-hidden=\"true\" role=\"presentation\"><path role=\"presentation\" d=\"M4.5 4.5l7 7M11.5 4.5l-7 7\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" /></svg>\n            </div>\n          {{/each}}\n          <svg class=\"nvp__browser-window__new-tab\" viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M8 3v10M3 8h10\" stroke=\"currentColor\" stroke-width=\"1.3\" stroke-linecap=\"round\" /></svg>\n        </div>\n      {{else}}\n        {{#if @url}}\n          <div class=\"nvp__browser-window__url\">{{@url}}</div>\n        {{/if}}\n      {{/if}}\n      <div class=\"nvp__browser-window__controls\">\n        {{!-- minimize --}}\n        <svg viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M4 8h8\" stroke=\"currentColor\" stroke-width=\"1.2\" stroke-linecap=\"round\" /></svg>\n        {{!-- maximize --}}\n        <svg viewBox=\"0 0 16 16\" aria-hidden=\"true\"><rect x=\"3\" y=\"3\" width=\"10\" height=\"10\" rx=\"1.5\" stroke=\"currentColor\" stroke-width=\"1.2\" fill=\"none\" /></svg>\n        {{!-- close --}}\n        <svg viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M4.5 4.5l7 7M11.5 4.5l-7 7\" stroke=\"currentColor\" stroke-width=\"1.2\" stroke-linecap=\"round\" /></svg>\n      </div>\n    {{else if (isGeneric @os)}}\n      {{#if @tabs}}\n        <div class=\"nvp__browser-window__tabs\" role=\"tablist\">\n          {{#each @tabs as |tab index|}}\n            <div class=\"nvp__browser-window__tab\" data-active={{if (isFirst index) \"true\"}} role=\"tab\">{{tab}}</div>\n          {{/each}}\n        </div>\n      {{else}}\n        {{#if @url}}\n          <div class=\"nvp__browser-window__url\">{{@url}}</div>\n        {{/if}}\n      {{/if}}\n    {{else}}\n      <div class=\"nvp__browser-window__circles\">\n        <div class=\"nvp__browser-window__circle\"></div>\n        <div class=\"nvp__browser-window__circle\"></div>\n        <div class=\"nvp__browser-window__circle\"></div>\n      </div>\n\n      {{#if @tabs}}\n        <div class=\"nvp__browser-window__tabs\" role=\"tablist\">\n          {{#each @tabs as |tab index|}}\n            <div class=\"nvp__browser-window__tab\" data-active={{if (isFirst index) \"true\"}} role=\"tab\">{{tab}}</div>\n          {{/each}}\n        </div>\n      {{else}}\n        {{#if @url}}\n          <div class=\"nvp__browser-window__url\">{{@url}}</div>\n        {{/if}}\n      {{/if}}\n    {{/if}}\n  </div>\n\n  {{#if @tabs}}\n    <div class=\"nvp__browser-window__toolbar\">\n      {{!-- back --}}\n      <svg class=\"nvp__browser-window__nav\" viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M10 3L5 8l5 5\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\" fill=\"none\" /></svg>\n      {{!-- forward --}}\n      <svg class=\"nvp__browser-window__nav\" viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M6 3l5 5-5 5\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\" fill=\"none\" /></svg>\n      {{!-- reload --}}\n      <svg class=\"nvp__browser-window__nav\" viewBox=\"0 0 16 16\" aria-hidden=\"true\"><path d=\"M13.5 8a5.5 5.5 0 1 1-1.3-3.5M12.5 2v3h-3\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\" fill=\"none\" /></svg>\n\n      {{#if @url}}\n        <div class=\"nvp__browser-window__url\">{{@url}}</div>\n      {{/if}}\n    </div>\n  {{/if}}\n\n  <div class=\"nvp__browser-window__body\">\n    {{yield}}\n  </div>\n</div>", {
  strictMode: true,
  scope: () => ({
    resolveTabStyle,
    isWindows,
    isFirst,
    isUbuntu,
    isGeneric
  })
}), templateOnly());
const isWindows = os => os === "windows";
const isUbuntu = os => os === "ubuntu";
const isGeneric = os => os === "generic";
const isFirst = index => index === 0;
function resolveTabStyle(tabStyle, os) {
  if (tabStyle) return tabStyle;
  return os === "mac" || !os ? "safari" : "firefox";
}

export { BrowserWindow };
//# sourceMappingURL=browser-window.js.map
