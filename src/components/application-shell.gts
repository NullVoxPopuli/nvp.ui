import "ember-mobile-menu/themes/android";
import "./application-shell.css";

import { on } from "@ember/modifier";

// @ts-expect-error no types for the mobile-menu
import MenuWrapper from "ember-mobile-menu/components/mobile-menu-wrapper";

import { Header } from "./header.gts";
import { Shell } from "./shell.gts";

import type { TOC } from "@ember/component/template-only";

const MenuIcon: TOC<{ Element: SVGElement }> = <template>
  <svg
    class="nvp__application-shell__menu-icon"
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 50 50"
    ...attributes
  ><path
      d="M 0 7.5 L 0 12.5 L 50 12.5 L 50 7.5 Z M 0 22.5 L 0 27.5 L 50 27.5 L 50 22.5 Z M 0 37.5 L 0 42.5 L 50 42.5 L 50 37.5 Z"
    ></path></svg>
</template>;

export interface ApplicationShellSignature {
  Element: HTMLDivElement;
  Blocks: {
    headerLeft: [];
    headerRight: [];
    nav: [];
    default: [];
  };
}

export const ApplicationShell: TOC<ApplicationShellSignature> = <template>
  <Shell>
    <MenuWrapper as |mmw|>
      <mmw.MobileMenu @mode="push" @maxWidth={{200}} as |mm|>
        {{! template-lint-disable no-invalid-interactive }}
        <div role="presentation" {{on "click" mm.actions.close}}>
          {{yield to="nav"}}
        </div>
      </mmw.MobileMenu>

      <mmw.Content>
        <Header>
          <:left>
            <mmw.Toggle><MenuIcon /></mmw.Toggle>
            {{yield to="headerLeft"}}
          </:left>
          <:right>
            {{yield to="headerRight"}}
          </:right>
        </Header>

        <div class="nvp__application-shell__layout">
          <div class="nvp__application-shell__sidebar">
            {{yield to="nav"}}
          </div>
          <main>
            {{yield}}
          </main>
        </div>
      </mmw.Content>
    </MenuWrapper>
  </Shell>
</template>;
