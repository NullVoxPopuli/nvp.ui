import "./header.css"
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

const Header = setComponentTemplate(precompileTemplate("<header class=\"nvp__header surface elevation-xl2\" data-position={{@position}} ...attributes>\n  <span class=\"nvp__header__left\">\n    {{yield to=\"left\"}}\n  </span>\n  <span class=\"nvp__header__right\">\n    {{yield to=\"right\"}}\n  </span>\n</header>", {
  strictMode: true
}), templateOnly());

export { Header };
//# sourceMappingURL=header.js.map
