# Dialog

A modal dialog window that appears over the page content. Uses the native `<dialog>` HTML element.

```gjs live no-shadow
import { Dialog } from "nvp.ui";
import { on } from "@ember/modifier";

<template>
  <Dialog as |d|>
    <button type="button" {{d.focusOnClose}} {{on "click" d.open}}>
      Open Dialog
    </button>

    <d.Dialog>
      <:title>Confirm Action</:title>
      <:default>
        Are you sure you want to proceed? This action cannot be undone.
      </:default>
      <:footer>
        <button type="button" {{on "click" d.close}}>Cancel</button>
        <button type="button" {{on "click" d.close}}>Confirm</button>
      </:footer>
    </d.Dialog>
  </Dialog>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Uses the native `<dialog>` element with `showModal()` for proper focus trapping
- The button that opens the dialog receives focus when the dialog closes (via `focusOnClose`)
- Pressing `Escape` closes the dialog
- Background content is inert while the dialog is open

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/dialog.gts" @name="Signature" />
</template>
```

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `dialog.nvp__dialog` | The dialog element |
| `.nvp__dialog__header` | The header row (title + close button) |
| `.nvp__dialog__title` | The dialog title |
| `.nvp__dialog__close` | The close button |
| `.nvp__dialog__body` | The main content area |
| `.nvp__dialog__footer` | The footer action area |
