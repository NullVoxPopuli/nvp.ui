# NavigationList

A navigation list is nothing more than a labelled `<ul>`: spaced link "chips"
with hover + current-page styling, and an uppercase group label when `@label`
is passed. You bring your own `<li>`s and links -- plain `<a>`, `<LinkTo>`, and
ember-primitives links all work.

Wrap one or more lists in [Navigation](/Docs/3-components/navigation) (or your
own `<nav>`) to form a navigation landmark -- this very docs site's sidebar is
`<Navigation>` + one `<NavigationList>` per group.

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
  <NavigationList @label="Get started">
    <li><Link @href="#intro">Intro</Link></li>
    <li><Link @href="#theme">Theme</Link></li>
    <li><Link @href="#surfaces">Surfaces</Link></li>
  </NavigationList>
  <NavigationList @label="Components">
    <li><Link @href="#button">Button</Link></li>
    <li><Link @href="#menu">Menu</Link></li>
    <li><Link @href="#timeline">Timeline</Link></li>
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

Consecutive lists space themselves apart, so several labelled lists stack into
a grouped nav -- no wrapper elements involved.

## Marking the current page

Give the current page's link an `aria-current` attribute -- that's both the
accessible way to convey "you are here" _and_ the styling hook. Links with an
`active` class are highlighted too, for link components that set one
(ember's `<LinkTo>`, ...).

```gjs live no-shadow
import { NavigationList } from "nvp.ui";

<template>
  <NavigationList aria-label="Demo: current page">
    <li><a href="#overview">Overview</a></li>
    <li><a href="#usage" aria-current="page">Usage</a></li>
    <li><a href="#api">API</a></li>
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
  <NavigationList @label="Group label">
    <li><a href="/somewhere">Link goes here</a></li>
  </NavigationList>
</template>
```

The component renders (at most) two sibling elements: the label `<span>` (only
when `@label` is passed) and the `<ul>`. Splattributes land on the `<ul>` --
the component _is_ the list.

## Accessibility

- `@label` is programmatically associated with the list via a unique id +
  `aria-labelledby`, so screen readers announce the list by its group name
  (e.g. "Get started, list, 3 items")
- the label is styled text, not a heading, so it never breaks the page's
  heading outline
- prefer `aria-current="page"` on the current link -- the visual highlight and
  the announced state then come from the same attribute
- a list is not a landmark: wrap lists in
  [Navigation](/Docs/3-components/navigation) (or your own `<nav>`) so
  assistive technology can jump to them

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

### CSS Custom Properties

|                Property                |                  Default                  | Description                           |
| :------------------------------------: | :---------------------------------------: | :------------------------------------ |
|    `--navigation-list-label-color`     |  `color-mix(… var(--color-text) 65% …)`   | Section label color                   |
|     `--navigation-list-link-color`     |  `color-mix(… var(--color-text) 78% …)`   | Resting link color                    |
|  `--navigation-list-hover-background`  |   `color-mix(… var(--color-text) 7% …)`   | Link hover background                 |
| `--navigation-list-current-background` | `color-mix(… var(--color-primary) 24% …)` | Current-page link background          |
|    `--navigation-list-section-gap`     |          `calc(12 * var(--gap))`          | Gap between consecutive lists         |
|     `--navigation-list-label-gap`      |              `var(--gap-4)`               | Gap between a label and its list      |
|      `--navigation-list-item-gap`      |         `calc(2.5 * var(--gap))`          | Gap between links                     |
|       `--navigation-list-indent`       |              `var(--gap-2)`               | List indentation under the label      |
|    `--navigation-list-item-padding`    |       derived from `--padding-1/2`        | Link padding (makes the hover "chip") |
|    `--navigation-list-item-radius`     |         `calc(2 * var(--radius))`         | Link corner radius                    |

### CSS Classes

|             Class              | Description                 |
| :----------------------------: | :-------------------------- |
|    `.nvp__navigation-list`     | The `<ul>`                  |
| `.nvp__navigation-list__label` | The uppercase section label |
