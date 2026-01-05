# Header

The `<Header />` component provides a navigation bar for your application that can be positioned at either the top or bottom of the screen.

This component is ideal for app navigation, offering a clean and flexible layout with left and right content areas.

```gjs live
import { Header } from "nvp.ui";

<template>
  <Header>
    <:left>
      <a href="/">nvp.ui</a>
    </:left>
    <:right>
      <a href="/about">About</a>
      <a href="/contact">Contact</a>
    </:right>
  </Header>
</template>
```

## Bottom Positioning

The header can also be positioned at the bottom of the screen by setting `@position="bottom"`:

```gjs live
import { Header } from "nvp.ui";

<template>
  <Header @position="bottom">
    <:left>
      <span>Footer Navigation</span>
    </:left>
    <:right>
      <a href="/about">About</a>
      <a href="/contact">Contact</a>
    </:right>
  </Header>
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
    @module="declarations/components/header.gts"
    @name="Signature"
  />
</template>
```

### State Attributes

| key | description |
| :---: | :--- |
| `data-position` | Set to "top" or "bottom" based on the `@position` argument |

### Styling

Public selectors:

| key | description |
| :---: | :--- |
| `.preem__header` | The header element |
| `.preem__header__left` | Container for left-aligned content |
| `.preem__header__right` | Container for right-aligned content |

The header uses `position: sticky` by default with:
- `top: 0` for default or `@position="top"`
- `bottom: 0` for `@position="bottom"`
