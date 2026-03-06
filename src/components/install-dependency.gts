import { TabbedShellScript } from "./tabbed-shell-script.gts";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLDivElement;
  Args: {
    /**
     * The package name to install.
     * e.g. `my-package`
     */
    package: string;

    /**
     * Optional: override the npm install command.
     * Defaults to `npm install <package>`
     */
    npm?: string;

    /**
     * Optional: override the yarn add command.
     * Defaults to `yarn add <package>`
     */
    yarn?: string;

    /**
     * Optional: override the pnpm add command.
     * Defaults to `pnpm add <package>`
     */
    pnpm?: string;

    /**
     * Optional: override the bun add command.
     * Defaults to `bun add <package>`
     */
    bun?: string;
  };
}

function npmCmd(pkg: string) {
  return `npm install ${pkg}`;
}

function yarnCmd(pkg: string) {
  return `yarn add ${pkg}`;
}

function pnpmCmd(pkg: string) {
  return `pnpm add ${pkg}`;
}

function bunCmd(pkg: string) {
  return `bun add ${pkg}`;
}

export const InstallDependency: TOC<Signature> = <template>
  <TabbedShellScript
    @npm={{if @npm @npm (npmCmd @package)}}
    @yarn={{if @yarn @yarn (yarnCmd @package)}}
    @pnpm={{if @pnpm @pnpm (pnpmCmd @package)}}
    @bun={{if @bun @bun (bunCmd @package)}}
    ...attributes
  />
</template>;
