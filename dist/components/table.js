import "./table.css"
import '../variables-goOgJf2v.js';
import '../focus-C7z7jBjO.js';
import Component from '@glimmer/component';
import { service } from '@ember/service';
import { withQP } from 'ember-primitives/qp';
import { headlessTable } from '@universal-ember/table';
import { columns } from '@universal-ember/table/plugins';
import { ColumnResizing, resizeHandle } from '@universal-ember/table/plugins/column-resizing';
import { DataSorting, sortDirection, SortDirection, isSortable } from '@universal-ember/table/plugins/data-sorting';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import { g, i } from 'decorator-transforms/runtime';

;

/**
 * Upstream defaults to 128px,
 * which pushes a table of four columns off the side of a phone.
 */
const MIN_COLUMN_WIDTH = 64;
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

/**
 * The arguments a `Cell` component receives.
 */

function layoutOf(column) {
  return column.config;
}
function alignOf(column) {
  return layoutOf(column).align;
}
function nowrapOf(column) {
  return layoutOf(column).nowrap;
}
/**
 * `Cell` is typed loosely upstream.
 * This is what the invocation needs.
 */
function cellOf(column) {
  return column.Cell;
}
/**
 * The `sort` query param, in {json:api} syntax:
 * comma separated keys, `-` for descending.
 */
function parseSorts(param) {
  if (typeof param !== "string" || !param) return [];
  return param.split(",").map(key => key.startsWith("-") ? {
    property: key.slice(1),
    direction: SortDirection.Descending
  } : {
    property: key,
    direction: SortDirection.Ascending
  });
}
class Table extends Component {
  static {
    g(this.prototype, "router", [service("router")]);
  }
  #router = (i(this, "router"), void 0);
  /**
  * The plugin sets a width on every header,
  * so tables with no resizable column go without it
  * and size their columns from the content.
  *
  * Read once, because the plugin list is fixed when the table is created.
  */
  isResizable = this.args.columns.some(column => column.resizable);
  table = headlessTable(this, {
    columns: () => this.args.columns.map(this.toConfig),
    data: () => this.args.data,
    plugins: this.#plugins
  });
  get #plugins() {
    const sorting = DataSorting.with(() => ({
      sorts: this.sorts
    }));
    if (!this.isResizable) return [sorting];
    return [sorting, ColumnResizing.with(() => ({
      handlePosition: "right"
    }))];
  }
  get sorts() {
    return parseSorts(this.router.currentRoute?.queryParams?.["sort"]);
  }
  /**
  * Turns `sortable` into a per-column plugin option.
  *
  * `resizable` is not passed on, because the plugin leaves a column
  * it cannot resize out of sharing the container width,
  * and that column then overflows a smaller container.
  * Instead, `showsResizeHandle` decides where the handles go.
  */
  toConfig = column => {
    const pluginOptions = column.pluginOptions?.slice() ?? [];
    pluginOptions.push(DataSorting.forColumn(() => ({
      isSortable: column.sortable === true
    })));
    if (this.isResizable) {
      pluginOptions.push(ColumnResizing.forColumn(() => ({
        minWidth: MIN_COLUMN_WIDTH
      })));
    }
    return {
      ...column,
      pluginOptions
    };
  };
  showsResizeHandle = column => {
    const next = columns.next(column);
    return Boolean(layoutOf(column).resizable && next && layoutOf(next).resizable);
  };
  /**
  * The `sort` value a header links to.
  *
  * Ascending first, then it toggles.
  * There is no unsorted state, because a link never removes a query param.
  */
  nextSort = column => {
    const key = String(column.config.key);
    return sortDirection(column) === SortDirection.Ascending ? `-${key}` : key;
  };
  get isEmpty() {
    return this.args.data.length === 0;
  }
  static {
    setComponentTemplate(precompileTemplate("<div class=\"nvp__table\" {{this.table.modifiers.container}}>\n  <table class=\"nvp__table__table\" data-resizable={{this.isResizable}} ...attributes>\n    <caption class=\"nvp__table__caption\">{{@caption}}</caption>\n\n    <thead class=\"nvp__table__head\">\n      <tr>\n        {{#each this.table.columns as |column|}}\n          <th scope=\"col\" class=\"nvp__table__header-cell\" data-align={{alignOf column}} {{this.table.modifiers.columnHeader column}}>\n            {{#if (isSortable column)}}\n              <a class=\"nvp__table__sort\" data-sort={{sortDirection column}} href={{withQP \"sort\" (this.nextSort column)}}>\n                {{column.name}}\n                <span class=\"nvp__table__sort-icon\" aria-hidden=\"true\"></span>\n              </a>\n            {{else}}\n              {{column.name}}\n            {{/if}}\n\n            {{#if (this.showsResizeHandle column)}}\n              <button type=\"button\" class=\"nvp__table__resize-handle\" aria-label=\"Resize {{column.name}}\" {{resizeHandle column}}></button>\n            {{/if}}\n          </th>\n        {{/each}}\n      </tr>\n    </thead>\n\n    {{#unless this.isEmpty}}\n      <tbody class=\"nvp__table__body\">\n        {{#each this.table.rows as |row|}}\n          <tr class=\"nvp__table__row\" {{this.table.modifiers.row row}}>\n            {{#each this.table.columns as |column|}}\n              <td class=\"nvp__table__cell\" data-align={{alignOf column}} data-nowrap={{nowrapOf column}}>\n                {{#let (cellOf column) as |Cell|}}\n                  {{#if Cell}}\n                    <Cell @column={{column}} @row={{row}} />\n                  {{else}}\n                    {{column.getValueForRow row}}\n                  {{/if}}\n                {{/let}}\n              </td>\n            {{/each}}\n          </tr>\n        {{/each}}\n      </tbody>\n    {{/unless}}\n  </table>\n\n  {{#if this.isEmpty}}\n    <div class=\"nvp__table__empty\">\n      {{yield to=\"empty\"}}\n    </div>\n  {{/if}}\n\n  {{#if (has-block \"footer\")}}\n    <div class=\"nvp__table__footer\">\n      {{yield to=\"footer\"}}\n    </div>\n  {{/if}}\n</div>", {
      strictMode: true,
      scope: () => ({
        alignOf,
        isSortable,
        sortDirection,
        withQP,
        resizeHandle,
        nowrapOf,
        cellOf
      })
    }), this);
  }
}

export { Table };
//# sourceMappingURL=table.js.map
