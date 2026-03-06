# TabbedShellScript

The `<TabbedShellScript />` component displays shell commands in a tabbed interface, making it easy to show the same script across different package managers (npm, yarn, pnpm, bun).

```gjs live no-shadow
import { TabbedShellScript } from "nvp.ui";

<template>
  <TabbedShellScript
    @npm="npm run build"
    @yarn="yarn build"
    @pnpm="pnpm run build"
    @bun="bun run build"
  />
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
  <ComponentSignature @package="." @module="declarations/components/tabbed-shell-script.gts" @name="Signature" />
</template>
```

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `.nvp__tabbed-shell-script` | The root element |
| `.nvp__tabbed-shell-script__row` | The row containing the command and copy button |
| `.nvp__tabbed-shell-script__copy` | The copy-to-clipboard button |
