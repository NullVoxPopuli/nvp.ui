# Button

The accessible button is an improvement on the native `<button>` by providing additional information when disabled, tooltips, etc

```gjs live no-shadow
import { Button, ExternalLink } from "nvp.ui";
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
  <Button @variant="secondary" @disabled="Disabled for visual Demo">Secondary</Button>
  <Button @variant="danger" @disabled="Disabled for visual Demo">Danger</Button>

  <br /><br />
  <Button @variant="primary" @disabled={{Reasoning}}>Create Blog Post</Button>
  <Button @variant="primary">Create Blog Post</Button>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- The button is always focusable with both mouse and keyboard
- Usage of the `disabled` attribute is forbidden, as a button should explain _why_ it is disabled and ideally provided a call to action if the user can do something about that disabled state
- screen-reader users will be able to read the disabled reason's text after the contents of the button
  - sighted users have visual indication that a button may be disabled and hovering / focusing will reveal the reason
  - the disabled reason tooltip is focusable so that both mouse and keyboard users can interact with the tooltip

## API Reference

```gjs live no-shadow
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
