import "./variables.css";
import "./focus.css";
import "./table.css";

import Component from "@glimmer/component";
import { service } from "@ember/service";

import { withQP } from "ember-primitives/qp";

import { headlessTable } from "@universal-ember/table";
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
 * A column.
 *
 * The `@universal-ember/table` config, plus how nvp.ui lays it out:
 * - `key`, `name`, `value`, `Cell` are the upstream config
 * - `align`, `nowrap`, `sortable` are nvp.ui's
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

  table = headlessTable<T>(this, {
    columns: () => this.args.columns.map((column) => this.withSorting(column)),
    data: () => this.args.data,
    plugins: [[DataSorting, () => ({ sorts: this.sorts })]],
  });

  get sorts() {
    return parseSorts<T>(this.router.currentRoute?.queryParams?.["sort"]);
  }

  /**
   * Turns `sortable` into the plugin's per-column option,
   * which drives `aria-sort`.
   */
  withSorting = (column: TableColumn<T>): ColumnConfig<T> => {
    const sortingOptions = () => ({ isSortable: column.sortable === true });

    return {
      ...column,
      pluginOptions: [
        ...(column.pluginOptions ?? []),
        [DataSorting, sortingOptions] as unknown as NonNullable<
          ColumnConfig<T>["pluginOptions"]
        >[number],
      ],
    };
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
    <div class="nvp__table" data-empty={{this.isEmpty}}>
      <table class="nvp__table__table" {{this.table.modifiers.container}} ...attributes>
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
