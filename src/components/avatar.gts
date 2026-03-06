import "./avatar.css";

import { Avatar as PrimitiveAvatar } from "ember-primitives/components/avatar";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * The URL of the avatar image.
     */
    src: string;

    /**
     * Alternative text for the image.
     */
    alt?: string;
  };
  Blocks: {
    /**
     * Fallback content to show when the image fails to load or while loading.
     * Commonly used for initials.
     */
    fallback: [];
  };
}

export const Avatar: TOC<Signature> = <template>
  <PrimitiveAvatar class="nvp__avatar" @src={{@src}} ...attributes as |a|>
    <a.Image alt={{if @alt @alt ""}} />
    <a.Fallback>
      <span class="nvp__avatar__fallback">
        {{yield to="fallback"}}
      </span>
    </a.Fallback>
  </PrimitiveAvatar>
</template>;
