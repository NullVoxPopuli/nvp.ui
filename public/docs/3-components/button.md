# Button

The accessible button is an improvement on the native `<button>` by providing additional information when disabled, tooltips, etc

```gjs live no-shadow
import { Button, ExternalLink } from "nullui";
import { PortalTargets } from "ember-primitives";

const Reasoning = <template>
  You are missing the following permissions:

  <ul>
    <li>blogs.read</li>
    <li>blogs.write</li>
  </ul>

  To gain these permissions, consider purchasing a
  <ExternalLink href="https://example.com">
    Blogging Subscription
  </ExternalLink>
</template>;

<template>
  <PortalTargets />
  <Button>Default</Button>
  <Button @variant="primary">Primary</Button>
  <Button @variant="secondary">Secondary</Button>
  <Button @variant="danger">Danger</Button>

  <br /><br />

  <Button>
    <:start>✨</:start>
    <:text>text with icons</:text>
    <:end>🎉</:end>
  </Button>
  <Button @start="✨">
    Button text
  </Button>
  <Button @end="✨">
    Button text
  </Button>

  <br /><br />
  <Button @variant="primary" @disabled="Disabled for visual Demo">Primary</Button>

  <br /><br />
  <Button @variant="primary" @disabled="Disabled for visual Demo">Primary</Button>
  <Button @variant="secondary" @disabled="Disabled for visual Demo">Secondary</Button>
  <Button @variant="danger" @disabled="Disabled for visual Demo">Danger</Button>

  <br /><br />
  <Button
    @variant="primary"
    @disabled="You do not have permission to do this. You are missing the 'click-whatever-i-want' permission"
  >Primary</Button>
  <br /><br />
  <Button @variant="primary" @disabled={{Reasoning}}>Create Blog Post</Button>
  <Button @variant="primary">Create Blog Post</Button>
</template>
```

## Installation

```bash
pnpm add nullui
```

## API Reference

```gjs live
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/button.gts" @name="Signature" />
</template>
```

### State Attributes

none

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
