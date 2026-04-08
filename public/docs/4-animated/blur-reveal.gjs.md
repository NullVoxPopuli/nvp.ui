# Blur Reveal

Text that reveals character-by-character with a blur-to-clear animation.

```gjs live preview no-shadow
import { BlurReveal } from "nvp.ui";

<template>
  <div style="font-size: 1.5rem; font-weight: 600;">
    <BlurReveal>The quick brown fox jumps over the lazy dog</BlurReveal>
  </div>

  <br />

  <div style="font-size: 1.25rem;">
    <BlurReveal @speed={{0.8}} @delay={{1}}>This text reveals more slowly after a delay</BlurReveal>
  </div>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Respects `prefers-reduced-motion` by showing text immediately without animation

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/blur-reveal"
    @name="Signature"
  />
</template>
```

### Styling

Public selectors:

|            key            | description                        |
| :-----------------------: | :--------------------------------- |
|    `.nvp__blur-reveal`    | Root container                     |
| `.nvp__blur-reveal__char` | Individual animated character span |
