import "./variables.css";
import "./focus.css";
import "./menu.css";
import type { TOC } from "@ember/component/template-only";
import type { ComponentLike } from "@glint/template";
export interface Signature {
    Element: null;
    Args: {
        /**
         * Color variant for the trigger button
         */
        variant?: "primary" | "secondary" | "danger" | "default";
        /**
         * Placement of the menu content relative to the trigger.
         * Uses floating-ui placement values.
         */
        placement?: string;
    };
    Blocks: {
        default: [
            {
                Trigger: ComponentLike<{
                    Element: HTMLButtonElement;
                    Blocks: {
                        default: [];
                    };
                }>;
                Content: ComponentLike<{
                    Element: HTMLDivElement;
                    Blocks: {
                        default: [
                            {
                                Item: ComponentLike<{
                                    Element: HTMLButtonElement;
                                    Args: {
                                        onSelect?: (event: Event) => void;
                                    };
                                    Blocks: {
                                        default: [];
                                    };
                                }>;
                                LinkItem: ComponentLike<{
                                    Element: HTMLAnchorElement;
                                    Args: {
                                        href: string;
                                    };
                                    Blocks: {
                                        default: [];
                                    };
                                }>;
                                Separator: ComponentLike<{
                                    Element: HTMLDivElement;
                                }>;
                            }
                        ];
                    };
                }>;
            }
        ];
    };
}
export declare const Menu: TOC<Signature>;
//# sourceMappingURL=menu.d.ts.map