# Header

The `<Header />` component provides a navigation bar for your application. By
default (`@position="auto"`) it sticks to the top, but moves to the **bottom**
of tall or narrow containers -- where thumbs can reach it, mobile-style. You
can also pin it explicitly with `@position="top"` or `@position="bottom"`.

## Auto positioning

Drag the frame's resize handle (bottom-right corner): make it narrow or taller
than it is wide, and the header moves to the bottom. Widen it back out and the
header returns to the top.

```gjs live no-shadow
import { Header } from "nvp.ui";

<template>
  <div class="resizable-app">
    <Header>
      <:left>
        <strong>my-app</strong>
      </:left>
      <:right>
        <a href="#home">Home</a>
        <a href="#about">About</a>
      </:right>
    </Header>

    <div class="fake-content">
      <p>This frame is a
        <code>container-type: size</code>
        element, so the header can query both its width ("narrow") and its aspect ratio ("tall").</p>
      <p>Resize me &#x2198;</p>
    </div>
  </div>

  <style>
    @scope {
      .resizable-app {
        /* the header queries this element */
        container-type: size;

        /* let the header re-order itself to the bottom edge */
        display: flex;
        flex-direction: column;

        resize: both;
        overflow: auto;
        width: min(36rem, 100%);
        height: 18rem;
        min-width: 13rem;
        min-height: 11rem;
        max-width: 100%;
        max-height: 38rem;
        border: 1px solid light-dark(rgba(0, 0, 0, 0.15), rgba(255, 255, 255, 0.1));
        border-radius: 0.5rem;
      }
      .fake-content {
        flex: 1;
        padding: 1rem;
      }
      .fake-content p {
        margin: 0 0 1rem;
        color: light-dark(#666, #aaa);
      }
    }
  </style>
</template>
```

How "auto" decides, using two container queries -- **narrow**
(`(max-width: 480px)`) and **tall** (`(max-aspect-ratio: 1/1)`):

- **narrow** works inside any container, including `<ApplicationShell>`'s
  `inline-size` wrapper -- the docs site you are reading uses it, so this
  site's header sits at the bottom on phones
- **tall** (portrait aspect ratio) additionally applies inside
  `container-type: size` elements, like the demo frame above -- or this
  site's layout root, so half-screening a portrait-ish window moves this
  site's header to the bottom too. It is a
  separate query on purpose: query-container selection is feature-dependent,
  so a combined `or` query would skip `inline-size` containers entirely
  (aspect-ratio needs size containment) and "narrow" would stop working in
  the shell
- with **no container ancestor** at all, `@container` rules never match
  (there is no viewport fallback for rules), so "auto" stays at the top;
  add a `container-type` to your layout root to opt in

The bottom placement pins via `position: sticky` + flex `order`, so the
header's parent should be a column flex (or grid) layout that fills the
container -- `<ApplicationShell>`'s content pane is one, and the demo frame
above shows the minimal standalone setup.

## Explicit top

`@position="top"` always sticks to the top, no matter the container:

```gjs live no-shadow
import { Header } from "nvp.ui";

<template>
  <div class="scroll-container">
    <Header @position="top">
      <:left>
        <a href="/">nvp.ui</a>
      </:left>
      <:right>
        <a href="/about">About</a>
        <a href="/contact">Contact</a>
      </:right>
    </Header>

    <div class="scroll-content">
      <p>Scroll down to see the header stick to the top.</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      <p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit.</p>
      <p>Excepteur sint occaecat cupidatat non proident.</p>
    </div>
  </div>

  <style>
    @scope {
      .scroll-container {
        height: 12rem;
        overflow-y: auto;
        border: 1px solid light-dark(rgba(0, 0, 0, 0.15), rgba(255, 255, 255, 0.1));
        border-radius: 0.5rem;
      }
      .scroll-content {
        padding: 1rem;
      }
      .scroll-content p {
        margin: 1.5rem 0;
        color: light-dark(#666, #aaa);
      }
    }
  </style>
</template>
```

## Explicit bottom

Use `@position="bottom"` to always stick the header to the bottom. Scroll this
container to see it stay anchored:

```gjs live no-shadow
import { Header } from "nvp.ui";

<template>
  <div class="scroll-container">
    <div class="scroll-content">
      <p>Scroll down — the footer navigation stays at the bottom.</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      <p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit.</p>
      <p>Excepteur sint occaecat cupidatat non proident.</p>
    </div>

    <Header @position="bottom">
      <:left>
        <span>Footer Navigation</span>
      </:left>
      <:right>
        <a href="/about">About</a>
        <a href="/contact">Contact</a>
      </:right>
    </Header>
  </div>

  <style>
    @scope {
      .scroll-container {
        height: 12rem;
        overflow-y: auto;
        border: 1px solid light-dark(rgba(0, 0, 0, 0.15), rgba(255, 255, 255, 0.1));
        border-radius: 0.5rem;
      }
      .scroll-content {
        padding: 1rem;
      }
      .scroll-content p {
        margin: 1.5rem 0;
        color: light-dark(#666, #aaa);
      }
    }
  </style>
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
  <ComponentSignature @package="." @module="declarations/components/header" @name="Signature" />
</template>
```

### State Attributes

|       key       | description                                                              |
| :-------------: | :----------------------------------------------------------------------- |
| `data-position` | The authored `@position`: `"auto"` (the default), `"top"`, or `"bottom"` |

### Styling

Public selectors:

|          key          | description                         |
| :-------------------: | :---------------------------------- |
|    `.nvp__header`     | The header element                  |
| `.nvp__header__left`  | Container for left-aligned content  |
| `.nvp__header__right` | Container for right-aligned content |

The header uses `position: sticky` with:

- `top: 0` for `@position="top"` (and `"auto"` on wide containers)
- `bottom: 0` for `@position="bottom"` (and `"auto"` on narrow/tall
  containers, which also sets flex `order: 1` so column layouts place it last)
- the elevation shadow casts upward whenever the header sits at the bottom
