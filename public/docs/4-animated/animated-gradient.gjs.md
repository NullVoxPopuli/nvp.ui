# Animated Gradient

A WebGL-powered animated gradient background with presets and custom configuration.

```gjs live preview no-shadow
import { AnimatedGradient } from "nvp.ui";

<template>
  <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem;">
    <AnimatedGradient @preset="lava" style="height: 120px; border-radius: 0.5rem;">
      <div
        style="display:flex;align-items:center;justify-content:center;height:100%;color:white;font-weight:bold;"
      >Lava</div>
    </AnimatedGradient>
    <AnimatedGradient @preset="prism" style="height: 120px; border-radius: 0.5rem;">
      <div
        style="display:flex;align-items:center;justify-content:center;height:100%;color:white;font-weight:bold;"
      >Prism</div>
    </AnimatedGradient>
    <AnimatedGradient @preset="plasma" style="height: 120px; border-radius: 0.5rem;">
      <div
        style="display:flex;align-items:center;justify-content:center;height:100%;color:white;font-weight:bold;"
      >Plasma</div>
    </AnimatedGradient>
    <AnimatedGradient @preset="pulse" style="height: 120px; border-radius: 0.5rem;">
      <div
        style="display:flex;align-items:center;justify-content:center;height:100%;color:white;font-weight:bold;"
      >Pulse</div>
    </AnimatedGradient>
    <AnimatedGradient @preset="vortex" style="height: 120px; border-radius: 0.5rem;">
      <div
        style="display:flex;align-items:center;justify-content:center;height:100%;color:white;font-weight:bold;"
      >Vortex</div>
    </AnimatedGradient>
    <AnimatedGradient @preset="mist" style="height: 120px; border-radius: 0.5rem;">
      <div
        style="display:flex;align-items:center;justify-content:center;height:100%;color:#333;font-weight:bold;"
      >Mist</div>
    </AnimatedGradient>
  </div>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Respects `prefers-reduced-motion` by rendering a single frame without animation
- Content overlay is positioned above the canvas for proper focus order

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/animated-gradient"
    @name="Signature"
  />
</template>
```

### Styling

Public selectors:

|                key                 | description     |
| :--------------------------------: | :-------------- |
|     `.nvp__animated-gradient`      | Root container  |
| `.nvp__animated-gradient__canvas`  | WebGL canvas    |
| `.nvp__animated-gradient__content` | Content overlay |
