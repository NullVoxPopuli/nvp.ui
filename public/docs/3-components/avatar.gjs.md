# Avatar

Display user profile images with graceful fallback to initials or icons. Group avatars together with an overlapping layout that expands on hover.

```gjs live preview no-shadow
import { Avatar, AvatarGroup } from "nvp.ui";

<template>
  <p><strong>Single Avatars</strong></p>
  <div style="display: flex; gap: 1rem; align-items: center;">
    <Avatar @src="/images/sc2/nova.jpg" @alt="Nova" @size="small">
      <:fallback>NO</:fallback>
    </Avatar>
    <Avatar @src="/images/sc2/kerrigan.jpg" @alt="Kerrigan">
      <:fallback>KE</:fallback>
    </Avatar>
    <Avatar @src="/images/sc2/artanis.jpg" @alt="Artanis" @size="large">
      <:fallback>AR</:fallback>
    </Avatar>
  </div>

  <p><strong>With Fallback (broken image)</strong></p>
  <div style="display: flex; gap: 1rem; align-items: center;">
    <Avatar @src="/broken.png" @alt="Default fallback" @size="small" />
    <Avatar @src="/broken.png" @alt="Raynor" @delayMs={{0}}>
      <:fallback>JR</:fallback>
    </Avatar>
    <Avatar @src="/broken.png" @alt="Zeratul" @size="large" @delayMs={{0}}>
      <:fallback>ZE</:fallback>
    </Avatar>
  </div>

  <p><strong>Avatar Group</strong></p>
  <AvatarGroup aria-label="StarCraft squad">
    <Avatar @src="/images/sc2/sarah-kerrigan.jpg" @alt="Sarah Kerrigan">
      <:fallback>SK</:fallback>
    </Avatar>
    <Avatar @src="/images/sc2/tassadar.jpg" @alt="Tassadar">
      <:fallback>TA</:fallback>
    </Avatar>
    <Avatar @src="/images/sc2/mira-han.jpg" @alt="Mira Han">
      <:fallback>MH</:fallback>
    </Avatar>
    <Avatar @src="/images/sc2/spectre.jpg" @alt="Spectre">
      <:fallback>SP</:fallback>
    </Avatar>
    <Avatar @src="/images/sc2/dark-voice.jpg" @alt="Dark Voice">
      <:fallback>DV</:fallback>
    </Avatar>
  </AvatarGroup>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Set `@alt` on each Avatar for screen reader descriptions
- AvatarGroup uses `role="group"` for semantic grouping
- The default SVG fallback has `aria-hidden="true"` so screen readers skip it

## API Reference

### Avatar

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/avatar"
    @name="AvatarSignature"
  />
</template>
```

### AvatarGroup

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/avatar"
    @name="AvatarGroupSignature"
  />
</template>
```

### State Attributes

|  attribute  | values                     | description                |
| :---------: | :------------------------- | :------------------------- |
| `data-size` | `small`, `medium`, `large` | Controls avatar dimensions |

### Styling

Public selectors:

|         key          | description                         |
| :------------------: | :---------------------------------- |
|    `.nvp__avatar`    | Root avatar element                 |
| `.nvp__avatar-group` | Group container with overlap layout |
