# BrowserWindow

A browser window mockup for demos, documentation, and screenshots. Inspired by [zachleat/browser-window](https://github.com/zachleat/browser-window).

## OS Styles

Use `@os` to choose a browser chrome style. The default is macOS.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <div class="gallery">
    <BrowserWindow @url="https://example.com">
      <p>macOS (default)</p>
    </BrowserWindow>

    <BrowserWindow @os="windows" @url="https://example.com">
      <p>Windows</p>
    </BrowserWindow>

    <BrowserWindow @os="ubuntu" @url="https://example.com">
      <p>Ubuntu / GNOME</p>
    </BrowserWindow>

    <BrowserWindow @os="generic" @url="https://example.com">
      <p>Generic</p>
    </BrowserWindow>
  </div>

  <style>
    @scope {
      .gallery {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
      }
      .gallery > * {
        flex: 1 1 16rem;
        min-width: 0;
      }
    }
  </style>
</template>
```

## Tabs

Pass `@tabs` with an array of strings to render a tab bar. The first tab is active. When tabs are present, a toolbar row with back/forward navigation and the URL bar appears below the tabs.

The `@tabStyle` defaults to `"safari"` on macOS and `"firefox"` on other OS styles.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

const tabs = ["Home", "About", "Blog"];

<template>
  <div class="gallery">
    <BrowserWindow @url="https://example.com" @tabs={{tabs}}>
      <p>Safari tabs (default on macOS)</p>
    </BrowserWindow>

    <BrowserWindow @os="windows" @url="https://example.com" @tabs={{tabs}} @tabStyle="chrome">
      <p>Chrome tabs</p>
    </BrowserWindow>

    <BrowserWindow @os="ubuntu" @url="https://example.com" @tabs={{tabs}}>
      <p>Firefox tabs (default on non-macOS)</p>
    </BrowserWindow>
  </div>

  <style>
    @scope {
      .gallery {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
      }
      .gallery > * {
        flex: 1 1 18rem;
        min-width: 0;
      }
    }
  </style>
</template>
```

## Without URL bar

Omit `@url` to show just the header chrome.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <div class="gallery">
    <BrowserWindow>
      <p>macOS — no URL bar</p>
    </BrowserWindow>

    <BrowserWindow @os="windows">
      <p>Windows — no URL bar</p>
    </BrowserWindow>

    <BrowserWindow @os="ubuntu">
      <p>Ubuntu — no URL bar</p>
    </BrowserWindow>
  </div>

  <style>
    @scope {
      .gallery {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
      }
      .gallery > * {
        flex: 1 1 14rem;
        min-width: 0;
      }
    }
  </style>
</template>
```

## Shadow

Use `@shadow` to add a layered drop shadow for a floating effect.

```gjs live no-shadow
import { BrowserWindow } from "nvp.ui/browser-window";

<template>
  <div class="gallery">
    <BrowserWindow @url="https://example.com" @shadow={{true}}>
      <p>macOS with shadow</p>
    </BrowserWindow>

    <BrowserWindow @os="ubuntu" @url="https://example.com" @shadow={{true}}>
      <p>Ubuntu with shadow</p>
    </BrowserWindow>
  </div>

  <style>
    @scope {
      .gallery {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
      }
      .gallery > * {
        flex: 1 1 16rem;
        min-width: 0;
      }
    }
  </style>
</template>
```

## Grayscale

Use `@grayscale` to render the macOS traffic-light circles in neutral tones.

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
  <div class="gallery">
    <BrowserWindow @url="https://example.com" @flush={{true}} @shadow={{true}}>
      <div class="placeholder">Full-bleed content</div>
    </BrowserWindow>

    <BrowserWindow @os="windows" @url="https://example.com" @flush={{true}} @shadow={{true}}>
      <div class="placeholder">Full-bleed content</div>
    </BrowserWindow>
  </div>

  <style>
    @scope {
      .gallery {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
      }
      .gallery > * {
        flex: 1 1 16rem;
        min-width: 0;
      }
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
  <BrowserWindow @os="mac" @url="https://example.com">
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

| Property                             | Default                                             | Description                           |
| ------------------------------------ | --------------------------------------------------- | ------------------------------------- |
| `--browser-window-background`        | `light-dark(#fff, #2a2a2e)`                         | Window background color               |
| `--browser-window-color`             | `light-dark(#000, #fff)`                            | Window text color                     |
| `--browser-window-border-color`      | `light-dark(rgba(0,0,0,.15), rgba(255,255,255,.1))` | Window border color                   |
| `--browser-window-header-background` | `light-dark(#f6f6f6, #3a3a3c)`                      | Header/title bar background           |
| `--browser-window-url-background`    | `light-dark(#fff, #1e1e21)`                         | URL bar background                    |
| `--browser-window-url-color`         | `light-dark(#666, #aaa)`                            | URL bar text color                    |
| `--browser-window-circle-close`      | `#ff5f56`                                           | Close circle color (red, macOS only)  |
| `--browser-window-circle-minimize`   | `#ffbd2e`                                           | Minimize circle color (yellow, macOS) |
| `--browser-window-circle-maximize`   | `#27c93f`                                           | Maximize circle color (green, macOS)  |
| `--browser-window-circle-size`       | `0.75em`                                            | Diameter of traffic-light circles     |
| `--browser-window-border-radius`     | `0.5rem`                                            | Window border radius                  |

### CSS Classes

| Class                            | Description                                            |
| -------------------------------- | ------------------------------------------------------ |
| `.nvp__browser-window`           | The outer window container                             |
| `.nvp__browser-window__header`   | The title bar                                          |
| `.nvp__browser-window__circles`  | Container for macOS traffic-light dots                 |
| `.nvp__browser-window__circle`   | Individual macOS traffic-light circle                  |
| `.nvp__browser-window__controls` | Container for Windows / Ubuntu control icons           |
| `.nvp__browser-window__tabs`     | Tab bar container                                      |
| `.nvp__browser-window__tab`      | Individual tab                                         |
| `.nvp__browser-window__toolbar`  | Toolbar row with nav buttons and URL (shown with tabs) |
| `.nvp__browser-window__nav`      | Back/forward navigation arrow                          |
| `.nvp__browser-window__url`      | The URL/address bar                                    |
| `.nvp__browser-window__body`     | The content area                                       |
