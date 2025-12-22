import "./tabs.css";
import { type ContainerType } from "ember-primitives/components/tabs";
import type { TOC } from "@ember/component/template-only";
import type { ComponentLike, WithBoundArgs } from "@glint/template";
declare const StyledTab: TOC<{
    Args: {
        tab: ContainerType;
        label: undefined;
        content: undefined;
    };
    Blocks: {
        button: [];
        content: [];
        default: never;
    };
} | {
    Args: {
        tab: ContainerType;
        label: string | ComponentLike;
        content: undefined;
    };
    Blocks: {
        default: [];
        button: never;
        content: never;
    };
} | {
    Args: {
        label: string | ComponentLike;
        content: string | ComponentLike;
        tab: ContainerType;
    };
    Blocks: {
        default: [];
        button: never;
        content: never;
    };
}>;
export declare const Tabs: TOC<{
    Args: {
        /**
         * Override the default tab orientation relative to the tabpanel content
         *
         * Default: top
         */
        orientation?: "top" | "left" | "right" | "bottom";
        /**
         * Override the default selection color to the tablist.
         * This is the color to indicate the active tab.
         *
         * Default: 'primary'
         */
        variant?: "primary" | "secondary" | "danger";
    };
    Blocks: {
        default: [WithBoundArgs<typeof StyledTab, "tab">];
    };
}>;
export {};
//# sourceMappingURL=tabs.d.ts.map