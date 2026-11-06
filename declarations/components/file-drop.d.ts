import "./variables.css";
import "./focus.css";
import "./file-drop.css";
import type { TOC } from "@ember/component/template-only";
export interface Signature {
    /**
     * The drop zone, a `<label>` around a file `<input>`,
     * so a click anywhere in it opens the file picker.
     */
    Element: HTMLLabelElement;
    Args: {
        /**
         * Called with the files that the user dropped or picked.
         *
         * Only files that match `@accept` are passed.
         * If no file matches, `@onFiles` is not called.
         */
        onFiles: (files: File[]) => void;
        /**
         * Which files to take, with the syntax of the `accept` attribute
         * of a file input, for example `"video/*"` or `".json,application/json"`.
         *
         * The file picker shows only these files.
         * A drop with other files is ignored.
         */
        accept?: string;
        /**
         * Take more than one file. Default: `false`.
         */
        multiple?: boolean;
    };
    Blocks: {
        /**
         * The content of the drop zone.
         * Default: "Drop a file here, or click to choose one".
         *
         * `isDragging` is `true` while files are over the drop zone.
         */
        default: [{
            isDragging: boolean;
        }];
    };
}
/**
 * A styled `FileDrop` from ember-primitives, with default text.
 */
export declare const FileDrop: TOC<Signature>;
//# sourceMappingURL=file-drop.d.ts.map