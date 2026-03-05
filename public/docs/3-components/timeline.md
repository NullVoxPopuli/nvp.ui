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

## Add items dynamically

New items animate in as they appear. Click **+ Add event** to see each item pop in with the dot, slide the content in, and draw the connector line down to the next one. **Clear** resets the list so you can replay.

```gjs live no-shadow
import { Timeline } from "nvp.ui/timeline";
import { cell } from "ember-resources";
import { on } from "@ember/modifier";

const EVENTS = [
  { label: "Jan 2025", title: "Project Kickoff",   body: "Requirements gathering complete." },
  { label: "Mar 2025", title: "Design Phase",       body: "Wireframes and mockups approved." },
  { label: "Jun 2025", title: "Development Sprint", body: "Core features implemented." },
  { label: "Sep 2025", title: "Beta Release 🧪",    body: "First beta shipped to early users." },
  { label: "Dec 2025", title: "Launch 🚀",          body: "Successfully shipped to production!" },
];

const items = cell([]);

function add() {
  const next = EVENTS[items.current.length];
  if (next) items.current = [...items.current, next];
}

function clear() {
  items.current = [];
}

const canAdd = () => items.current.length < EVENTS.length;

<template>
  <div style="display: flex; flex-direction: column; gap: 1rem; max-width: 32rem;">
    <div style="display: flex; gap: 0.5rem; flex-wrap: wrap; align-items: center;">
      <button
        type="button"
        disabled={{(unless (canAdd) true)}}
        {{on "click" add}}
        style="padding: 0.375rem 0.875rem; border-radius: 0.25rem; border: 1px solid currentColor; background: transparent; cursor: pointer; color: inherit; font: inherit;"
      >
        + Add event
      </button>
      <button
        type="button"
        {{on "click" clear}}
        style="padding: 0.375rem 0.875rem; border-radius: 0.25rem; border: 1px solid currentColor; background: transparent; cursor: pointer; color: inherit; font: inherit;"
      >
        Clear
      </button>
      <span style="opacity: 0.6; font-size: 0.8125rem;">
        {{items.current.length}} / {{EVENTS.length}} events
      </span>
    </div>

    {{#if items.current.length}}
      <Timeline as |Item|>
        {{#each items.current key="title" as |event|}}
          <Item @label={{event.label}} @title={{event.title}}>
            {{event.body}}
          </Item>
        {{/each}}
      </Timeline>
    {{else}}
      <p style="opacity: 0.5; font-style: italic; margin: 0;">
        Click "+ Add event" to build the timeline.
      </p>
    {{/if}}
  </div>
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
