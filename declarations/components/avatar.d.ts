import "./avatar.css";
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
export declare const Avatar: TOC<AvatarSignature>;
export declare const AvatarGroup: TOC<AvatarGroupSignature>;
//# sourceMappingURL=avatar.d.ts.map