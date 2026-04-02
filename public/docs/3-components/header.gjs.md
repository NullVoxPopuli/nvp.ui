# Header

The `<Header />` component provides a navigation bar for your application that can be positioned at either the top or bottom of the screen.

This component is ideal for app navigation, offering a clean and flexible layout with left and right content areas.

```gjs live no-shadow
import { Header } from "nvp.ui";

<template>
  <div class="scroll-container">
    <Header>
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

## Bottom Positioning

Use `@position="bottom"` to stick the header to the bottom. Scroll this container to see it stay anchored:

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

|       key       | description                                                |
| :-------------: | :--------------------------------------------------------- |
| `data-position` | Set to "top" or "bottom" based on the `@position` argument |

### Styling

Public selectors:

|           key           | description                         |
| :---------------------: | :---------------------------------- |
|    `.preem__header`     | The header element                  |
| `.preem__header__left`  | Container for left-aligned content  |
| `.preem__header__right` | Container for right-aligned content |

The header uses `position: sticky` by default with:

- `top: 0` for default or `@position="top"`
- `bottom: 0` for `@position="bottom"`
