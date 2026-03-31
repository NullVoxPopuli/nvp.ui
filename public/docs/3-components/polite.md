# Polite

A modifier that makes sticky headers and footers "polite" — they stay out of the way while you read.

- On a **header**: hides on scroll down, reveals on scroll up
- On a **footer**: hides on scroll up, reveals on scroll down

The element type is detected automatically from the tag name (`<header>` vs `<footer>`).

Inspired by [vue-use-fixed-header](https://github.com/smastrom/vue-use-fixed-header) and the "polite sticky header" pattern.

## Usage

```gts
import { polite } from "nvp.ui/polite";
import { Header } from "nvp.ui/header";

<template>
  <Header {{polite}}>
    <:left>My App</:left>
  </Header>

  <footer {{polite}}>
    Footer content
  </footer>
</template>
```

## Header

Scroll down inside the box — the header slides away. Scroll back up — it reappears.

```gjs live no-shadow
import { PoliteHeader } from "nvp.ui/polite";

<template>
  <div
    tabindex="0"
    role="region"
    aria-label="Polite header demo"
    style="height: 180px; overflow-y: scroll; position: relative; border: 1px solid var(--border-color); border-radius: var(--radius);"
  >
    <PoliteHeader style="padding: 0.75rem 1rem; filter: var(--shadow-xl); font-weight: 600;">
      I hide on scroll down, reveal on scroll up
    </PoliteHeader>
    <div style="padding: 1rem;">
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
</template>
```

## Footer

Scroll up inside the box — the footer slides away. Scroll back down — it reappears.

```gjs live no-shadow
import { PoliteFooter } from "nvp.ui/polite";

<template>
  <div
    tabindex="0"
    role="region"
    aria-label="Polite footer demo"
    style="height: 180px; overflow-y: scroll; position: relative; border: 1px solid var(--border-color); border-radius: var(--radius);"
  >
    <div style="padding: 1rem;">
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
    <PoliteFooter style="padding: 0.75rem 1rem; filter: var(--shadow-xl); font-weight: 600;">
      I hide on scroll up, reveal on scroll down
    </PoliteFooter>
  </div>
</template>
```

## Features

- **Auto-detects header vs footer** — applies the correct scroll behavior based on element type
- **GPU-accelerated** — uses `translate3d` for smooth, composited animations
- **Respects `prefers-reduced-motion`** — disables transitions when the user prefers reduced motion
## Installation

```bash
pnpm add nvp.ui
```

## API Reference

### CSS Classes

|             class             | description                                        |
| :---------------------------: | :------------------------------------------------- |
|        `.nvp__polite`         | Applied to the element when the modifier is active |
|    `.nvp__polite--header`     | Applied when the element is detected as a header   |
|    `.nvp__polite--footer`     | Applied when the element is detected as a footer   |
| `.nvp__polite--header-hidden` | Applied when the header is hidden (scrolling down) |
| `.nvp__polite--footer-hidden` | Applied when the footer is hidden (scrolling up)   |

