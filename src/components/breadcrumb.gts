import "./breadcrumb.css";

import { Breadcrumb as PrimitiveBreadcrumb } from "ember-primitives/components/breadcrumb";

import type { TOC } from "@ember/component/template-only";
import type { WithBoundArgs } from "@glint/template";

const Separator: TOC<{ Element: HTMLSpanElement; Blocks: { default: [] } }> = <template>
  <span class="nvp__breadcrumb__separator" aria-hidden="true">
    {{yield}}
  </span>
</template>;

export interface Signature {
  Element: HTMLElement;
  Args: {
    /**
     * The accessible label for the breadcrumb navigation.
     * Defaults to "Breadcrumb"
     */
    label?: string;
  };
  Blocks: {
    default: [
      {
        /**
         * A separator to place between breadcrumb items.
         * Defaults to rendering "/" when no content is provided.
         */
        Separator: WithBoundArgs<typeof Separator, never>;
      },
    ];
  };
}

export const Breadcrumb: TOC<Signature> = <template>
  <div class="nvp__breadcrumb">
    <PrimitiveBreadcrumb @label={{@label}} ...attributes>
      {{yield (object Separator=(component Separator))}}
    </PrimitiveBreadcrumb>
  </div>
</template>;

function object<T extends object>(obj: T): T {
  return obj;
}
