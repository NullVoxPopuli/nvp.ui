# Avatar

Display user profile images with graceful fallback to initials or icons. Group avatars together with an overlapping layout that expands on hover.

```gjs live no-shadow
import { Avatar, AvatarGroup } from "nvp.ui";

<template>
  <p><strong>Single Avatars</strong></p>
  <div style="display: flex; gap: 1rem; align-items: center;">
    <Avatar
      @src="https://robohash.org/zergling?set=set2&size=150x150"
      @alt="Zergling"
      @size="small"
    >
      <:fallback>ZL</:fallback>
    </Avatar>
    <Avatar @src="https://robohash.org/hydralisk?set=set2&size=150x150" @alt="Hydralisk">
      <:fallback>HY</:fallback>
    </Avatar>
    <Avatar
      @src="https://robohash.org/ultralisk?set=set2&size=150x150"
      @alt="Ultralisk"
      @size="large"
    >
      <:fallback>UL</:fallback>
    </Avatar>
  </div>

  <p><strong>With Fallback (broken image)</strong></p>
  <div style="display: flex; gap: 1rem; align-items: center;">
    <Avatar @src="/broken.png" @alt="Default fallback" @size="small" />
    <Avatar @src="/broken.png" @alt="Mutalisk" @delayMs={{0}}>
      <:fallback>MU</:fallback>
    </Avatar>
    <Avatar @src="/broken.png" @alt="Brood Lord" @size="large" @delayMs={{0}}>
      <:fallback>BL</:fallback>
    </Avatar>
  </div>

  <p><strong>Avatar Group</strong></p>
  <AvatarGroup aria-label="Zerg swarm">
    <Avatar @src="https://robohash.org/drone?set=set2&size=150x150" @alt="Drone">
      <:fallback>DR</:fallback>
    </Avatar>
    <Avatar @src="https://robohash.org/overlord?set=set2&size=150x150" @alt="Overlord">
      <:fallback>OV</:fallback>
    </Avatar>
    <Avatar @src="https://robohash.org/queen?set=set2&size=150x150" @alt="Queen">
      <:fallback>QN</:fallback>
    </Avatar>
    <Avatar @src="https://robohash.org/infestor?set=set2&size=150x150" @alt="Infestor">
      <:fallback>IN</:fallback>
    </Avatar>
    <Avatar @src="https://robohash.org/roach?set=set2&size=150x150" @alt="Roach">
      <:fallback>RO</:fallback>
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
