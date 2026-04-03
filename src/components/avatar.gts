import "./avatar.css";

import { Avatar as PrimitiveAvatar } from "ember-primitives/components/avatar";

import type { TOC } from "@ember/component/template-only";

export interface AvatarSignature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * The image URL for the avatar
     */
    src: string;
    /**
     * Alt text for the avatar image (used for accessibility)
     */
    alt?: string;
    /**
     * Size variant
     */
    size?: "small" | "medium" | "large";
    /**
     * Milliseconds to wait before showing fallback content.
     * Prevents flashing for fast connections.
     */
    delayMs?: number;
  };
  Blocks: {
    /**
     * Content to show when the image fails to load or while loading.
     * Typically initials or an icon.
     */
    fallback: [];
  };
}

export interface AvatarGroupSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Size variant applied to the group layout spacing.
     * Individual avatars still need their own @size.
     */
    size?: "small" | "medium" | "large";
  };
  Blocks: {
    default: [];
  };
}

const or = (a: unknown, b: unknown) => a || b;
const orNum = (a: number | undefined, b: number): number => a ?? b;

export const Avatar: TOC<AvatarSignature> = <template>
  <PrimitiveAvatar
    class="nvp__avatar"
    data-size={{or @size "medium"}}
    @src={{@src}}
    ...attributes
    as |avatar|
  >
    <avatar.Image alt={{@alt}} />
    <avatar.Fallback @delayMs={{orNum @delayMs 200}}>
      {{#if (has-block "fallback")}}
        {{yield to="fallback"}}
      {{else}}
        <svg viewBox="0 0 24 24" fill="currentColor" width="60%" height="60%" aria-hidden="true">
          <path d="M12 12c2.7 0 4.8-2.1 4.8-4.8S14.7 2.4 12 2.4 7.2 4.5 7.2 7.2 9.3 12 12 12zm0 2.4c-3.2 0-9.6 1.6-9.6 4.8v2.4h19.2v-2.4c0-3.2-6.4-4.8-9.6-4.8z" />
        </svg>
      {{/if}}
    </avatar.Fallback>
  </PrimitiveAvatar>
</template>;

export const AvatarGroup: TOC<AvatarGroupSignature> = <template>
  <div class="nvp__avatar-group" data-size={{or @size "medium"}} role="group" ...attributes>
    {{yield}}
  </div>
</template>;
