# Shimmer Text

Text with an animated shimmer highlight that sweeps across.

```gjs live preview no-shadow
import { ShimmerText } from "nvp.ui";

<template>
  <div style="font-size: 2rem; font-weight: bold;">
    <ShimmerText>Shimmer Effect</ShimmerText>
  </div>

  <br />

  <div style="font-size: 1.25rem;">
    <ShimmerText @duration={{3}}>Slower shimmer</ShimmerText>
  </div>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Respects `prefers-reduced-motion` by disabling the animation
- Text remains fully readable when animation is disabled

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/shimmer-text"
    @name="Signature"
  />
</template>
```

### Styling

Public selectors:

|         key          | description               |
| :------------------: | :------------------------ |
| `.nvp__shimmer-text` | Root shimmer text element |
