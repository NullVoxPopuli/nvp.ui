# NavigationList

A styled container for navigation lists -- sidebars, docs navs, tables of contents.
It provides the list structure (spacing, uppercase section labels) and the link
styling ("chip" hover + current-page highlight), while you bring your own links:
plain `<a>`, `<LinkTo>`, ember-primitives links, and generated navs all work.

This very docs site's sidebar is a `NavigationList`.

```gjs live no-shadow
import { NavigationList } from "nvp.ui";
import { cell } from "ember-resources";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";

const current = cell("#intro");
const ariaCurrent = (href) => (current.current === href ? "page" : undefined);
const goTo = (href, event) => {
  event.preventDefault();
  current.set(href);
};

const Link = <template>
  <a href={{@href}} aria-current={{ariaCurrent @href}} {{on "click" (fn goTo @href)}}>{{yield}}</a>
</template>;

<template>
  <NavigationList aria-label="Demo: documentation" as |l|>
    <l.Section @label="Get started" as |s|>
      <s.Item><Link @href="#intro">Intro</Link></s.Item>
      <s.Item><Link @href="#theme">Theme</Link></s.Item>
      <s.Item><Link @href="#surfaces">Surfaces</Link></s.Item>
    </l.Section>
    <l.Section @label="Components" as |s|>
      <s.Item><Link @href="#button">Button</Link></s.Item>
      <s.Item><Link @href="#menu">Menu</Link></s.Item>
      <s.Item><Link @href="#timeline">Timeline</Link></s.Item>
    </l.Section>
  </NavigationList>

  <style>
    @scope {
      .nvp__navigation-list {
        max-width: 14rem;
      }
    }
  </style>
</template>
```

## Marking the current page

Give the current page's link an `aria-current` attribute -- that's both the
accessible way to convey "you are here" _and_ the styling hook. Links with an
`active` class are highlighted too, for link components that set one
(ember's `<LinkTo>`, kolay's `PageNav`, ...).

```gjs live no-shadow
import { NavigationList } from "nvp.ui";

<template>
  <NavigationList aria-label="Demo: current page" as |l|>
    <l.Section as |s|>
      <s.Item><a href="#overview">Overview</a></s.Item>
      <s.Item><a href="#usage" aria-current="page">Usage</a></s.Item>
      <s.Item><a href="#api">API</a></s.Item>
    </l.Section>
  </NavigationList>

  <style>
    @scope {
      .nvp__navigation-list {
        max-width: 14rem;
      }
    }
  </style>
</template>
```

## Bring your own nav

Some tools render a whole `<nav>` for you (this site's sidebar uses
[kolay](https://github.com/NullVoxPopuli/kolay)'s `PageNav`, which generates the
nav from the docs' folder structure). Rendering a second `<nav>` around that
would create a nested navigation landmark, so the `<:nav>` block renders a
plain styling container instead. Text (or a link) directly inside a top-level
`<li>` gets the section-label treatment.

```gjs live no-shadow
import { NavigationList } from "nvp.ui";

<template>
  <NavigationList>
    <:nav>
      <nav aria-label="Demo: bring your own nav">
        <ul>
          <li>
            Generated group
            <ul>
              <li><a href="#one" class="active">Page one</a></li>
              <li><a href="#two">Page two</a></li>
            </ul>
          </li>
        </ul>
      </nav>
    </:nav>
  </NavigationList>

  <style>
    @scope {
      .nvp__navigation-list {
        max-width: 14rem;
      }
    }
  </style>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Anatomy

```gjs
import { NavigationList } from "nvp.ui/navigation-list";

<template>
  <NavigationList aria-label="Documentation" as |l|>
    <l.Section @label="Group label" as |s|>
      <s.Item><a href="/somewhere">Link goes here</a></s.Item>
    </l.Section>
  </NavigationList>
</template>
```

`Section` groups links under an optional uppercase label; `Item` is the `<li>`
wrapper for a single entry. The link element itself is always yours.

## Accessibility

- the component renders a real `<nav>` + `<ul>`/`<li>` structure, so assistive
  technology announces it as a navigation landmark containing lists
- pass an `aria-label` whenever a page has more than one `<nav>`
- section labels are styled text, not headings, so they never break the page's
  heading outline
- prefer `aria-current="page"` on the current link -- the visual highlight and
  the announced state then come from the same attribute
- the `<:nav>` block exists so that content which already renders a `<nav>`
  isn't wrapped in a second, nested navigation landmark

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/navigation-list"
    @name="Signature"
  />
</template>
```

### Section (yielded)

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/navigation-list"
    @name="SectionSignature"
  />
</template>
```

### Item (yielded)

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/navigation-list"
    @name="ItemSignature"
  />
</template>
```

### CSS Custom Properties

|                Property                |                  Default                  | Description                           |
| :------------------------------------: | :---------------------------------------: | :------------------------------------ |
|    `--navigation-list-label-color`     |  `color-mix(… var(--color-text) 65% …)`   | Section label color                   |
|     `--navigation-list-link-color`     |  `color-mix(… var(--color-text) 78% …)`   | Resting link color                    |
|  `--navigation-list-hover-background`  |   `color-mix(… var(--color-text) 7% …)`   | Link hover background                 |
| `--navigation-list-current-background` | `color-mix(… var(--color-primary) 24% …)` | Current-page link background          |
|    `--navigation-list-section-gap`     |          `calc(6 * var(--gap))`           | Gap between sections                  |
|     `--navigation-list-label-gap`      |              `var(--gap-2)`               | Gap between a label and its links     |
|      `--navigation-list-item-gap`      |                   `0px`                   | Extra gap between links               |
|    `--navigation-list-item-padding`    |       derived from `--padding-1/2`        | Link padding (makes the hover "chip") |
|    `--navigation-list-item-radius`     |         `calc(2 * var(--radius))`         | Link corner radius                    |

### CSS Classes

|              Class               | Description                             |
| :------------------------------: | :-------------------------------------- |
|     `.nvp__navigation-list`      | The `<nav>` (or the `<:nav>` container) |
| `.nvp__navigation-list__section` | One group of links                      |
|  `.nvp__navigation-list__label`  | The uppercase section label             |
|  `.nvp__navigation-list__item`   | The `<li>` around each link             |
