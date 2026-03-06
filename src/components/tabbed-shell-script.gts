import "./tabbed-shell-script.css";

import { on } from "@ember/modifier";

import { Tabs } from "./tabs.gts";

import type { TOC } from "@ember/component/template-only";

function copyToClipboard(text: string) {
  return () => {
    void navigator.clipboard.writeText(text);
  };
}

const CopyIcon: TOC<Record<string, never>> = <template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    height="1em"
    viewBox="0 0 448 512"
    fill="currentColor"
    aria-hidden="true"
  >
    {{! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. }}
    <path
      d="M208 0H332.1c12.7 0 24.9 5.1 33.9 14.1l67.9 67.9c9 9 14.1 21.2 14.1 33.9V336c0 26.5-21.5 48-48 48H208c-26.5 0-48-21.5-48-48V48c0-26.5 21.5-48 48-48zM48 128h80v64H64V448H256V416h64v48c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V176c0-26.5 21.5-48 48-48z"
    />
  </svg>
</template>;

export interface Signature {
  Element: HTMLDivElement;
  Args: {
    /**
     * The npm command to display.
     * e.g. `npm install my-package`
     */
    npm?: string;

    /**
     * The yarn command to display.
     * e.g. `yarn add my-package`
     */
    yarn?: string;

    /**
     * The pnpm command to display.
     * e.g. `pnpm add my-package`
     */
    pnpm?: string;

    /**
     * The bun command to display.
     * e.g. `bun add my-package`
     */
    bun?: string;
  };
}

export const TabbedShellScript: TOC<Signature> = <template>
  <div class="nvp__tabbed-shell-script" ...attributes>
    <Tabs as |Tab|>
      {{#if @npm}}
        <Tab>
          <:button>npm</:button>
          <:content>
            <div class="nvp__tabbed-shell-script__row">
              <pre>{{@npm}}</pre>
              <button
                type="button"
                class="nvp__tabbed-shell-script__copy"
                aria-label="Copy npm command"
                {{on "click" (copyToClipboard @npm)}}
              >
                <CopyIcon />
              </button>
            </div>
          </:content>
        </Tab>
      {{/if}}
      {{#if @yarn}}
        <Tab>
          <:button>yarn</:button>
          <:content>
            <div class="nvp__tabbed-shell-script__row">
              <pre>{{@yarn}}</pre>
              <button
                type="button"
                class="nvp__tabbed-shell-script__copy"
                aria-label="Copy yarn command"
                {{on "click" (copyToClipboard @yarn)}}
              >
                <CopyIcon />
              </button>
            </div>
          </:content>
        </Tab>
      {{/if}}
      {{#if @pnpm}}
        <Tab>
          <:button>pnpm</:button>
          <:content>
            <div class="nvp__tabbed-shell-script__row">
              <pre>{{@pnpm}}</pre>
              <button
                type="button"
                class="nvp__tabbed-shell-script__copy"
                aria-label="Copy pnpm command"
                {{on "click" (copyToClipboard @pnpm)}}
              >
                <CopyIcon />
              </button>
            </div>
          </:content>
        </Tab>
      {{/if}}
      {{#if @bun}}
        <Tab>
          <:button>bun</:button>
          <:content>
            <div class="nvp__tabbed-shell-script__row">
              <pre>{{@bun}}</pre>
              <button
                type="button"
                class="nvp__tabbed-shell-script__copy"
                aria-label="Copy bun command"
                {{on "click" (copyToClipboard @bun)}}
              >
                <CopyIcon />
              </button>
            </div>
          </:content>
        </Tab>
      {{/if}}
    </Tabs>
  </div>
</template>;
