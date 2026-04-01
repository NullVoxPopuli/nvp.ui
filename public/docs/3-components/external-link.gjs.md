# ExternalLink

The `<ExternalLink />` component is a light wrapper around the [Anchor element][mdn-a], which will always make your link an external link.

[mdn-a]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a

This component always has `target=_blank` and `rel='noreferrer noopener'`.

```gjs live
import { ExternalLink } from "nvp.ui";

<template>
  <ExternalLink href="https://github.com/universal-ember/preem">
    Visit GitHub
  </ExternalLink>
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
  <ComponentSignature
    @package="."
    @module="declarations/components/external-link.gts"
    @name="Signature"
  />
</template>
```

### State Attributes

none

### Styling

Public selectors:

|                  key                  | description                                  |
| :-----------------------------------: | :------------------------------------------- |
|        `.preem__external-link`        | The anchor class                             |
| `.preem__external-link__link-content` | The wrapper element around the block content |
