import "./tabs.css";
import { type ContainerType } from "ember-primitives/components/tabs";
import type { TOC } from "@ember/component/template-only";
import type { ComponentLike } from "@glint/template";
/**
 * A tab with the `<:button>` and `<:content>` blocks.
 */
interface BlocksTab {
    Args: {
        tab: ContainerType;
        label?: undefined;
        content?: undefined;
    };
    Blocks: {
        button: [];
        content: [];
        default: never;
    };
}
/**
 * A tab with `@label`, and the default block for the tab panel.
 */
interface LabelTab {
    Args: {
        tab: ContainerType;
        label: string | ComponentLike;
        content?: undefined;
    };
    Blocks: {
        default: [];
        button: never;
        content: never;
    };
}
/**
 * A tab with `@label` and `@content`.
 */
interface LabelContentTab {
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
}
/**
 * `WithBoundArgs` removes `tab` from the union as a whole,
 * which loses which args go together.
 * This removes it from each way to write a tab on its own.
 */
type Bound<S> = S extends {
    Args: infer A;
    Blocks: infer B;
} ? {
    Args: Omit<A, "tab">;
    Blocks: B;
} : never;
export type Tab = ComponentLike<Bound<BlocksTab | LabelTab | LabelContentTab>>;
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
        default: [Tab];
    };
}>;
export {};
//# sourceMappingURL=tabs.d.ts.map