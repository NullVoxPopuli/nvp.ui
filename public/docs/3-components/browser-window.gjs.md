# BrowserWindow

A Safari-esque browser window mockup for demos, documentation, and screenshots. Inspired by [zachleat/browser-window](https://github.com/zachleat/browser-window).

## Basic

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <BrowserWindow @url="https://example.com">
    <h3>Hello world!</h3>
    <p>This is rendered inside a browser window mockup.</p>
  </BrowserWindow>
</template>
```

## Without URL bar

Omit `@url` to show just the traffic-light header.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <BrowserWindow>
    <p>No address bar, just content.</p>
  </BrowserWindow>
</template>
```

## Shadow

Use `@shadow` to add a layered drop shadow for a floating effect.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <BrowserWindow @url="https://nullui.vercel.app" @shadow={{true}}>
    <p>This window has a drop shadow.</p>
  </BrowserWindow>
</template>
```

## Grayscale

Use `@grayscale` to render the traffic-light circles in neutral tones.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <BrowserWindow @url="https://example.com" @grayscale={{true}}>
    <p>Grayscale circles for a subtler look.</p>
  </BrowserWindow>
</template>
```

## Flush content

Use `@flush` to remove body padding — useful for images or iframes that should fill edge-to-edge.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <BrowserWindow @url="https://example.com" @flush={{true}} @shadow={{true}}>
    <div class="placeholder">
      Full-bleed content area
    </div>
  </BrowserWindow>

  <style>
    @scope {
      .placeholder {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 3rem 1rem;
        text-align: center;
        font-size: 1.1rem;
      }
    }
  </style>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Anatomy

```js
import { BrowserWindow } from "nvp.ui/browser-window";
```

```gjs
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <BrowserWindow @url="https://example.com">
    Your content here
  </BrowserWindow>
</template>
```

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/browser-window"
    @name="BrowserWindowSignature"
  />
</template>
```

### CSS Custom Properties

|        Property        |                       Default                       | Description                       |
| :--------------------: | :-------------------------------------------------: | :-------------------------------- |
|       `--bw-bg`        |             `light-dark(#fff, #2a2a2e)`             | Window background color           |
|       `--bw-fg`        |              `light-dark(#000, #fff)`               | Window text color                 |
|     `--bw-border`      | `light-dark(rgba(0,0,0,.15), rgba(255,255,255,.1))` | Window border color               |
|    `--bw-header-bg`    |           `light-dark(#e8e8e8, #38383d)`            | Header/title bar background       |
|     `--bw-url-bg`      |             `light-dark(#fff, #1e1e21)`             | URL bar background                |
|     `--bw-url-fg`      |              `light-dark(#666, #aaa)`               | URL bar text color                |
|  `--bw-circle-close`   |                      `#ff5f56`                      | Close circle color (red)          |
| `--bw-circle-minimize` |                      `#ffbd2e`                      | Minimize circle color (yellow)    |
| `--bw-circle-maximize` |                      `#27c93f`                      | Maximize circle color (green)     |
|   `--bw-circle-size`   |                      `0.75em`                       | Diameter of traffic-light circles |
|     `--bw-radius`      |                      `0.5rem`                       | Window border radius              |

### CSS Classes

|              Class              | Description                      |
| :-----------------------------: | :------------------------------- |
|     `.nvp__browser-window`      | The outer window container       |
| `.nvp__browser-window__header`  | The title bar with circles & URL |
| `.nvp__browser-window__circles` | Container for the three circles  |
| `.nvp__browser-window__circle`  | Individual traffic-light circle  |
|   `.nvp__browser-window__url`   | The URL/address bar              |
|  `.nvp__browser-window__body`   | The content area                 |
