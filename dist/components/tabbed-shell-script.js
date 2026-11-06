import "./tabbed-shell-script.css"
import { assert } from '@ember/debug';
import { Tabs } from './tabs.js';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

const ShellTab = setComponentTemplate(precompileTemplate("<@tab @label={{@label}}>\n  <pre class=\"nvp__tabbed-shell-script__script\"><code>{{@script}}</code></pre>\n</@tab>", {
  strictMode: true
}), templateOnly());
/**
 * Glint cannot reject a block for one member of a signature union,
 * so this checks it at runtime.
 */
function noBlockWithScripts(hasBlock) {
  assert("<TabbedShellScript> takes @scripts or a block, not both", !hasBlock);
}
/**
 * The tabs come from `@scripts`, so there is no block.
 */

/**
 * The tabs come from the yielded `Tab`, so there is no `@scripts`.
 */

/**
 * Shows one shell script per tab,
 * for example the same install command for each package manager.
 *
 * Pass `@scripts`, or write each tab in the block. Not both.
 *
 * @example
 * ```gjs
 * import { TabbedShellScript } from "nvp.ui/tabbed-shell-script";
 *
 * const scripts = [
 *   { label: "pnpm", script: "pnpm add nvp.ui" },
 *   { label: "npm", script: "npm install nvp.ui" },
 * ];
 *
 * <template>
 *   <TabbedShellScript @scripts={{scripts}} />
 * </template>
 * ```
 *
 * @example
 * ```gjs
 * import { TabbedShellScript } from "nvp.ui/tabbed-shell-script";
 *
 * <template>
 *   <TabbedShellScript as |Tab|>
 *     <Tab @label="pnpm" @script="pnpm add nvp.ui" />
 *     <Tab @label="npm" @script="npm install nvp.ui" />
 *   </TabbedShellScript>
 * </template>
 * ```
 */
const TabbedShellScript = setComponentTemplate(precompileTemplate("<Tabs as |Tab|>\n  {{#if @scripts}}\n    {{noBlockWithScripts (has-block)}}\n    {{#each @scripts as |item|}}\n      <ShellTab @tab={{Tab}} @label={{item.label}} @script={{item.script}} />\n    {{/each}}\n  {{else}}\n    {{yield (component ShellTab tab=Tab)}}\n  {{/if}}\n</Tabs>", {
  strictMode: true,
  scope: () => ({
    Tabs,
    noBlockWithScripts,
    ShellTab
  })
}), templateOnly());

export { TabbedShellScript };
//# sourceMappingURL=tabbed-shell-script.js.map
