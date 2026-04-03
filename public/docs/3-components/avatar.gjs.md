# Avatar

Display user profile images with graceful fallback to initials or icons. Group avatars together with an overlapping layout that expands on hover.

```gjs live no-shadow
import { Avatar, AvatarGroup } from "nvp.ui";

<template>
  <p><strong>Single Avatars</strong></p>
  <div style="display: flex; gap: 1rem; align-items: center;">
    <Avatar @src="https://i.pravatar.cc/150?u=alice" @alt="Alice" @size="small">
      <:fallback>A</:fallback>
    </Avatar>
    <Avatar @src="https://i.pravatar.cc/150?u=bob" @alt="Bob">
      <:fallback>B</:fallback>
    </Avatar>
    <Avatar @src="https://i.pravatar.cc/150?u=carol" @alt="Carol" @size="large">
      <:fallback>C</:fallback>
    </Avatar>
  </div>

  <p><strong>With Fallback (broken image)</strong></p>
  <div style="display: flex; gap: 1rem; align-items: center;">
    <Avatar @src="/broken.png" @alt="Default fallback" @size="small" />
    <Avatar @src="/broken.png" @alt="With initials" @delayMs={{0}}>
      <:fallback>NV</:fallback>
    </Avatar>
    <Avatar @src="/broken.png" @alt="Large initials" @size="large" @delayMs={{0}}>
      <:fallback>XY</:fallback>
    </Avatar>
  </div>

  <p><strong>Avatar Group</strong></p>
  <AvatarGroup aria-label="Team members">
    <Avatar @src="https://i.pravatar.cc/150?u=1" @alt="User 1">
      <:fallback>U1</:fallback>
    </Avatar>
    <Avatar @src="https://i.pravatar.cc/150?u=2" @alt="User 2">
      <:fallback>U2</:fallback>
    </Avatar>
    <Avatar @src="https://i.pravatar.cc/150?u=3" @alt="User 3">
      <:fallback>U3</:fallback>
    </Avatar>
    <Avatar @src="https://i.pravatar.cc/150?u=4" @alt="User 4">
      <:fallback>U4</:fallback>
    </Avatar>
    <Avatar @src="https://i.pravatar.cc/150?u=5" @alt="User 5">
      <:fallback>U5</:fallback>
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
  <ComponentSignature @package="." @module="declarations/components/avatar" @name="AvatarSignature" />
</template>
```

### AvatarGroup

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/avatar" @name="AvatarGroupSignature" />
</template>
```

### State Attributes

| attribute | values | description |
| :-------: | :----- | :---------- |
| `data-size` | `small`, `medium`, `large` | Controls avatar dimensions |

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `.nvp__avatar` | Root avatar element |
| `.nvp__avatar-group` | Group container with overlap layout |
