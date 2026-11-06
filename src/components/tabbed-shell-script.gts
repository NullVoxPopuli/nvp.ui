import "./tabbed-shell-script.css";

import { assert } from "@ember/debug";

import { Tabs } from "./tabs.gts";

import type { Tab } from "./tabs.gts";
import type { TOC } from "@ember/component/template-only";
import type { WithBoundArgs } from "@glint/template";

/**
 * One tab: the items of `@scripts`, and the args of the yielded `Tab`.
 */
export interface ShellScript {
  /**
   * The text of the tab, for example the name of a package manager.
   */
  label: string;

  /**
   * The shell script that shows when the tab is selected.
   *
   * Line breaks in the string show as line breaks.
   */
  script: string;
}

export interface ShellTabArgs extends ShellScript {
  /**
   * Provided by `<TabbedShellScript>`.
   */
  tab: Tab;
}

export interface ShellTabSignature {
  Args: ShellTabArgs;
}

const ShellTab: TOC<ShellTabSignature> = <template>
  <@tab @label={{@label}}>
    <pre class="nvp__tabbed-shell-script__script"><code>{{@script}}</code></pre>
  </@tab>
</template>;

/**
 * Glint cannot reject a block for one member of a signature union,
 * so this checks it at runtime.
 */
function noBlockWithScripts(hasBlock: boolean) {
  assert("<TabbedShellScript> takes @scripts or a block, not both", !hasBlock);
}

/**
 * The tabs come from `@scripts`, so there is no block.
 */
export interface ScriptsSignature {
  Args: {
    /**
     * One tab per item, in order.
     */
    scripts: ShellScript[];
  };
  Blocks: {
    default: never;
  };
}

/**
 * The tabs come from the yielded `Tab`, so there is no `@scripts`.
 */
export interface BlockSignature {
  Args: {
    scripts?: undefined;
  };
  Blocks: {
    default: [WithBoundArgs<typeof ShellTab, "tab">];
  };
}

export type TabbedShellScriptSignature = ScriptsSignature | BlockSignature;

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
export const TabbedShellScript: TOC<TabbedShellScriptSignature> = <template>
  <Tabs as |Tab|>
    {{#if @scripts}}
      {{noBlockWithScripts (has-block)}}
      {{#each @scripts as |item|}}
        <ShellTab @tab={{Tab}} @label={{item.label}} @script={{item.script}} />
      {{/each}}
    {{else}}
      {{yield (component ShellTab tab=Tab)}}
    {{/if}}
  </Tabs>
</template>;
