import "./variables.css";
import "./avatar.css";
import "./avatar-group.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Size variant for all avatars in the group
     */
    size?: "small" | "medium" | "large";
  };
  Blocks: {
    /**
     * Avatar components to display in the group
     */
    default: [];
  };
}

export const AvatarGroup: TOC<Signature> = <template>
  <div class="nvp__avatar-group" data-size={{@size}} ...attributes>
    {{yield}}
  </div>
</template>;
