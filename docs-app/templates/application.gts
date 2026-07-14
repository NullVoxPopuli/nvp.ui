import "../docs.css";

import Component from "@glimmer/component";
import { service } from "@ember/service";

import { pascalCase, sentenceCase } from "change-case";
import { pageTitle } from "ember-page-title";
import Route from "ember-route-template";
import { docsManager, isCollection, isIndex } from "kolay";

import { ApplicationShell, ExternalLink, NavigationList, ThemeToggle } from "#src/index.ts";
import { abbreviatedSha } from "~build/git";

import type RouterService from "@ember/routing/router-service";
import type { Collection, Page } from "kolay";

/**
 * The sidebar composes <NavigationList> directly from kolay's
 * docs manifest: one Section per collection, one entry per page.
 */
class SideNav extends Component<{ Element: HTMLElement }> {
  @service declare router: RouterService;

  get docs() {
    return docsManager(this);
  }

  get groups(): Collection[] {
    const tree = this.docs.tree;

    if (!("pages" in tree)) return [];

    return tree.pages.filter((page) => isCollection(page));
  }

  isCurrent = (page: Page) => {
    if (page.path === "/") return false;

    return this.router.currentURL?.startsWith(page.path) ?? false;
  };

  <template>
    <aside class="docs-nav">
      <NavigationList aria-label="Documentation" ...attributes as |list|>
        {{#each this.groups as |group|}}
          <list.Section @label={{groupName group.name}}>
            {{#each (pagesOf group) as |page|}}
              <li>
                <a href={{page.path}} aria-current={{if (this.isCurrent page) "page"}}>
                  {{nameFor page}}
                </a>
              </li>
            {{/each}}
          </list.Section>
        {{/each}}
      </NavigationList>

      <p class="docs-nav__meta">
        Built from
        <a href="https://github.com/NullVoxPopuli/nvp.ui/commit/{{abbreviatedSha}}">
          {{abbreviatedSha}}
        </a>
      </p>
    </aside>
  </template>
}

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

function pagesOf(group: Collection): Page[] {
  return group.pages.filter((page): page is Page => !isCollection(page) && !isIndex(page));
}

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
