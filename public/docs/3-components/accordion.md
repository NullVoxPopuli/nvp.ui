# Accordion

A vertically stacked set of interactive headings that each reveal a section of content.

```gjs live no-shadow
import { Accordion } from "nvp.ui";

<template>
  <Accordion @type="single" @collapsible={{true}}>
    <:default as |a|>
      <a.Item @value="item-1" as |i|>
        <i.Header as |h|>
          <h.Trigger>
            What is nvp.ui?
          </h.Trigger>
        </i.Header>
        <i.Content>
          nvp.ui is a UI kit for building professional and sleek looking Ember apps quickly.
        </i.Content>
      </a.Item>

      <a.Item @value="item-2" as |i|>
        <i.Header as |h|>
          <h.Trigger>
            What is ember-primitives?
          </h.Trigger>
        </i.Header>
        <i.Content>
          ember-primitives is the underlying unstyled component library that powers most of the behaviors in this design system.
        </i.Content>
      </a.Item>

      <a.Item @value="item-3" as |i|>
        <i.Header as |h|>
          <h.Trigger>
            Is it accessible?
          </h.Trigger>
        </i.Header>
        <i.Content>
          Yes! All components strive to follow WAI-ARIA patterns.
        </i.Content>
      </a.Item>
    </:default>
  </Accordion>
</template>
```

### Multiple

```gjs live no-shadow
import { Accordion } from "nvp.ui";

<template>
  <Accordion @type="multiple">
    <:default as |a|>
      <a.Item @value="item-1" as |i|>
        <i.Header as |h|>
          <h.Trigger>
            First item
          </h.Trigger>
        </i.Header>
        <i.Content>
          First content. Multiple items can be open at the same time.
        </i.Content>
      </a.Item>

      <a.Item @value="item-2" as |i|>
        <i.Header as |h|>
          <h.Trigger>
            Second item
          </h.Trigger>
        </i.Header>
        <i.Content>
          Second content. Multiple items can be open at the same time.
        </i.Content>
      </a.Item>
    </:default>
  </Accordion>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/accordion.gts" @name="Signature" />
</template>
```

### State Attributes

| Attribute | Values | Description |
| :-------- | :----- | :---------- |
| `data-state` | `open` \| `closed` | Present on each item header, trigger, and content |
| `data-disabled` | `''` | Present when the accordion or item is disabled |

### Styling

Public selectors:

| key | description |
| :-: | :---------- |
| `.nvp__accordion` | The root container |
| `.nvp__accordion__item` | An individual accordion item |
| `.nvp__accordion__header` | The heading wrapper |
| `.nvp__accordion__trigger` | The clickable button that opens/closes an item |
| `.nvp__accordion__chevron` | The rotating chevron icon |
| `.nvp__accordion__content` | The content panel |
