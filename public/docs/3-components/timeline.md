# Timeline

A timeline component built on CSS grid + subgrid. Supports vertical activity feeds, horizontal steppers, status indicators, and inline expanded content.

## Vertical

Use `@indicator` for a compact syntax with the default block for content.

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline as |Item|>
    <Item @status="complete" @indicator="&#x2714;">
      <strong>alice</strong>
      approved these changes
      <div class="meta">Today</div>
    </Item>

    <Item @status="complete" @indicator="&#x1F3F7;">
      <strong>bob</strong>
      added tag
      <code>feature</code>
      <div class="meta">2 days ago</div>
    </Item>

    <Item @status="current" @indicator="&#x25B6;">
      <strong>ci</strong>
      running deploy pipeline
      <div class="meta">Just now</div>
    </Item>

    <Item @indicator="&#x1F680;">
      Release to production
      <div class="meta">Pending</div>
    </Item>
  </Timeline>

  <style>
    @scope {
      .meta {
        font-size: 0.8rem;
        opacity: 0.6;
        margin-top: 0.25rem;
      }
      code {
        background: light-dark(#f0f0f0, #333);
        padding: 0.1em 0.4em;
        border-radius: 0.25rem;
        font-size: 0.85em;
      }
    }
  </style>
</template>
```

## Named blocks

For more control, use `<:indicator>` and `<:content>` named blocks instead.

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline as |Item|>
    <Item @status="complete">
      <:indicator>&#x2714;</:indicator>
      <:content>
        <strong>alice</strong>
        approved these changes
      </:content>
    </Item>
    <Item @status="current">
      <:indicator>&#x25B6;</:indicator>
      <:content>
        <strong>ci</strong>
        running deploy pipeline
      </:content>
    </Item>
  </Timeline>
</template>
```

## Plain dots

Omit `@indicator` and the `<:indicator>` block for a simple dot style.

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline as |Item|>
    <Item @status="complete">
      <:content>Project kickoff</:content>
    </Item>
    <Item @status="complete">
      <:content>Design review</:content>
    </Item>
    <Item @status="current">
      <:content>Implementation</:content>
    </Item>
    <Item>
      <:content>Launch</:content>
    </Item>
  </Timeline>
</template>
```

## Inline block content

Use the `<:block>` named block for expanded content (comments, cards, details). It aligns to the content column via CSS subgrid.

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline as |Item|>
    <Item @status="complete">
      <:indicator>&#x1F441;</:indicator>
      <:content>
        <strong>curtisss</strong>
        requested a review from
        <strong>james_rob</strong>
        <div class="meta">4 days ago</div>
      </:content>
    </Item>

    <Item @status="complete">
      <:indicator>&#x1F4AC;</:indicator>
      <:content>
        <strong>james_rob</strong>
        commented
        <div class="meta">4 days ago</div>
      </:content>
      <:block>
        <div class="comment-card">
          Contrast slider goes a bit wild on the edges. Might want to clamp the range.
        </div>
      </:block>
    </Item>

    <Item @status="complete">
      <:indicator>&#x2714;</:indicator>
      <:content>
        <strong>james_rob</strong>
        approved these changes
        <div class="meta">Today</div>
      </:content>
    </Item>
  </Timeline>

  <style>
    @scope {
      .meta {
        font-size: 0.8rem;
        opacity: 0.6;
        margin-top: 0.25rem;
      }
      .comment-card {
        background: light-dark(#f8f8f8, #1a1a1a);
        border: 1px solid light-dark(#e4e4e7, #3f3f46);
        border-radius: 0.5rem;
        padding: 0.75rem 1rem;
        font-size: 0.9rem;
        margin-top: 0.25rem;
      }
    }
  </style>
</template>
```

## Horizontal

Use `@horizontal={{true}}` for a stepper or progress tracker layout.

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline @horizontal={{true}} as |Item|>
    <Item @status="complete" @indicator="&#x1F4B3;">Confirmed</Item>
    <Item @status="current" @indicator="&#x1F69A;">On its way</Item>
    <Item @indicator="&#x1F3E0;">Delivered</Item>
  </Timeline>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Anatomy

```js
import { Timeline } from "nvp.ui/timeline";
```

```gjs
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline as |Item|>
    <Item @status="complete" @indicator="✓">
      Description goes here
    </Item>
  </Timeline>
</template>
```

## Status vs indicator

`@status` and `<:indicator>` control different things:

- **`@status`** sets the dot's **color** — green for `complete`, primary for `current`, neutral for `incomplete`
- **`<:indicator>`** sets the dot's **content** — an icon, emoji, or text rendered inside it

They're independent. You can combine any status color with any icon, or omit the indicator for a plain dot.

## API Reference

### Timeline

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/timeline.gts"
    @name="TimelineSignature"
  />
</template>
```

### Item (yielded)

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/timeline.gts"
    @name="ItemSignature"
  />
</template>
```

### CSS Custom Properties

|          Property           |             Default             | Description                       |
| :-------------------------: | :-----------------------------: | :-------------------------------- |
|   `--timeline-line-color`   | `light-dark(#d4d4d8, #3f3f46)`  | Color of the connecting line      |
|   `--timeline-line-width`   |              `2px`              | Width of the connecting line      |
|    `--timeline-dot-size`    |            `2.25rem`            | Diameter of the indicator dot     |
|     `--timeline-dot-bg`     | `light-dark(#f4f4f5, #27272a)`  | Background of the default dot     |
|   `--timeline-dot-border`   | `light-dark(#e4e4e7, #3f3f46)`  | Border color of the default dot   |
|  `--timeline-content-gap`   |             `1rem`              | Gap between indicator and content |
|    `--timeline-item-gap`    |            `0.5rem`             | Vertical spacing between items    |
| `--timeline-complete-color` |            `#22c55e`            | Color for complete status         |
| `--timeline-current-color`  | `var(--color-primary, #3b82f6)` | Color for current status          |

### CSS Classes

|            Class            | Description                                  |
| :-------------------------: | :------------------------------------------- |
|      `.nvp__timeline`       | The grid container                           |
|   `.nvp__timeline__item`    | A single timeline entry (subgrid row)        |
| `.nvp__timeline__indicator` | The indicator column (draws connecting line) |
|    `.nvp__timeline__dot`    | The circular dot/icon                        |
|  `.nvp__timeline__content`  | The content area                             |
|   `.nvp__timeline__block`   | Expanded inline block (subgrid-aligned)      |
