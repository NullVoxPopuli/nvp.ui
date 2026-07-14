# Navigation

The navigation landmark: a `<nav>` that owns its own layout and responsiveness,
independent of what renders it. Its content is typically one or more
[NavigationList](/Docs/3-components/navigation-list)s -- this very docs site's
sidebar (and its mobile tray) is a `<Navigation>` built from kolay's docs
manifest, with kolay providing only data.

```gjs live no-shadow
import { Navigation, NavigationList } from "nvp.ui";

<template>
  <Navigation aria-label="Demo: documentation">
    <NavigationList @label="Get started">
      <li><a href="#intro" aria-current="page">Intro</a></li>
      <li><a href="#theme">Theme</a></li>
    </NavigationList>
    <NavigationList @label="Components">
      <li><a href="#button">Button</a></li>
      <li><a href="#menu">Menu</a></li>
    </NavigationList>
  </Navigation>

  <style>
    @scope {
      .nvp__navigation {
        max-width: 16rem;
        border: var(--border-width) var(--border-style) var(--border-color);
        border-radius: calc(2 * var(--radius));
      }
    }
  </style>
</template>
```

## Responsiveness

`<Navigation>` is sticky and scrolls its own overflow, so long navs never push
the page around:

- it sticks `--navigation-top` below the viewport top (default `0px`), and
  caps its height at the remaining viewport
- inside a size container (like `<ApplicationShell>`), it keeps
  `--navigation-min-width` (default `14rem`) on wide containers, and tightens
  its padding on narrow ones (like the shell's mobile tray)

## Working with ApplicationShell

The [ApplicationShell](/Docs/3-components/application-shell) decides _where_
navigation appears: the sidebar column on wide viewports, the mobile tray +
hamburger on narrow ones. It also sets `--navigation-top` to its sticky
header's height, so a `<Navigation>` placed in the `<:nav>` block sticks just
below the header.

`<Navigation>` owns everything about its own box -- stickiness, overflow,
padding, width -- and the shell does not style the nav's contents at all.

```gjs
<ApplicationShell>
  <:nav>
    <Navigation aria-label="Documentation">
      <NavigationList @label="Get started">
        ...
      </NavigationList>
    </Navigation>
  </:nav>
  ...
</ApplicationShell>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- renders a real `<nav>`, so assistive technology announces it as a
  navigation landmark
- pass an `aria-label` whenever a page has more than one `<nav>`

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/navigation" @name="Signature" />
</template>
```

### CSS Custom Properties

|           Property            |                Default                | Description                                            |
| :---------------------------: | :-----------------------------------: | :----------------------------------------------------- |
|      `--navigation-top`       |                 `0px`                 | Sticky offset from the viewport top (set by the shell) |
|    `--navigation-padding`     | `1.5rem 1rem 2rem 1.25rem` (via gaps) | Padding on wide containers                             |
| `--navigation-padding-narrow` |     `1.25rem 0.75rem` (via gaps)      | Padding on narrow containers (e.g. the mobile tray)    |
|   `--navigation-min-width`    |                `14rem`                | Minimum width on wide containers                       |

### CSS Classes

|       Class        | Description |
| :----------------: | :---------- |
| `.nvp__navigation` | The `<nav>` |
