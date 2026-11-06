import "./tabbed-shell-script.css";

import { Tabs } from "./tabs.gts";

import type { Tab } from "./tabs.gts";
import type { TOC } from "@ember/component/template-only";
import type { WithBoundArgs } from "@glint/template";

export interface ShellTabSignature {
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

const ShellTab: TOC<ShellTabSignature> = <template>
  <@tab @label={{@label}}>
    <pre class="nvp__tabbed-shell-script__script"><code>{{@script}}</code></pre>
  </@tab>
</template>;

export interface TabbedShellScriptSignature {
  Blocks: {
    default: [WithBoundArgs<typeof ShellTab, "tab">];
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
 *   <TabbedShellScript as |Tab|>
 *     <Tab @label="pnpm" @script="pnpm add nvp.ui" />
 *     <Tab @label="npm" @script="npm install nvp.ui" />
 *   </TabbedShellScript>
 * </template>
 * ```
 */
export const TabbedShellScript: TOC<TabbedShellScriptSignature> = <template>
  <Tabs as |Tab|>
    {{yield (component ShellTab tab=Tab)}}
  </Tabs>
</template>;
