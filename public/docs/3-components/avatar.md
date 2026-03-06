# Avatar

Displays an image representing a user or entity, with a fallback for when the image is unavailable.

```gjs live no-shadow
import { Avatar } from "nvp.ui";

<template>
  <div style="display: flex; gap: 1rem; align-items: center">
    <Avatar @src="https://github.com/NullVoxPopuli.png" @alt="NullVoxPopuli">
      <:fallback>NVP</:fallback>
    </Avatar>

    <Avatar @src="https://invalid-url.example/image.png" @alt="Fallback demo">
      <:fallback>AB</:fallback>
    </Avatar>
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
  <ComponentSignature @package="." @module="declarations/components/avatar.gts" @name="Signature" />
</template>
```

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `.nvp__avatar` | The root span element |
| `.nvp__avatar__fallback` | The fallback content wrapper |
