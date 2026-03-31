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
