import "../docs.css";

import { pascalCase, sentenceCase } from "change-case";
import { pageTitle } from "ember-page-title";
import Route from "ember-route-template";
import { PageNav } from "kolay/components";

import { ApplicationShell, ExternalLink, ThemeToggle } from "#src/index.ts";
import { abbreviatedSha } from "~build/git";

import type { TOC } from "@ember/component/template-only";
import type { Page } from "kolay";

const SideNav: TOC<{ Element: HTMLElement }> = <template>
  <aside class="docs-nav">
    <PageNav ...attributes>
      <:page as |x|>
        <x.Link>
          {{nameFor x.page}}
        </x.Link>
      </:page>
      <:collection as |x|>
        {{#if x.index}}
          <x.index.Link>
            {{groupName x.collection.name}}
          </x.index.Link>
        {{else}}
          {{groupName x.collection.name}}
        {{/if}}
      </:collection>
    </PageNav>

    <p class="docs-nav__meta">
      Built from
      <a href="https://github.com/NullVoxPopuli/nvp.ui/commit/{{abbreviatedSha}}">
        {{abbreviatedSha}}
      </a>
    </p>
  </aside>
</template>;

export default Route(
  <template>
    {{pageTitle "nvp.ui"}}

    <div class="app-root">
      <ApplicationShell>
        <:headerLeft>
          <a class="docs-brand" href="/">nvp.ui</a>
        </:headerLeft>
        <:headerRight>
          <ExternalLink href="https://github.com/NullVoxPopuli/nvp.ui">GitHub</ExternalLink>
          <ThemeToggle />
        </:headerRight>
        <:nav>
          <SideNav />
        </:nav>
        <:default>
          {{outlet}}
        </:default>
      </ApplicationShell>
    </div>

    <style>
      .app-root {
        height: 100dvh;
      }
    </style>
  </template>,
);

/**
 * Collection directories are prefixed with a number to control
 * their order (e.g. "1-get-started") -- that prefix is not part
 * of the display name.
 */
function groupName(name: string) {
  return sentenceCase(name.replace(/^\d+[-_.\s]*/, ""));
}

function nameFor(x: Page) {
  // We defined componentName via json file

  if ("componentName" in x) {
    return `${x.componentName as string}`;
  }

  if (x.path.includes("/components/")) {
    return `<${pascalCase(x.name)} />`;
  }

  return sentenceCase(x.name);
}
