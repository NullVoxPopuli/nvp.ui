import "./variables.css";
import "./avatar.css";

import { Avatar as PrimitiveAvatar } from "ember-primitives/components/avatar";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * The `src` value for the image.
     */
    src: string;
    /**
     * Alt text for the image. Required for accessibility.
     */
    alt?: string;
    /**
     * Optional size variant for the avatar
     */
    size?: "small" | "medium" | "large";
  };
  Blocks: {
    /**
     * Fallback content to display when image fails to load or while loading
     */
    fallback?: [];
  };
}

export const Avatar: TOC<Signature> = <template>
  <PrimitiveAvatar
    @src={{@src}}
    class="nvp__avatar"
    data-size={{@size}}
    ...attributes
    as |avatar|
  >
    <avatar.Image alt={{@alt}} />
    <avatar.Fallback @delayMs={{200}}>
      {{#if (has-block "fallback")}}
        {{yield to="fallback"}}
      {{else}}
        <span class="nvp__avatar__fallback">?</span>
      {{/if}}
    </avatar.Fallback>
  </PrimitiveAvatar>
</template>;
