import "ember-mobile-menu/themes/android";
import "./application-shell.css";

import { on } from "@ember/modifier";
import { htmlSafe } from "@ember/template";

// @ts-expect-error no types for the mobile-menu
import MenuWrapper from "ember-mobile-menu/components/mobile-menu-wrapper";

import { Header } from "./header.gts";
import { Shell } from "./shell.gts";

import type { TOC } from "@ember/component/template-only";

function menuProgress(position: number) {
  return htmlSafe(`--menu-progress: ${position ?? 0}`);
}

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
    <MenuWrapper @embed={{true}} as |mmw|>
      <mmw.MobileMenu @mode="push" @maxWidth={{200}} as |mm|>
        {{! template-lint-disable no-invalid-interactive }}
        <div role="presentation" {{on "click" mm.actions.close}}>
          {{yield to="nav"}}
        </div>
      </mmw.MobileMenu>

      <mmw.Content>
        <Header>
          <:left>
            <mmw.Toggle>
              <span class="nvp__hamburger" style={{menuProgress mmw.relativePosition}}>
                <span class="nvp__hamburger__bar"></span>
                <span class="nvp__hamburger__bar"></span>
                <span class="nvp__hamburger__bar"></span>
              </span>
            </mmw.Toggle>
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
          <main class="nvp__application-shell__content">
            {{yield}}
          </main>
        </div>
      </mmw.Content>
    </MenuWrapper>
  </Shell>
</template>;
