import "./variables.css";
import "./focus.css";
import "./table.css";
import Component from "@glimmer/component";
import type RouterService from "@ember/routing/router-service";
import type { Column, ColumnConfig, Row } from "@universal-ember/table";
import type { SortItem } from "@universal-ember/table/plugins/data-sorting";
export type Align = "start" | "center" | "end";
/**
 * A column.
 *
 * The `@universal-ember/table` config, plus how nvp.ui lays it out:
 * - upstream: `key`, `name`, `value`, `Cell`
 * - nvp.ui: `align`, `nowrap`, `sortable`, `resizable`
 *
 * Extra keys are kept.
 * A `Cell` component reads them from `@column.config`.
 */
export interface TableColumn<T = unknown> extends ColumnConfig<T> {
    /**
     * Text alignment of the column.
     * Numbers usually want `end`.
     *
     * Default: start
     */
    align?: Align;
    /**
     * Keeps the column's cells on one line.
     *
     * For ids, dates, short codes.
     */
    nowrap?: boolean;
    /**
     * Whether the header links to a sort by this column.
     *
     * The sort key is the column `key`.
     * Only columns the endpoint can sort by opt in.
     */
    sortable?: boolean;
    /**
     * Whether the edge between this column and the next one can be dragged.
     *
     * Both columns must opt in.
     * Widths are not in the URL, and last until the table is removed.
     */
    resizable?: boolean;
    [extra: string]: unknown;
}
/**
 * The arguments a `Cell` component receives.
 */
export interface CellSignature<T = unknown> {
    Args: {
        column: Column<T>;
        row: Row<T>;
    };
}
export interface Signature<T = unknown> {
    /**
     * The `<table>`.
     */
    Element: HTMLTableElement;
    Args: {
        columns: TableColumn<T>[];
        data: T[];
        /**
         * The table's accessible name, rendered as a visually hidden `<caption>`.
         *
         * A visible title is a heading outside the table.
         */
        caption: string;
    };
    Blocks: {
        /**
         * Shown instead of the rows when there is no data.
         */
        empty: [];
        /**
         * Below the table: pagination, totals, notes.
         */
        footer: [];
    };
}
export declare class Table<T = unknown> extends Component<Signature<T>> {
    #private;
    router: RouterService;
    /**
     * The plugin sets a width on every header,
     * so tables with no resizable column go without it
     * and size their columns from the content.
     *
     * Read once, because the plugin list is fixed when the table is created.
     */
    isResizable: boolean;
    table: import("@universal-ember/table").Table<T, unknown, unknown, unknown>;
    get sorts(): SortItem<T>[];
    /**
     * Turns `sortable` into a per-column plugin option.
     *
     * `resizable` is not passed on, because the plugin leaves a column
     * it cannot resize out of sharing the container width,
     * and that column then overflows a smaller container.
     * Instead, `showsResizeHandle` decides where the handles go.
     */
    toConfig: (column: TableColumn<T>) => ColumnConfig<T>;
    showsResizeHandle: (column: Column<T>) => boolean;
    /**
     * The `sort` value a header links to.
     *
     * Ascending first, then it toggles.
     * There is no unsorted state, because a link never removes a query param.
     */
    nextSort: (column: Column<T>) => string;
    get isEmpty(): boolean;
}
//# sourceMappingURL=table.d.ts.map