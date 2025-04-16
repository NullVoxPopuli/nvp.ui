import './external-link.css';

import { ExternalLink as PrimitiveExternalLink } from 'ember-primitives/components/external-link';

import { Arrow } from './-private/icons.gts';

import type { TOC } from '@ember/component/template-only';

export interface Signature {
  Element: HTMLAnchorElement;
  Blocks: {
    default: [];
  };
}

export const ExternalLink: TOC<Signature> = <template>
  <PrimitiveExternalLink class='preem__external-link' ...attributes>
    <span class='preem__external-link__link-content'>{{yield}}</span>
    <Arrow />
  </PrimitiveExternalLink>
</template>;
