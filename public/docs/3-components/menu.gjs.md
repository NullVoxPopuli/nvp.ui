# Menu

A dropdown menu with full keyboard navigation, variant theming, and keyboard shortcut hints. Built on `ember-primitives` Menu.

```gjs live preview no-shadow
import { Menu } from "nvp.ui";

const noop = () => {};

<template>
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

## Account switcher

A real-world composition: a sidebar's account switcher. The `bare`
variant removes the trigger's button chrome so it aligns flush with
the navigation around it, and `LinkItem` keeps switching as plain
navigation — the current account is marked with `aria-current`.

```gjs live preview no-shadow
import { Menu, Navigation, NavigationList } from "nvp.ui";

const accounts = [
  { slug: "nullvoxp", name: "NullVoxPopuli", current: true },
  { slug: "glimdown", name: "glimdown", current: false },
];

<template>
  <div style="max-width: 14rem;">
    <Navigation aria-label="Example sidebar">
      <Menu @variant="bare" as |menu|>
        <menu.Trigger style="width: 100%" aria-label="Switch account">
          NullVoxPopuli
        </menu.Trigger>

        <menu.Content as |Items|>
          {{#each accounts as |account|}}
            <Items.LinkItem @href="#{{account.slug}}" aria-current={{if account.current "true"}}>
              {{account.name}}
            </Items.LinkItem>
          {{/each}}
        </menu.Content>
      </Menu>

      <NavigationList @label="Manage">
        <li><a href="#links">Links</a></li>
        <li><a href="#users">Users</a></li>
      </NavigationList>
    </Navigation>
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

|   attribute    | values                                              | description                                                     |
| :------------: | :-------------------------------------------------- | :-------------------------------------------------------------- |
| `data-variant` | `primary`, `secondary`, `danger`, `default`, `bare` | Trigger button color variant (`bare` removes the button chrome) |

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
