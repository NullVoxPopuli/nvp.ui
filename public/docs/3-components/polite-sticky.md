# Polite Sticky

A modifier that makes sticky headers and footers "polite" — they stay out of the way while you read.

- On a **header**: slides up as the user scrolls down, slides back on scroll up
- On a **footer**: slides down as the user scrolls up, slides back on scroll down

The element type is detected automatically from the tag name (`<header>` vs `<footer>`). The animation is scroll-linked — the element tracks scroll position 1:1 via a `--polite-offset` CSS variable.

## Header

Scroll down inside the box — the header slides away. Scroll back up — it reappears.

```gjs live no-shadow
import { politeSticky } from "nvp.ui/polite-sticky";

<template>
  <div
    class="demo"
    style="height: 180px; overflow-y: scroll; position: relative;"
    tabindex="0"
    role="region"
    aria-label="Polite header demo"
  >

    <header {{politeSticky}}>
      Polite Header
    </header>

    <div class="content">
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt
        ut labore et dolore magna aliqua.</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
        commodo consequat.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat
        nulla pariatur.</p>
      <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
        anim id est laborum.</p>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque
        laudantium, totam rem aperiam.</p>
      <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
        consequuntur magni dolores.</p>
    </div>
  </div>
  <style>
    @scope {
      .demo {
        border: 1px solid var(--border-color);
        border-radius: var(--radius);
      }
      header {
        padding: 0.75rem 1rem;
        font-weight: 600;
        background: var(--header-background);
        filter: var(--shadow-xl);
        z-index: 1;
      }
      .content {
        padding: 1rem;
      }
    }
  </style>
</template>
```

### With the Header component

```gjs live no-shadow
import { Header } from "nvp.ui/header";
import { politeSticky } from "nvp.ui/polite-sticky";

<template>
  <div
    class="demo"
    style="height: 180px; overflow-y: scroll; position: relative;"
    tabindex="0"
    role="region"
    aria-label="Polite Header component demo"
  >

    <Header {{politeSticky}}>
      <:left>My App</:left>
      <:right>Menu</:right>
    </Header>

    <div class="content">
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt
        ut labore et dolore magna aliqua.</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
        commodo consequat.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat
        nulla pariatur.</p>
      <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
        anim id est laborum.</p>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque
        laudantium, totam rem aperiam.</p>
      <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
        consequuntur magni dolores.</p>
    </div>
  </div>
  <style>
    @scope {
      .demo {
        border: 1px solid var(--border-color);
        border-radius: var(--radius);
      }
      .content {
        padding: 1rem;
      }
    }
  </style>
</template>
```

## Footer

Scroll up inside the box — the footer slides away. Scroll back down — it reappears.

```gjs live no-shadow
import { politeSticky } from "nvp.ui/polite-sticky";

<template>
  <div
    class="demo"
    style="height: 180px; overflow-y: scroll; position: relative;"
    tabindex="0"
    role="region"
    aria-label="Polite footer demo"
  >
    <div class="content">
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt
        ut labore et dolore magna aliqua.</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
        commodo consequat.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat
        nulla pariatur.</p>
      <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
        anim id est laborum.</p>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque
        laudantium, totam rem aperiam.</p>
      <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
        consequuntur magni dolores.</p>
    </div>

    <footer {{politeSticky}}>
      Polite Footer
    </footer>

  </div>
  <style>
    @scope {
      .demo {
        border: 1px solid var(--border-color);
        border-radius: var(--radius);
      }
      footer {
        padding: 0.75rem 1rem;
        font-weight: 600;
        background: var(--header-background);
        filter: var(--shadow-xl);
        z-index: 1;
      }
      .content {
        padding: 1rem;
      }
    }
  </style>
</template>
```

## Features

- **Scroll-linked animation** — tracks scroll position 1:1 via `--polite-offset` CSS variable
- **Auto-detects header vs footer** — applies the correct scroll behavior based on element type
- **GPU-accelerated** — uses `translateY` for composited animations

## Installation

```bash
pnpm add nvp.ui
```

## API Reference

### CSS Classes

|         class          | description                                        |
| :--------------------: | :------------------------------------------------- |
|     `.nvp__polite`     | Applied to the element when the modifier is active |
| `.nvp__polite__header` | Applied when the element is detected as a header   |
| `.nvp__polite__footer` | Applied when the element is detected as a footer   |

### CSS Custom Properties

|     property      | description                                              |
| :---------------: | :------------------------------------------------------- |
| `--polite-offset` | Set by the modifier on scroll. The pixel offset to apply |
