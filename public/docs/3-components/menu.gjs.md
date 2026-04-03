# Menu

A dropdown menu with full keyboard navigation, variant theming, and keyboard shortcut hints. Built on `ember-primitives` Menu.

```gjs live preview no-shadow
import { Menu } from "nvp.ui";
import { PortalTargets } from "ember-primitives";

const noop = () => {};

<template>
  <PortalTargets />
  <div style="display: flex; gap: 1rem; align-items: start;">
    <Menu as |menu|>
      <menu.Trigger>Actions</menu.Trigger>
      <menu.Content as |Items|>
        <Items.Item @onSelect={{noop}}>New File</Items.Item>
        <Items.Item @onSelect={{noop}}>Open...</Items.Item>
        <Items.Item @onSelect={{noop}}>Save</Items.Item>
        <Items.Separator />
        <Items.Item @onSelect={{noop}}>Close</Items.Item>
      </menu.Content>
    </Menu>

    <Menu @variant="primary" as |menu|>
      <menu.Trigger>Primary</menu.Trigger>
      <menu.Content as |Items|>
        <Items.Item @onSelect={{noop}}>Deploy</Items.Item>
        <Items.Item @onSelect={{noop}}>Rollback</Items.Item>
      </menu.Content>
    </Menu>

    <Menu @variant="secondary" as |menu|>
      <menu.Trigger>Secondary</menu.Trigger>
      <menu.Content as |Items|>
        <Items.Item @onSelect={{noop}}>Edit</Items.Item>
        <Items.Item @onSelect={{noop}}>Duplicate</Items.Item>
      </menu.Content>
    </Menu>

    <Menu @variant="danger" as |menu|>
      <menu.Trigger>Danger</menu.Trigger>
      <menu.Content as |Items|>
        <Items.Item @onSelect={{noop}}>Delete</Items.Item>
        <Items.Item @onSelect={{noop}}>Reset</Items.Item>
      </menu.Content>
    </Menu>
  </div>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- Full keyboard navigation with arrow keys, Enter to select, Escape to close
- Keyboard shortcut hints displayed at the bottom of the open menu
- Hints are hidden on touch devices via `@media (pointer: coarse)`
- Menu trigger and items are focusable and keyboard-accessible

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/menu" @name="Signature" />
</template>
```

### State Attributes

|   attribute    | values                                      | description                  |
| :------------: | :------------------------------------------ | :--------------------------- |
| `data-variant` | `primary`, `secondary`, `danger`, `default` | Trigger button color variant |

### Styling

Public selectors:

|           key           | description                         |
| :---------------------: | :---------------------------------- |
|  `.nvp__menu__trigger`  | Trigger button                      |
|  `.nvp__menu__content`  | Dropdown content container          |
|   `.nvp__menu__item`    | Menu item button                    |
| `.nvp__menu__link-item` | Menu link item                      |
| `.nvp__menu__separator` | Visual separator line               |
| `.nvp__menu__kbd-hints` | Keyboard hint bar at bottom of menu |
