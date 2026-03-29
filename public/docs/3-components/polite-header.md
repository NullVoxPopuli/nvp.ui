# Polite Header

A modifier that makes any sticky or fixed header "polite" — it hides when the user scrolls down and reveals when they scroll up, staying out of the way while reading content.

Inspired by [vue-use-fixed-header](https://github.com/smastrom/vue-use-fixed-header) and the "polite sticky header" pattern.

```gjs live no-shadow
import { politeHeader } from "nvp.ui/polite-header";

<template>
  <div style="height: 300px; overflow-y: scroll; position: relative; border: 1px solid var(--border-color); border-radius: var(--radius);">
    <header
      {{politeHeader}}
      style="position: sticky; top: 0; padding: 1rem; background: var(--header-background); filter: var(--shadow-xl); z-index: 1;"
    >
      Polite Header — scroll down to hide me, scroll up to reveal
    </header>
    <div style="padding: 1rem;">
      <p>Scroll this container to see the header hide and reveal.</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.</p>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
      <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.</p>
      <p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.</p>
      <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti.</p>
      <p>Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus.</p>
      <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.</p>
      <p>Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>
    </div>
  </div>
</template>
```

## Usage with Header

The modifier composes naturally with the existing `Header` component:

```gjs live no-shadow
import { Header } from "nvp.ui/header";
import { politeHeader } from "nvp.ui/polite-header";

<template>
  <div style="height: 250px; overflow-y: scroll; position: relative; border: 1px solid var(--border-color); border-radius: var(--radius);">
    <div {{politeHeader}}>
      <Header>
        <:left>My App</:left>
        <:right>Menu</:right>
      </Header>
    </div>
    <div style="padding: 1rem;">
      <p>The Header component is wrapped in a div with the politeHeader modifier.</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
      <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.</p>
      <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.</p>
      <p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.</p>
      <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium.</p>
      <p>Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore.</p>
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

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/polite-header.gts" @name="politeHeader" />
</template>
```

### CSS Classes

| class | description |
| :---: | :---------- |
| `.preem__polite-header` | Applied to the element when the modifier is active |
| `.preem__polite-header--hidden` | Applied when the header is hidden (scrolling down) |

### CSS Custom Properties

| property | default | description |
| :---: | :---: | :---------- |
| `--polite-header-duration` | `0.3s` | Transition duration for the hide/show animation |
