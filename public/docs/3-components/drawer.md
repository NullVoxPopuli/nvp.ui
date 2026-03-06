# Drawer

A panel that slides in from the side of the screen. Built on the native `<dialog>` element.

```gjs live no-shadow
import { Drawer } from "nvp.ui";
import { on } from "@ember/modifier";

<template>
  <Drawer as |d|>
    <button type="button" {{d.focusOnClose}} {{on "click" d.open}}>
      Open Drawer
    </button>

    <d.Drawer>
      <:title>Navigation</:title>
      <:default>
        <p>Drawer content goes here.</p>
        <p>Add navigation links, forms, or other content.</p>
      </:default>
      <:footer>
        <button type="button" {{on "click" d.close}}>Close</button>
      </:footer>
    </d.Drawer>
  </Drawer>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Uses the native `<dialog>` element with `showModal()` for proper focus trapping
- The button that opens the drawer receives focus when the drawer closes (via `focusOnClose`)
- Pressing `Escape` closes the drawer
- Background content is inert while the drawer is open

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/drawer.gts" @name="Signature" />
</template>
```

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `dialog.nvp__drawer` | The drawer dialog element |
| `.nvp__drawer__header` | The header row (title + close button) |
| `.nvp__drawer__title` | The drawer title |
| `.nvp__drawer__close` | The close button |
| `.nvp__drawer__body` | The scrollable content area |
| `.nvp__drawer__footer` | The footer action area |
