# Spinner

A loading spinner with configurable size and speed.

```gjs live preview no-shadow
import { Spinner } from "nvp.ui";

<template>
  <div style="display: flex; gap: 1.5rem; align-items: center;">
    <Spinner @size="small" />
    <Spinner />
    <Spinner @size="large" />
  </div>

  <br />

  <div style="display: flex; gap: 1.5rem; align-items: center;">
    <Spinner @speed="slow" />
    <Spinner @speed="normal" />
    <Spinner @speed="fast" />
  </div>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Uses `role="status"` and `aria-label="Loading"` for screen reader announcements
- Respects `prefers-reduced-motion` by stopping the rotation animation

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/spinner" @name="Signature" />
</template>
```

### State Attributes

|  attribute   | values                     | description        |
| :----------: | :------------------------- | :----------------- |
| `data-size`  | `small`, `medium`, `large` | Spinner dimensions |
| `data-speed` | `slow`, `normal`, `fast`   | Rotation speed     |

### Styling

Public selectors:

|          key          | description          |
| :-------------------: | :------------------- |
|    `.nvp__spinner`    | Root spinner element |
| `.nvp__spinner__ring` | The rotating ring    |
