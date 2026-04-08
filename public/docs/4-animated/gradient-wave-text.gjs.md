# Gradient Wave Text

Apple-style animated gradient that flows across text.

```gjs live preview no-shadow
import { GradientWaveText } from "nvp.ui";

<template>
  <div style="font-size: 2.5rem; font-weight: bold;">
    <GradientWaveText>Just ship things.</GradientWaveText>
  </div>

  <br />

  <div style="font-size: 1.5rem; font-weight: 600;">
    <GradientWaveText @speed={{6}}>Slower wave animation</GradientWaveText>
  </div>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Respects `prefers-reduced-motion` by showing a static gradient

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/gradient-wave-text"
    @name="Signature"
  />
</template>
```

### Styling

Public selectors:

|            key             | description                |
| :------------------------: | :------------------------- |
| `.nvp__gradient-wave-text` | Root gradient text element |
