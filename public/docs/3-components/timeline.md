# Timeline

The `<Timeline />` component renders a vertical list of events or milestones. Each item can display an optional label (e.g. a date), an optional title, and freeform block content.

Items animate into view as they scroll into the viewport: the dot pops in, the content slides in from the left, and the connector line grows downward to the next item. Animations respect `prefers-reduced-motion`.

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline as |Item|>
    <Item @label="January 2025" @title="Project Kickoff">
      Initial planning and requirements gathering complete.
    </Item>
    <Item @label="February 2025" @title="Design Phase">
      Wireframes and mockups approved by stakeholders.
    </Item>
    <Item @label="March 2025" @title="Development">
      Core features implemented and unit tests written.
    </Item>
    <Item @label="April 2025" @title="Launch 🚀">
      Successfully shipped to production!
    </Item>
  </Timeline>
</template>
```

## Without labels

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";

<template>
  <Timeline as |Item|>
    <Item @title="Step one">
      Do the first thing.
    </Item>
    <Item @title="Step two">
      Do the second thing.
    </Item>
    <Item @title="Step three">
      All done!
    </Item>
  </Timeline>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Import

```js
import { Timeline } from "nvp.ui/timeline";
// or
import { Timeline, TimelineItem } from "nvp.ui";
```

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/timeline.gts" @name="TimelineSignature" />
</template>
```

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/timeline.gts" @name="TimelineItemSignature" />
</template>
```

### Styling

Public CSS custom properties on `.nvp__timeline`:

| Custom Property                  | Default                                            | Description                           |
| -------------------------------- | -------------------------------------------------- | ------------------------------------- |
| `--timeline-line-color`          | `color-mix(in oklab, currentColor 25%, transparent)` | Color of the connecting line        |
| `--timeline-dot-size`            | `0.75rem`                                          | Size (width & height) of the dot      |
| `--timeline-dot-color`           | `var(--color-primary)`                             | Fill color of the dot                 |
| `--timeline-dot-border-color`    | `var(--color-page-background)`                     | Border color of the dot               |
| `--timeline-dot-border-width`    | `2px`                                              | Border width of the dot               |
| `--timeline-line-width`          | `2px`                                              | Width of the vertical connector line  |
| `--timeline-gap`                 | `var(--gap-4)`                                     | Vertical gap between items            |
| `--timeline-content-gap`         | `var(--gap-2)`                                     | Gap between label, title, and body    |
| `--timeline-enter-duration`      | `0.45s`                                            | Duration of the content slide-in      |
| `--timeline-enter-easing`        | `cubic-bezier(0.22, 1, 0.36, 1)`                   | Easing for content slide-in           |
| `--timeline-dot-easing`          | `cubic-bezier(0.34, 1.56, 0.64, 1)`               | Easing for the dot pop (spring)       |
| `--timeline-line-duration`       | `0.6s`                                             | Duration of the connector line grow   |
| `--timeline-line-delay`          | `0.2s`                                             | Delay before the connector line starts growing |
| `--timeline-content-delay`       | `0.05s`                                            | Delay before content starts sliding in |

Public selectors:

| Selector                    | Description                                       |
| --------------------------- | ------------------------------------------------- |
| `.nvp__timeline`            | The outer `<ol>` list element                     |
| `.nvp__timeline__item`      | Each `<li>` timeline entry                        |
| `.nvp__timeline__item[data-visible]` | Added when the item enters the viewport  |
| `.nvp__timeline__marker`    | The marker column (contains the dot or icon)      |
| `.nvp__timeline__dot`       | The default circular dot indicator                |
| `.nvp__timeline__content`   | The content column (label, title, body)           |
| `.nvp__timeline__label`     | The optional label element (e.g. a date)          |
| `.nvp__timeline__title`     | The optional title element                        |
| `.nvp__timeline__body`      | Wrapper around the default block content          |
