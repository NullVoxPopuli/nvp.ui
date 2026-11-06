/**
 * Type tests for `<TabbedShellScript>`.
 *
 * `pnpm lint:types` checks this file. Nothing runs it.
 */
import { TabbedShellScript } from "../src/components/tabbed-shell-script.gts";

const scripts = [{ label: "pnpm", script: "pnpm add nvp.ui" }];

export const valid = <template>
  <TabbedShellScript @scripts={{scripts}} />

  <TabbedShellScript as |Tab|>
    <Tab @label="pnpm" @script="pnpm add nvp.ui" />
  </TabbedShellScript>
</template>;

export const invalid = <template>
  {{! @glint-expect-error: each item needs a script }}
  <TabbedShellScript @scripts={{Array.of (hash label="pnpm")}} />

  <TabbedShellScript as |Tab|>
    {{! @glint-expect-error: a tab needs a @script }}
    <Tab @label="pnpm" />
  </TabbedShellScript>
</template>;
