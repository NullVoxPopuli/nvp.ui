import { pascalCase, sentenceCase } from "change-case";
import { pageTitle } from "ember-page-title";
import Route from "ember-route-template";
import { PageNav } from "kolay/components";

import { ApplicationShell, ExternalLink, ThemeToggle } from "#src/index.ts";
import { abbreviatedSha } from "~build/git";

import type { TOC } from "@ember/component/template-only";
import type { Page } from "kolay";

const SideNav: TOC<{ Element: HTMLElement }> = <template>
  <aside>
    <PageNav ...attributes>
      <:page as |x|>
        <x.Link>
          {{nameFor x.page}}
        </x.Link>
      </:page>
      <:collection as |x|>
        {{#if x.index}}
          <x.index.Link>
            {{sentenceCase x.collection.name}}
          </x.index.Link>
        {{else}}
          {{sentenceCase x.collection.name}}
        {{/if}}
      </:collection>
    </PageNav>
  </aside>
</template>;

export default Route(
  <template>
    {{pageTitle "Docs :: " abbreviatedSha}}

    <ApplicationShell>
      <:headerLeft>
        <a href="/">nvp.ui</a>
      </:headerLeft>
      <:headerRight>
        <ExternalLink href="https://github.com/NullVoxPopuli/nullui">GitHub</ExternalLink>
        <ThemeToggle />
      </:headerRight>
      <:nav>
        <SideNav />
      </:nav>
      <:default>
        {{outlet}}
      </:default>
    </ApplicationShell>
  </template>,
);

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
