# Badge

A pill-shaped badge for labels, statuses, and counts.

```gjs live preview no-shadow
import { Badge } from "nvp.ui";

<template>
  <div style="display: flex; gap: 0.5rem; align-items: center; flex-wrap: wrap;">
    <Badge>Default</Badge>
    <Badge @variant="primary">Primary</Badge>
    <Badge @variant="secondary">Secondary</Badge>
    <Badge @variant="danger">Danger</Badge>
  </div>

  <br />

  <div style="display: flex; gap: 0.5rem; align-items: center;">
    <Badge @size="small">Small</Badge>
    <Badge @size="small" @variant="primary">Small Primary</Badge>
    <Badge>Default Size</Badge>
  </div>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/badge" @name="Signature" />
</template>
```

### State Attributes

|   attribute    | values                                      | description   |
| :------------: | :------------------------------------------ | :------------ |
| `data-variant` | `primary`, `secondary`, `danger`, `default` | Color variant |
|  `data-size`   | `small`, `default`                          | Size variant  |

### Styling

Public selectors:

|      key      | description        |
| :-----------: | :----------------- |
| `.nvp__badge` | Root badge element |
