# Slide Up Text

Text that slides up word-by-word with a staggered blur-to-clear animation.

```gjs live preview no-shadow
import { SlideUpText } from "nvp.ui";

<template>
  <div style="font-size: 1.5rem; font-weight: 600;">
    <SlideUpText>Build something beautiful today</SlideUpText>
  </div>

  <br />

  <div style="font-size: 1.25rem;">
    <SlideUpText @stagger={{0.15}} @delay={{0.5}}>This one has more stagger and delay</SlideUpText>
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
    @module="declarations/components/slide-up-text"
    @name="Signature"
  />
</template>
```

### Styling

Public selectors:

|             key             | description                   |
| :-------------------------: | :---------------------------- |
|    `.nvp__slide-up-text`    | Root container                |
| `.nvp__slide-up-text__word` | Individual animated word span |
