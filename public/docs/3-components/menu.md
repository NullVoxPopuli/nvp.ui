# Menu

An accessible dropdown menu component built on top of ember-primitives Menu. Provides a styled, keyboard-navigable menu with support for items, links, and separators.

```gjs live no-shadow
import { Menu } from "nvp.ui/menu";

<template>
  <Menu as |menu|>
    <menu.Trigger>
      Open Menu
    </menu.Trigger>

    <menu.Content as |Items|>
      <Items.Item>
        New File
      </Items.Item>
      <Items.Item>
        Open...
      </Items.Item>
      <Items.Item>
        Save
      </Items.Item>

      <Items.Separator />

      <Items.Item>
        Exit
      </Items.Item>
    </menu.Content>
  </Menu>
</template>
```

## With Variants

The menu trigger button supports the same variants as the Button component:

```gjs live no-shadow
import { Menu } from "nvp.ui/menu";

<template>
  <Menu as |menu|>
    <menu.Trigger>Default</menu.Trigger>
    <menu.Content as |Items|>
      <Items.Item>Action 1</Items.Item>
      <Items.Item>Action 2</Items.Item>
    </menu.Content>
  </Menu>

  <Menu @variant="primary" as |menu|>
    <menu.Trigger>Primary</menu.Trigger>
    <menu.Content as |Items|>
      <Items.Item>Action 1</Items.Item>
      <Items.Item>Action 2</Items.Item>
    </menu.Content>
  </Menu>

  <Menu @variant="secondary" as |menu|>
    <menu.Trigger>Secondary</menu.Trigger>
    <menu.Content as |Items|>
      <Items.Item>Action 1</Items.Item>
      <Items.Item>Action 2</Items.Item>
    </menu.Content>
  </Menu>

  <Menu @variant="danger" as |menu|>
    <menu.Trigger>Danger</menu.Trigger>
    <menu.Content as |Items|>
      <Items.Item>Delete</Items.Item>
      <Items.Item>Remove</Items.Item>
    </menu.Content>
  </Menu>
</template>
```

## With Links

Use LinkItem for navigation:

```gjs live no-shadow
import { Menu } from "nvp.ui/menu";

<template>
  <Menu as |menu|>
    <menu.Trigger>
      Navigation
    </menu.Trigger>

    <menu.Content as |Items|>
      <Items.LinkItem @href="/">
        Home
      </Items.LinkItem>
      <Items.LinkItem @href="/1-get-started/intro">
        Intro
      </Items.LinkItem>

      <Items.Separator />

      <Items.LinkItem @href="/3-components/menu">
        Menu
      </Items.LinkItem>
    </menu.Content>
  </Menu>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Full keyboard navigation support (Arrow keys, Enter, Escape)
- Automatic focus management
- ARIA attributes for screen readers
- Follows WAI-ARIA Menu pattern
- Menu closes on outside clicks and Escape key
- Items can be focused with both mouse and keyboard

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/menu.gts" @name="Signature" />
</template>
```

### Placement Options

The `@placement` argument controls where the menu appears relative to the trigger:

- `top`, `top-start`, `top-end`
- `bottom`, `bottom-start`, `bottom-end` (default: `bottom-start`)
- `left`, `left-start`, `left-end`
- `right`, `right-start`, `right-end`

### Variants

The `@variant` argument controls the trigger button appearance:

- `default` - Default button styling
- `primary` - Primary action styling
- `secondary` - Secondary action styling
- `danger` - Destructive action styling

### Styling

Public selectors:

|           key           | description                     |
| :---------------------: | :------------------------------ |
|  `.nvp__menu__trigger`  | The menu trigger button         |
|  `.nvp__menu__content`  | The menu content container      |
|   `.nvp__menu__item`    | Individual menu items and links |
| `.nvp__menu__separator` | Separator between menu items    |
