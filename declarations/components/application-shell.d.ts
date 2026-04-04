import "ember-mobile-menu/themes/android";
import "./application-shell.css";
import type { TOC } from "@ember/component/template-only";
export interface ApplicationShellSignature {
    Element: HTMLDivElement;
    Blocks: {
        headerLeft: [];
        headerRight: [];
        nav: [];
        default: [];
    };
}
export declare const ApplicationShell: TOC<ApplicationShellSignature>;
//# sourceMappingURL=application-shell.d.ts.map