# Tabs


tabs do x y z


```gjs live no-shadow
import { Tabs } from 'nvp.ui/tabs';

<template>
  <Tabs as |Tab|>
    <Tab @label="Red" @content="Apple" />
    <Tab @label="Purple" @content="Blueberries" />
    <Tab @label="Yellow" @content="Banana" />
  </Tabs>
</template>
```

## API Reference

### Classes & Attributes


| Attribute | Values |    |
| --------- | ------ | -- |
| `data-orientation` | `'top' \| 'bottom' \| 'left' \| 'right'` | represents the current tab orientation, as set by `@orientation` (or the default: `top`) |

