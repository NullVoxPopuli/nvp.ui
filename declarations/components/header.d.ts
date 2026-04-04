import "./header.css";
import type { TOC } from "@ember/component/template-only";
export interface Signature {
    Element: HTMLElement;
    Args: {
        /**
         * Position of the header bar.
         * Can be "top" (default) or "bottom".
         */
        position?: "top" | "bottom";
    };
    Blocks: {
        left: [];
        right: [];
    };
}
export declare const Header: TOC<Signature>;
//# sourceMappingURL=header.d.ts.map