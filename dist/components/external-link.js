import "./external-link.css"
import { ExternalLink as ExternalLink$1 } from 'ember-primitives/components/external-link';
import { Arrow } from './-private/icons.js';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

const ExternalLink = setComponentTemplate(precompileTemplate("\n  <PrimitiveExternalLink class=\"preem__external-link\" ...attributes>\n    <span class=\"preem__external-link__link-content\">{{yield}}</span>\n    <Arrow />\n  </PrimitiveExternalLink>\n", {
  strictMode: true,
  scope: () => ({
    PrimitiveExternalLink: ExternalLink$1,
    Arrow
  })
}), templateOnly());

export { ExternalLink };
//# sourceMappingURL=external-link.js.map
