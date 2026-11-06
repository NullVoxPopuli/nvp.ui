# RangeSlider

A slider with two thumbs, for a range between a start and an end value:
a price range, a time window, or the loop of a media player.
It is a styled [`Slider` from ember-primitives](https://ember-primitives.pages.dev/3-ui/slider),
so each thumb is a native `<input type="range">`.

```gjs live preview no-shadow
import { RangeSlider } from "nvp.ui";
import { TrackedObject } from "tracked-built-ins";

const loop = new TrackedObject({ start: 12, end: 18 });
const update = (start, end) => {
  loop.start = start;
  loop.end = end;
};

const seconds = (value) => `${value.toFixed(1)}s`;

<template>
  <RangeSlider
    @label="Loop"
    @max={{60}}
    @step={{0.5}}
    @start={{loop.start}}
    @end={{loop.end}}
    @onChange={{update}}
    @formatValue={{seconds}}
  />

  <p>The loop plays from {{seconds loop.start}} to {{seconds loop.end}}.</p>
</template>
```

## Content on the track

The default block renders inside the track, under the thumbs.
`position` turns a value into a percentage of the track width,
for example to show a playhead.

```gjs live preview no-shadow
import { RangeSlider } from "nvp.ui";
import { TrackedObject } from "tracked-built-ins";
import { htmlSafe } from "@ember/template";

const loop = new TrackedObject({ start: 20, end: 70 });
const update = (start, end) => {
  loop.start = start;
  loop.end = end;
};

const at = (percent) => htmlSafe(`left: ${percent}%`);

<template>
  <RangeSlider
    @label="Loop"
    @max={{100}}
    @start={{loop.start}}
    @end={{loop.end}}
    @onChange={{update}}
    as |track|
  >
    <span class="playhead" style={{at (track.position 45)}}></span>
  </RangeSlider>

  <style>
    .playhead {
      position: absolute;
      inset-block: 0;
      width: 2px;
      background: currentColor;
      pointer-events: none;
    }
  </style>
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

Each thumb is a native `<input type="range">`, so it has the `slider` role,
per the [WAI-ARIA multi-thumb slider pattern](https://www.w3.org/WAI/ARIA/apg/patterns/slider-multithumb/).
The two thumbs are in a `group`, and `@label` names the group.
The browser gives the keys:

| key                       | action                         |
| :------------------------ | :----------------------------- |
| `ArrowLeft` / `ArrowDown` | one step lower                 |
| `ArrowRight` / `ArrowUp`  | one step higher                |
| `PageDown` / `PageUp`     | a bigger step lower / higher   |
| `Home`                    | to the lowest value it can go  |
| `End`                     | to the highest value it can go |

The thumbs cannot pass each other. They stay at least `@minGap` apart.

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/range-slider"
    @name="Signature"
  />
</template>
```

### State Attributes

|                key                 | description               |
| :--------------------------------: | :------------------------ |
|      `[data-part]` on a thumb      | `start` or `end`          |
| `[data-active]` on a thumb's input | the thumb that moved last |

### Styling

| CSS variable                        | default                  |
| :---------------------------------- | :----------------------- |
| `--range-slider-track-height`       | `0.5rem`                 |
| `--range-slider-thumb-width`        | `0.75rem`                |
| `--range-slider-thumb-height`       | `1.75rem`                |
| `--range-slider-track-color`        | `--color-text` at 15%    |
| `--range-slider-range-color`        | `--color-primary` at 60% |
| `--range-slider-thumb-color`        | `--color-primary`        |
| `--range-slider-thumb-border-color` | `--color-text` at 60%    |
