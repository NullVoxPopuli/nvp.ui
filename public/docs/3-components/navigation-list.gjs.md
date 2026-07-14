# NavigationList

A styled navigation list -- for sidebars, docs navs, tables of contents.
It provides the list structure (spacing, uppercase section labels) and the link
styling ("chip" hover + current-page highlight), while you bring your own links:
plain `<a>`, `<LinkTo>`, and ember-primitives links all work.

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
    <l.Section @label="Get started">
      <li><Link @href="#intro">Intro</Link></li>
      <li><Link @href="#theme">Theme</Link></li>
      <li><Link @href="#surfaces">Surfaces</Link></li>
    </l.Section>
    <l.Section @label="Components">
      <li><Link @href="#button">Button</Link></li>
      <li><Link @href="#menu">Menu</Link></li>
      <li><Link @href="#timeline">Timeline</Link></li>
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
(ember's `<LinkTo>`, ...).

```gjs live no-shadow
import { NavigationList } from "nvp.ui";

<template>
  <NavigationList aria-label="Demo: current page" as |l|>
    <l.Section>
      <li><a href="#overview">Overview</a></li>
      <li><a href="#usage" aria-current="page">Usage</a></li>
      <li><a href="#api">API</a></li>
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

## Installation

```bash
pnpm add nvp.ui
```

## Anatomy

```gjs
import { NavigationList } from "nvp.ui/navigation-list";

<template>
  <NavigationList aria-label="Documentation" as |l|>
    <l.Section @label="Group label">
      <li><a href="/somewhere">Link goes here</a></li>
    </l.Section>
  </NavigationList>
</template>
```

`Section` renders one `<ul>` of links under an optional uppercase label. Its
children are plain `<li>` elements that you render yourself -- the stylesheet
targets the direct-descendant `li`s and the links inside them, so the link
element is always yours.

## Accessibility

- the component renders a real `<nav>` + `<ul>`/`<li>` structure, so assistive
  technology announces it as a navigation landmark containing lists
- pass an `aria-label` whenever a page has more than one `<nav>`
- a section's `@label` is programmatically associated with its list via
  `aria-labelledby`, so screen readers announce the list by its group name
  (e.g. "Get started, list, 3 items")
- labels are styled text, not headings, so they never break the page's
  heading outline
- prefer `aria-current="page"` on the current link -- the visual highlight and
  the announced state then come from the same attribute

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

### CSS Custom Properties

|                Property                |                  Default                  | Description                           |
| :------------------------------------: | :---------------------------------------: | :------------------------------------ |
|    `--navigation-list-label-color`     |  `color-mix(… var(--color-text) 65% …)`   | Section label color                   |
|     `--navigation-list-link-color`     |  `color-mix(… var(--color-text) 78% …)`   | Resting link color                    |
|  `--navigation-list-hover-background`  |   `color-mix(… var(--color-text) 7% …)`   | Link hover background                 |
| `--navigation-list-current-background` | `color-mix(… var(--color-primary) 24% …)` | Current-page link background          |
|    `--navigation-list-section-gap`     |          `calc(12 * var(--gap))`          | Gap between sections                  |
|     `--navigation-list-label-gap`      |              `var(--gap-4)`               | Gap between a label and its links     |
|      `--navigation-list-item-gap`      |         `calc(2.5 * var(--gap))`          | Gap between links                     |
|       `--navigation-list-indent`       |              `var(--gap-2)`               | List indentation under the label      |
|    `--navigation-list-item-padding`    |       derived from `--padding-1/2`        | Link padding (makes the hover "chip") |
|    `--navigation-list-item-radius`     |         `calc(2 * var(--radius))`         | Link corner radius                    |

### CSS Classes

|              Class               | Description                   |
| :------------------------------: | :---------------------------- |
|     `.nvp__navigation-list`      | The `<nav>`                   |
| `.nvp__navigation-list__section` | One group of links (a `<ul>`) |
|  `.nvp__navigation-list__label`  | The uppercase section label   |
