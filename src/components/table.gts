import "./variables.css";
import "./focus.css";
import "./table.css";

import Component from "@glimmer/component";
import { service } from "@ember/service";

import { withQP } from "ember-primitives/qp";

import { headlessTable } from "@universal-ember/table";
import { columns } from "@universal-ember/table/plugins";
import { ColumnResizing, resizeHandle } from "@universal-ember/table/plugins/column-resizing";
import {
  DataSorting,
  isSortable,
  SortDirection,
  sortDirection,
} from "@universal-ember/table/plugins/data-sorting";

import type RouterService from "@ember/routing/router-service";
import type { ComponentLike } from "@glint/template";
import type { Column, ColumnConfig, Row } from "@universal-ember/table";
import type { SortItem } from "@universal-ember/table/plugins/data-sorting";

export type Align = "start" | "center" | "end";

/**
 * Upstream defaults to 128px,
 * which pushes a table of four columns off the side of a phone.
 */
const MIN_COLUMN_WIDTH = 64;

/**
 * A column.
 *
 * The `@universal-ember/table` config, plus how nvp.ui lays it out:
 * - `key`, `name`, `value`, `Cell` are the upstream config
 * - `align`, `nowrap`, `sortable`, `resizable` are nvp.ui's
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

function layoutOf<T>(column: Column<T>) {
  return column.config as TableColumn<T>;
}

function alignOf<T>(column: Column<T>) {
  return layoutOf(column).align;
}

function nowrapOf<T>(column: Column<T>) {
  return layoutOf(column).nowrap;
}

/**
 * `Cell` is typed loosely upstream.
 * This is what the invocation needs.
 */
function cellOf<T>(column: Column<T>) {
  return column.Cell as unknown as ComponentLike<CellSignature<T>> | undefined;
}

/**
 * The `sort` query param, in {json:api} syntax:
 * comma separated keys, `-` for descending.
 */
function parseSorts<T>(param: unknown): SortItem<T>[] {
  if (typeof param !== "string" || !param) return [];

  return param
    .split(",")
    .map((key) =>
      key.startsWith("-")
        ? { property: key.slice(1), direction: SortDirection.Descending }
        : { property: key, direction: SortDirection.Ascending },
    ) as SortItem<T>[];
}

export class Table<T = unknown> extends Component<Signature<T>> {
  @service("router") declare router: RouterService;

  /**
   * The plugin sets a width on every header,
   * so tables with no resizable column go without it
   * and size their columns from the content.
   *
   * Read once, because the plugin list is fixed when the table is created.
   */
  isResizable = this.args.columns.some((column) => column.resizable);

  table = headlessTable<T>(this, {
    columns: () => this.args.columns.map(this.toConfig),
    data: () => this.args.data,
    plugins: this.plugins,
  });

  get plugins() {
    const sorting = DataSorting.with(() => ({ sorts: this.sorts }));

    if (!this.isResizable) return [sorting];

    return [sorting, ColumnResizing.with(() => ({ handlePosition: "right" }))];
  }

  get sorts() {
    return parseSorts<T>(this.router.currentRoute?.queryParams?.["sort"]);
  }

  /**
   * Turns `sortable` into a per-column plugin option.
   *
   * `resizable` is not passed on, because the plugin leaves a column
   * it cannot resize out of sharing the container width,
   * and that column then overflows a smaller container.
   * Instead, `showsResizeHandle` decides where the handles go.
   */
  toConfig = (column: TableColumn<T>): ColumnConfig<T> => {
    const pluginOptions = column.pluginOptions?.slice() ?? [];

    pluginOptions.push(DataSorting.forColumn(() => ({ isSortable: column.sortable === true })));

    if (this.isResizable) {
      pluginOptions.push(ColumnResizing.forColumn(() => ({ minWidth: MIN_COLUMN_WIDTH })));
    }

    return { ...column, pluginOptions };
  };

  showsResizeHandle = (column: Column<T>) => {
    const next = columns.next(column);

    return Boolean(layoutOf(column).resizable && next && layoutOf(next).resizable);
  };

  /**
   * The `sort` value a header links to.
   *
   * Ascending first, then it toggles.
   * There is no unsorted state, because a link never removes a query param.
   */
  nextSort = (column: Column<T>) => {
    const key = String(column.config.key);

    return sortDirection(column) === SortDirection.Ascending ? `-${key}` : key;
  };

  get isEmpty() {
    return this.args.data.length === 0;
  }

  <template>
    <div class="nvp__table" {{this.table.modifiers.container}}>
      <table class="nvp__table__table" data-resizable={{this.isResizable}} ...attributes>
        <caption class="nvp__table__caption">{{@caption}}</caption>

        <thead class="nvp__table__head">
          <tr>
            {{#each this.table.columns as |column|}}
              <th
                scope="col"
                class="nvp__table__header-cell"
                data-align={{alignOf column}}
                {{this.table.modifiers.columnHeader column}}
              >
                {{#if (isSortable column)}}
                  <a
                    class="nvp__table__sort"
                    data-sort={{sortDirection column}}
                    href={{withQP "sort" (this.nextSort column)}}
                  >
                    {{column.name}}
                    <span class="nvp__table__sort-icon" aria-hidden="true"></span>
                  </a>
                {{else}}
                  {{column.name}}
                {{/if}}

                {{#if (this.showsResizeHandle column)}}
                  <button
                    type="button"
                    class="nvp__table__resize-handle"
                    aria-label="Resize {{column.name}}"
                    {{resizeHandle column}}
                  ></button>
                {{/if}}
              </th>
            {{/each}}
          </tr>
        </thead>

        {{#unless this.isEmpty}}
          <tbody class="nvp__table__body">
            {{#each this.table.rows as |row|}}
              <tr class="nvp__table__row" {{this.table.modifiers.row row}}>
                {{#each this.table.columns as |column|}}
                  <td
                    class="nvp__table__cell"
                    data-align={{alignOf column}}
                    data-nowrap={{nowrapOf column}}
                  >
                    {{#let (cellOf column) as |Cell|}}
                      {{#if Cell}}
                        <Cell @column={{column}} @row={{row}} />
                      {{else}}
                        {{column.getValueForRow row}}
                      {{/if}}
                    {{/let}}
                  </td>
                {{/each}}
              </tr>
            {{/each}}
          </tbody>
        {{/unless}}
      </table>

      {{#if this.isEmpty}}
        <div class="nvp__table__empty">
          {{yield to="empty"}}
        </div>
      {{/if}}

      {{#if (has-block "footer")}}
        <div class="nvp__table__footer">
          {{yield to="footer"}}
        </div>
      {{/if}}
    </div>
  </template>
}
