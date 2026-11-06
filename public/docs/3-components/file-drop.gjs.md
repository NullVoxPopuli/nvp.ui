# FileDrop

A drop zone for files from the user's disk.
A click anywhere in the zone opens the file picker.
The files stay in the browser: nothing is uploaded.

It is a styled [`FileDrop` from ember-primitives](https://ember-primitives.pages.dev/3-ui/file-drop).
To take files dropped anywhere on the page, use `DocumentFileDrop` from the same page.

```gjs live preview no-shadow
import { FileDrop } from "nvp.ui";
import { cell } from "ember-resources";

const picked = cell([]);
const take = (files) => (picked.current = files);

<template>
  <FileDrop @multiple={{true}} @onFiles={{take}} />

  <ul>
    {{#each picked.current as |file|}}
      <li>{{file.name}} ({{file.size}} bytes)</li>
    {{/each}}
  </ul>
</template>
```

## Only some files

`@accept` uses the syntax of the `accept` attribute of a file input.
The file picker shows only those files, and a drop of other files is ignored.

The default block replaces the text in the zone.
`isDragging` is `true` while files are over the zone.

```gjs live preview no-shadow
import { FileDrop } from "nvp.ui";
import { cell } from "ember-resources";

const video = cell();
const take = (files) => (video.current = files[0]);

<template>
  <FileDrop @accept="video/*" @onFiles={{take}} as |zone|>
    {{#if zone.isDragging}}
      Let go to load the video
    {{else}}
      Drop a video here, or click to choose one
    {{/if}}
  </FileDrop>

  {{#if video.current}}
    <p>Loaded {{video.current.name}}</p>
  {{/if}}
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## Accessibility

- The zone is a `<label>` for a real file `<input>`, so the text in the zone names the input.
- The input is out of view, but it is in the tab order. The zone shows the focus ring.
- `Enter` or `Space` on the focused input opens the file picker.

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/file-drop" @name="Signature" />
</template>
```

### State Attributes

|        key        | description                         |
| :---------------: | :---------------------------------- |
| `[data-dragging]` | present while files are over a zone |

### Styling

| CSS variable               | default               |
| :------------------------- | :-------------------- |
| `--file-drop-border-color` | `--color-text` at 35% |
| `--file-drop-active-color` | `--color-primary`     |
| `--file-drop-padding`      | `--padding-4`         |
