import "./variables.css";
import "./browser-window.css";

import type { TOC } from "@ember/component/template-only";

export interface Signature {
  Element: HTMLDivElement;
  Args: {
    /**
     * The URL to display in the address bar
     * If not provided, no address bar will be shown
     */
    url?: string;
    /**
     * Whether to show the browser chrome (buttons and address bar)
     * @default true
     */
    showChrome?: boolean;
  };
  Blocks: {
    /**
     * Content to display inside the browser window
     */
    default: [];
  };
}

const shouldShowChrome = (showChrome: boolean | undefined) => showChrome !== false;

export const BrowserWindow: TOC<Signature> = <template>
  <div class="nvp__browser-window" ...attributes>
    {{#if (shouldShowChrome @showChrome)}}
      <div class="nvp__browser-window__chrome">
        <div class="nvp__browser-window__buttons">
          <div
            class="nvp__browser-window__button nvp__browser-window__button--close"
            aria-hidden="true"
          ></div>
          <div
            class="nvp__browser-window__button nvp__browser-window__button--minimize"
            aria-hidden="true"
          ></div>
          <div
            class="nvp__browser-window__button nvp__browser-window__button--maximize"
            aria-hidden="true"
          ></div>
        </div>
        {{#if @url}}
          <div class="nvp__browser-window__address-bar">
            {{@url}}
          </div>
        {{/if}}
      </div>
    {{/if}}
    <div class="nvp__browser-window__content">
      {{yield}}
    </div>
  </div>
</template>;
