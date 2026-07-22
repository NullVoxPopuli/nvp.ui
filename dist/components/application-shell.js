import "./application-shell.css"
import 'ember-mobile-menu/themes/android';
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import MenuWrapper from 'ember-mobile-menu/components/mobile-menu-wrapper';
import { Header } from './header.js';
import { Shell } from './shell.js';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

function menuProgress(position) {
  return htmlSafe(`--menu-progress: ${position ?? 0}`);
}
const ApplicationShell = setComponentTemplate(precompileTemplate("<Shell>\n  <MenuWrapper @embed={{true}} as |mmw|>\n    <mmw.MobileMenu @mode=\"push\" @maxWidth={{200}} as |mm|>\n      {{!-- template-lint-disable no-invalid-interactive --}}\n      <div role=\"presentation\" {{on \"click\" mm.actions.close}}>\n        {{yield to=\"nav\"}}\n      </div>\n    </mmw.MobileMenu>\n\n    <mmw.Content>\n      <Header>\n        <:left>\n          <mmw.Toggle>\n            <span class=\"nvp__hamburger\" style={{menuProgress mmw.relativePosition}}>\n              <span class=\"nvp__hamburger__bar\"></span>\n              <span class=\"nvp__hamburger__bar\"></span>\n              <span class=\"nvp__hamburger__bar\"></span>\n            </span>\n          </mmw.Toggle>\n          {{yield to=\"headerLeft\"}}\n        </:left>\n        <:right>\n          {{yield to=\"headerRight\"}}\n        </:right>\n      </Header>\n\n      <div class=\"nvp__application-shell__layout\">\n        <div class=\"nvp__application-shell__sidebar\">\n          {{yield to=\"nav\"}}\n        </div>\n        <main class=\"nvp__application-shell__content\">\n          {{yield}}\n        </main>\n      </div>\n    </mmw.Content>\n  </MenuWrapper>\n</Shell>", {
  strictMode: true,
  scope: () => ({
    Shell,
    MenuWrapper,
    on,
    Header,
    menuProgress
  })
}), templateOnly());

export { ApplicationShell };
//# sourceMappingURL=application-shell.js.map
