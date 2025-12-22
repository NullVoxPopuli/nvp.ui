import "./header.css"
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

const Header = setComponentTemplate(precompileTemplate("\n  <header class=\"preem__header\">\n    <span class=\"preem__header__left\">\n      {{yield to=\"left\"}}\n    </span>\n    <span class=\"preem__header__right\">\n      {{yield to=\"right\"}}\n    </span>\n  </header>\n", {
  strictMode: true
}), templateOnly());

export { Header };
//# sourceMappingURL=header.js.map
