# Menu

A dropdown menu triggered by a button. Supports items, link items, and separators.

```gjs live no-shadow
import { Menu } from "nvp.ui";

<template>
  <Menu as |m|>
    <m.Trigger>
      Open Menu ▾
    </m.Trigger>

    <m.Content as |c|>
      <c.Item>Profile</c.Item>
      <c.Item>Settings</c.Item>
      <c.Separator />
      <c.Item>Sign out</c.Item>
    </m.Content>
  </Menu>
</template>
```

## With click handlers

```gjs live no-shadow
import { Menu } from "nvp.ui";

<template>
  <Menu as |m|>
    <m.Trigger>
      Actions ▾
    </m.Trigger>

    <m.Content as |c|>
      <c.Item @onSelect={{(fn (mut this) "Edit selected")}}>Edit</c.Item>
      <c.Item @onSelect={{(fn (mut this) "Delete selected")}}>Delete</c.Item>
    </m.Content>
  </Menu>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Follows the [WAI-ARIA Menu Button pattern](https://www.w3.org/WAI/ARIA/apg/patterns/menu-button/)
- The trigger has `aria-haspopup="menu"` and `aria-expanded` set automatically
- Arrow keys navigate between menu items
- `Escape` closes the menu

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/menu.gts" @name="Signature" />
</template>
```

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `.nvp__menu__content` | The dropdown menu panel |
| `.nvp__menu__item` | A menu item (button or link) |
| `.nvp__menu__separator` | A visual separator between items |
