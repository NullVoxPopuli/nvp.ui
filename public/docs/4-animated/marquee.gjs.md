# Marquee

Infinite scrolling content with configurable direction, speed, and hover pause.

```gjs live preview no-shadow
import { Marquee } from "nvp.ui";

<template>
  <Marquee @fade={{true}} @pauseOnHover={{true}}>
    <span style="padding: 0 1.5rem;">Ember</span>
    <span style="padding: 0 1.5rem;">React</span>
    <span style="padding: 0 1.5rem;">Vue</span>
    <span style="padding: 0 1.5rem;">Svelte</span>
    <span style="padding: 0 1.5rem;">Angular</span>
    <span style="padding: 0 1.5rem;">Solid</span>
    <span style="padding: 0 1.5rem;">Qwik</span>
    <span style="padding: 0 1.5rem;">Astro</span>
  </Marquee>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Duplicate content is marked `aria-hidden="true"`
- Respects `prefers-reduced-motion` by pausing the animation

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/marquee" @name="Signature" />
</template>
```

### State Attributes

|       attribute       | values                        | description              |
| :-------------------: | :---------------------------- | :----------------------- |
|   `data-direction`    | `left`, `right`, `up`, `down` | Scroll direction         |
| `data-pause-on-hover` | `true`                        | Pauses on hover when set |
|      `data-fade`      | `true`                        | Fades edges when set     |

### Styling

Public selectors:

|           key            | description                                    |
| :----------------------: | :--------------------------------------------- |
|     `.nvp__marquee`      | Root container                                 |
|  `.nvp__marquee__track`  | Animated scrolling track                       |
| `.nvp__marquee__content` | Content wrapper (duplicated for seamless loop) |
