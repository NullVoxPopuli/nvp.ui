import "./header.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLElement;
  Args: {
    /**
     * Position of the header bar.
     *
     * - `"auto"` (default) -- sticks to the top, but moves to the
     *   bottom of tall or narrow containers (thumb-reachable,
     *   mobile-style), via container queries.
     * - `"top"` -- always sticks to the top.
     * - `"bottom"` -- always sticks to the bottom.
     *
     * "auto" queries the nearest size container: `<ApplicationShell>`
     * provides an inline-size container (so "narrow" applies there),
     * and inside a `container-type: size` element "tall" applies too.
     * Without any container ancestor, `@container` rules never match
     * (there is no viewport fallback for rules), so "auto" stays at
     * the top -- add a `container-type` to your layout root to opt in.
     *
     * The bottom placement pins via `position: sticky` + flex `order`,
     * so the header's parent should be a column flex (or grid) layout;
     * `<ApplicationShell>` provides one.
     */
    position?: "auto" | "top" | "bottom";
  };
  Blocks: {
    left: [];
    right: [];
  };
}

export const Header: TOC<Signature> = <template>
  <header
    class="nvp__header surface elevation-xl2"
    data-position={{if @position @position "auto"}}
    ...attributes
  >
    <span class="nvp__header__left">
      {{yield to="left"}}
    </span>
    <span class="nvp__header__right">
      {{yield to="right"}}
    </span>
  </header>
</template>;
