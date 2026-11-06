import "./variables.css";
import "./focus.css";
import "./range-slider.css";
import Component from "@glimmer/component";
export interface Signature {
    /**
     * The outer element, with `role="group"`.
     */
    Element: HTMLSpanElement;
    Args: {
        /**
         * Accessible name for the group of two thumbs.
         */
        label: string;
        /**
         * The lowest value. Default: `0`.
         */
        min?: number;
        /**
         * The highest value.
         */
        max: number;
        /**
         * The value of the first thumb.
         */
        start: number;
        /**
         * The value of the second thumb.
         */
        end: number;
        /**
         * Values snap to multiples of `@step`, counted from `@min`. Default: `1`.
         *
         * Arrow keys move a thumb by one step.
         */
        step?: number;
        /**
         * The smallest distance between the two thumbs. Default: `@step`.
         */
        minGap?: number;
        /**
         * Called with the new values when a thumb moves.
         *
         * The slider is controlled: it shows `@start` and `@end`,
         * so pass the new values back in.
         */
        onChange: (start: number, end: number) => void;
        /**
         * Called with the values when a move ends:
         * at the end of a drag, and after each key press.
         *
         * For example, to record one undo step per move, not one per `@onChange`.
         */
        onCommit?: (start: number, end: number) => void;
        /**
         * Turns a value into text for assistive technology (`aria-valuetext`)
         * and for the visible thumb labels.
         *
         * Default: the number as is.
         */
        formatValue?: (value: number) => string;
        /**
         * Accessible name of the first thumb. Default: `"Start"`.
         */
        startLabel?: string;
        /**
         * Accessible name of the second thumb. Default: `"End"`.
         */
        endLabel?: string;
    };
    Blocks: {
        /**
         * Extra content inside the track, under the thumbs,
         * for example a playhead.
         *
         * `position` turns a value into a percentage of the track width.
         */
        default: [{
            position: (value: number) => number;
        }];
    };
}
export declare class RangeSlider extends Component<Signature> {
    get min(): number;
    get step(): number;
    get minGap(): number;
    get values(): number[];
    get startLabel(): string;
    get endLabel(): string;
    get blockArgs(): {
        position: (value: number) => number;
    };
    position: (value: number) => number;
    format: (value: number) => string;
    /**
     * Slider keeps the thumbs in order, and `@minGap` keeps them apart.
     * The thumb that moved stops at the gap. The other thumb stays.
     */
    change: (value: number | number[]) => void;
    /**
     * Slider reports a commit after the change,
     * so `@start` and `@end` already have the values that `@onChange` accepted.
     */
    commit: () => void;
    /**
     * The native input moves before `@onChange` decides.
     * If the thumb stays, the input goes back to it,
     * so that the next key press and assistive technology use the real value.
     */
    resync: (event: Event) => void;
}
//# sourceMappingURL=range-slider.d.ts.map