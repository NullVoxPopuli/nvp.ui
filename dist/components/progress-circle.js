import { Progress } from 'ember-primitives/components/progress';
import { precompileTemplate } from '@ember/template-compilation';
import { setComponentTemplate } from '@ember/component';
import templateOnly from '@ember/component/template-only';

// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck

const r = 60;
const size = Math.PI * 2 * r;
const toOffset = x => (100 - x) / 100 * size;
const ProgressCircle = setComponentTemplate(precompileTemplate("<Progress class=\"nvp_progress-circle\" @value={{@value}} ...attributes as |x|>\n  <x.Indicator class=\"nvp_progress\" />\n  <svg width=\"200\" height=\"200\" viewPort=\"0 0 100 100\">\n    <circle r={{r}} cx=\"100\" cy=\"100\" fill=\"transparent\" stroke-dasharray={{size}} stroke-dashoffset=\"0\"></circle>\n    <circle r={{r}} cx=\"100\" cy=\"100\" fill=\"transparent\" {{!-- template-lint-disable no-inline-styles style-concatenation --}} style=\"stroke: {{@color}}\" stroke-linecap=\"round\" stroke-dasharray={{size}} stroke-dashoffset=\"{{toOffset x.percent}}\"></circle>\n  </svg>\n  {{!-- template-lint-disable no-forbidden-elements --}}\n  <style>\n    .nvp_progress-circle {\n      .nvp_progress {\n        height: 200px;\n        width: 200px;\n        position: absolute;\n        text-align: center;\n      }\n\n      svg circle {\n        transition: stroke-dashoffset 0.5s linear;\n        stroke: #555;\n        stroke-width: 1rem;\n      }\n\n      .nvp_progress:after {\n        content: attr(data-percent) \"%\";\n        line-height: 200px;\n        font-size: 1.5rem;\n      }\n    }\n  </style>\n</Progress>", {
  strictMode: true,
  scope: () => ({
    Progress,
    r,
    size,
    toOffset
  })
}), templateOnly());

export { ProgressCircle };
//# sourceMappingURL=progress-circle.js.map
