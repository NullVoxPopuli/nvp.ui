# Polite Header

A component that renders a polite sticky header — it hides when the user scrolls down and reveals when they scroll up, staying out of the way while reading content.

Inspired by [vue-use-fixed-header](https://github.com/smastrom/vue-use-fixed-header) and the "polite sticky header" pattern.

```gjs live no-shadow
import { PoliteHeader } from "nvp.ui/polite-header";

<template>
  <div
    tabindex="0"
    role="region"
    aria-label="Polite header demo"
    style="height: 300px; overflow-y: scroll; position: relative; border: 1px solid var(--border-color); border-radius: var(--radius);"
  >
    <PoliteHeader
      style="padding: 1rem; background: var(--header-background); filter: var(--shadow-xl); z-index: 1;"
    >
      Polite Header — scroll down to hide me, scroll up to reveal
    </PoliteHeader>
    <div style="padding: 1rem;">
      <p>Scroll this container to see the header hide and reveal.</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt
        ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
        laboris.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat
        nulla pariatur. Excepteur sint occaecat cupidatat non proident.</p>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque
        laudantium, totam rem aperiam.</p>
      <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
        consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.</p>
      <p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci
        velit.</p>
      <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium
        voluptatum deleniti atque corrupti.</p>
      <p>Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta
        nobis est eligendi optio cumque nihil impedit quo minus.</p>
      <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet
        ut et voluptates repudiandae sint et molestiae non recusandae.</p>
      <p>Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores
        alias consequatur aut perferendis doloribus asperiores repellat.</p>
    </div>
  </div>
</template>
```

## Features

- **Hides on scroll down** — slides the header off-screen when the user scrolls down
- **Reveals on scroll up** — brings the header back when the user scrolls up
- **Always visible at top** — header is always shown when at the top of the page
- **GPU-accelerated** — uses `translate3d` for smooth, composited animations
- **Respects `prefers-reduced-motion`** — disables transitions when the user prefers reduced motion
- **Customizable timing** — set the `--polite-header-duration` CSS custom property to control transition speed

## Installation

```bash
pnpm add nvp.ui
```

## Customization

The transition duration can be adjusted via a CSS custom property:

```css
:root {
  --polite-header-duration: 0.5s; /* default: 0.3s */
}
```

## API Reference

### CSS Classes

|             class             | description                                        |
| :---------------------------: | :------------------------------------------------- |
|     `.nvp__polite-header`     | Applied to the element when the modifier is active |
| `.nvp__polite-header--hidden` | Applied when the header is hidden (scrolling down) |

### CSS Custom Properties

|          property          | default | description                                     |
| :------------------------: | :-----: | :---------------------------------------------- |
| `--polite-header-duration` | `0.3s`  | Transition duration for the hide/show animation |
