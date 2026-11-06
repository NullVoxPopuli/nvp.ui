import "./file-drop.css"
import '../variables-goOgJf2v.js';
import '../focus-C7z7jBjO.js';
import { FileDrop as FileDrop$1 } from 'ember-primitives/components/file-drop';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

;

/**
 * A styled `FileDrop` from ember-primitives, with default text.
 */
const FileDrop = setComponentTemplate(precompileTemplate("<PrimitiveFileDrop class=\"nvp__file-drop\" @onFiles={{@onFiles}} @accept={{@accept}} @multiple={{@multiple}} ...attributes as |zone|>\n  {{#if (has-block)}}\n    {{yield zone}}\n  {{else}}\n    <span class=\"nvp__file-drop__text\">Drop a file here, or click to choose one</span>\n  {{/if}}\n</PrimitiveFileDrop>", {
  strictMode: true,
  scope: () => ({
    PrimitiveFileDrop: FileDrop$1
  })
}), templateOnly());

export { FileDrop };
//# sourceMappingURL=file-drop.js.map
