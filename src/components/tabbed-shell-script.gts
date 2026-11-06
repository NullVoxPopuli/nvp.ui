import "./tabbed-shell-script.css";

import { Tabs } from "./tabs.gts";

import type { Tab } from "./tabs.gts";
import type { TOC } from "@ember/component/template-only";
import type { WithBoundArgs } from "@glint/template";

export interface ScriptSignature {
  Args: {
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

    /**
     * Provided by `<TabbedShellScript>`.
     */
    tab: Tab;
  };
}

const Script: TOC<ScriptSignature> = <template>
  <@tab @label={{@label}}>
    <pre class="nvp__tabbed-shell-script__script"><code>{{@script}}</code></pre>
  </@tab>
</template>;

export interface TabbedShellScriptSignature {
  Blocks: {
    default: [WithBoundArgs<typeof Script, "tab">];
  };
}

/**
 * Shows one shell script per tab,
 * for example the same install command for each package manager.
 *
 * @example
 * ```gjs
 * import { TabbedShellScript } from "nvp.ui/tabbed-shell-script";
 *
 * <template>
 *   <TabbedShellScript as |Script|>
 *     <Script @label="pnpm" @script="pnpm add nvp.ui" />
 *     <Script @label="npm" @script="npm install nvp.ui" />
 *   </TabbedShellScript>
 * </template>
 * ```
 */
export const TabbedShellScript: TOC<TabbedShellScriptSignature> = <template>
  <Tabs as |Tab|>
    {{yield (component Script tab=Tab)}}
  </Tabs>
</template>;
