# ApplicationShell

A full application layout that combines theme management, a sticky header, a responsive sidebar, mobile menu support, and a main content area into a single component.

Internally includes [`Shell`](/Docs/3-components/theme-toggle) (theme sync), [`Header`](/Docs/3-components/header), and a push-style mobile menu (via [ember-mobile-menu](https://github.com/nickschot/ember-mobile-menu)).

```gjs live no-shadow
import { ApplicationShell } from "nvp.ui";

<template>
  <div class="demo-container">
    <ApplicationShell>
      <:headerLeft>
        <a href="/">My App</a>
      </:headerLeft>
      <:headerRight>
        <a href="/about">About</a>
        <a href="/docs">Docs</a>
      </:headerRight>
      <:nav>
        <nav>
          <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/getting-started">Getting Started</a></li>
            <li><a href="/components">Components</a></li>
            <li><a href="/guides">Guides</a></li>
          </ul>
        </nav>
      </:nav>
      <:default>
        <p>Main content goes here. The sidebar is visible on desktop and collapses into a hamburger
          menu on mobile.</p>
        <p>Drag the resize handle on the right edge below 768px to see the hamburger menu appear.</p>
      </:default>
    </ApplicationShell>
  </div>

  <style>
    @scope {
      .demo-container {
        height: 20rem;
        width: 100%;
        min-width: 20rem;
        overflow: auto;
        resize: horizontal;
        border: 1px solid light-dark(rgba(0, 0, 0, 0.15), rgba(255, 255, 255, 0.1));
        border-radius: 0.5rem;
      }
    }
  </style>
</template>
```

## Named Blocks

The component exposes four named blocks:

| Block          | Description                                                                          |
| :------------- | :----------------------------------------------------------------------------------- |
| `:headerLeft`  | Left side of the header — rendered after the hamburger toggle                        |
| `:headerRight` | Right side of the header — typically links, theme toggle, etc.                       |
| `:nav`         | Sidebar navigation — rendered both in the desktop sidebar and the mobile menu drawer |
| `:default`     | Main content area                                                                    |

## What's included

ApplicationShell handles all of the following so you don't have to:

- **Theme syncing** — `Shell` is included, which reads the user's color scheme preference and syncs `theme-light` / `theme-dark` classes on `<body>`
- **Sticky header** — `Header` is included with `:left` and `:right` slots wired to `:headerLeft` and `:headerRight`
- **Mobile menu** — A push-style drawer (via `ember-mobile-menu`) that shows the `:nav` content on small screens. Tapping a nav item closes the drawer automatically.
- **Hamburger toggle** — Automatically shown in the header on screens below 768px, hidden on desktop
- **Responsive grid** — Sidebar + main content in a CSS grid. The sidebar hides below 768px (use the mobile menu instead).

## Minimal example

```gjs
import { ApplicationShell } from "nvp.ui";

<template>
  <ApplicationShell>
    <:headerLeft>
      <a href="/">Home</a>
    </:headerLeft>
    <:nav>
      <nav>
        <ul>
          <li><a href="/page-1">Page 1</a></li>
          <li><a href="/page-2">Page 2</a></li>
        </ul>
      </nav>
    </:nav>
    <:default>
      {{outlet}}
    </:default>
  </ApplicationShell>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/application-shell"
    @name="ApplicationShellSignature"
  />
</template>
```

### CSS Classes

| Class                                | Description                              |
| :----------------------------------- | :--------------------------------------- |
| `.nvp__application-shell__layout`    | The sidebar + main grid container        |
| `.nvp__application-shell__sidebar`   | The sidebar wrapper (hidden below 768px) |
| `.nvp__application-shell__content`   | The main content area                    |
| `.nvp__application-shell__menu-icon` | The hamburger menu SVG icon              |

### Responsive behavior

Uses container queries, so the component responds to its container's width rather than the viewport.

| Container width | Sidebar | Hamburger toggle              |
| :-------------- | :------ | :---------------------------- |
| `≥ 768px`       | Visible | Hidden                        |
| `< 768px`       | Hidden  | Visible (opens mobile drawer) |
