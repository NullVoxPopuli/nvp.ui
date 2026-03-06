# Breadcrumb

A navigation aid that displays the current page location within a site hierarchy.

```gjs live no-shadow
import { Breadcrumb } from "nvp.ui";

<template>
  <Breadcrumb as |b|>
    <li>
      <a href="/">Home</a>
    </li>
    <b.Separator>/</b.Separator>
    <li>
      <a href="/components">Components</a>
    </li>
    <b.Separator>/</b.Separator>
    <li aria-current="page">
      Breadcrumb
    </li>
  </Breadcrumb>
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
  <ComponentSignature @package="." @module="declarations/components/breadcrumb.gts" @name="Signature" />
</template>
```

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `.nvp__breadcrumb` | The root container |
| `.nvp__breadcrumb__separator` | The separator element (aria-hidden) |
