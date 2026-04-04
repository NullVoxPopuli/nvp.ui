/**
 * Test utility for interacting with the
 * ThemeToggle component.
 *
 * Simulates user behavior and provides high level functions so you don't need to worry about the DOM.
 *
 * Actual elements are not exposed, as the elements are private API.
 */
export declare function themeToggle(selector?: string): ThemeToggle;
export declare class ThemeToggle {
    #private;
    constructor(root: string);
    light(): Promise<void>;
    dark(): Promise<void>;
    get current(): "dark" | "light";
    get isDark(): boolean;
    get isLight(): boolean;
    toggle(): Promise<void>;
}
//# sourceMappingURL=theme-toggle.d.ts.map