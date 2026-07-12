# ToggleButton

A toggle button is a button with persistent on / off state (mute, loop, record-arm, etc).
It composes the [Button](/Docs/3-components/button) component, so disabled toggles
still explain _why_ they are disabled, and adds the `aria-pressed` attribute --
which is what tells assistive technology that the button is a toggle, and whether
that toggle is currently on.

```gjs live no-shadow
import { ToggleButton } from "nvp.ui";
import { PortalTargets } from "ember-primitives";
import { cell } from "ember-resources";

const muted = cell(false);
const toggleMuted = () => (muted.current = !muted.current);

<template>
  <PortalTargets />

  <ToggleButton @pressed={{muted.current}} @onClick={{toggleMuted}}>
    {{if muted.current "Muted 🔇" "Mute 🔊"}}
  </ToggleButton>

  <br /><br />
  <ToggleButton @pressed={{true}} @variant="primary">Primary</ToggleButton>
  <ToggleButton @pressed={{true}} @variant="secondary">Secondary</ToggleButton>
  <ToggleButton @pressed={{true}} @variant="danger">Danger</ToggleButton>

  <br /><br />
  <ToggleButton @pressed={{true}} @disabled="The audio engine has not started yet">
    Record
  </ToggleButton>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- screen-reader users hear the toggle state, e.g. "Mute, toggle button, pressed", per the [WAI-ARIA button pattern](https://www.w3.org/WAI/ARIA/apg/patterns/button/)
- everything from [Button](/Docs/3-components/button) applies: the toggle is always focusable, and the disabled reason is a focusable tooltip

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/toggle-button"
    @name="Signature"
  />
</template>
```

### State Attributes

|       key        | description                                 |
| :--------------: | :------------------------------------------ |
| `[aria-pressed]` | `"true"` or `"false"`, mirroring `@pressed` |

### Styling

Pressed toggles (`[aria-pressed="true"]`) render with the same held-down look as
an `:active` button.
