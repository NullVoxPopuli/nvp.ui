import "./tabbed-shell-script.css";
import type { Tab } from './tabs';
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
declare const ShellTab: TOC<ShellTabSignature>;
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
export declare const TabbedShellScript: TOC<TabbedShellScriptSignature>;
export {};
//# sourceMappingURL=tabbed-shell-script.d.ts.map