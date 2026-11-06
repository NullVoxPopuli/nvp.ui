# Tabbed Shell Script

Shows one shell script per tab.
Use it for a command that changes with the tool, for example the install command for each package manager.

Pass `@scripts`, an array with a `label` and a `script` for each tab.

```gjs live preview no-shadow
import { TabbedShellScript } from "nvp.ui/tabbed-shell-script";

const scripts = [
  { label: "pnpm", script: "pnpm add nvp.ui" },
  { label: "npm", script: "npm install nvp.ui" },
  { label: "yarn", script: "yarn add nvp.ui" },
];

<template><TabbedShellScript @scripts={{scripts}} /></template>
```

## Block

To write each tab in the template, use the block instead of `@scripts`.
The block yields `Tab`, which takes `@label` and `@script`.
Use `@scripts` or the block, not both.

```gjs live preview no-shadow
import { TabbedShellScript } from "nvp.ui/tabbed-shell-script";

<template>
  <TabbedShellScript as |Tab|>
    <Tab @label="pnpm" @script="pnpm add nvp.ui" />
    <Tab @label="npm" @script="npm install nvp.ui" />
    <Tab @label="yarn" @script="yarn add nvp.ui" />
  </TabbedShellScript>
</template>
```

## Multi-line scripts

Line breaks in a script show as line breaks.

```gjs live preview no-shadow
import { TabbedShellScript } from "nvp.ui/tabbed-shell-script";

const scripts = [
  { label: "pnpm", script: "pnpm install\npnpm test" },
  { label: "npm", script: "npm install\nnpm test" },
];

<template><TabbedShellScript @scripts={{scripts}} /></template>
```

## API Reference

### TabbedShellScript

`TabbedShellScript` takes one of these two signatures.

#### With `@scripts`

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/tabbed-shell-script"
    @name="ScriptsSignature"
  />
</template>
```

#### With a block

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/tabbed-shell-script"
    @name="BlockSignature"
  />
</template>
```

### Tab (yielded)

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature
    @package="."
    @module="declarations/components/tabbed-shell-script"
    @name="ShellTabSignature"
  />
</template>
```

### ShellScript

```gjs live no-shadow
import { APIDocs } from "kolay";

<template>
  <APIDocs @package="." @module="declarations/components/tabbed-shell-script" @name="ShellScript" />
</template>
```

### CSS Custom Properties

|           Property           |          Default          | Description                 |
| :--------------------------: | :-----------------------: | :-------------------------- |
| `--tabbed-shell-script-font` | `ui-monospace, monospace` | The font of the script text |

The tabs and the tab panel use the [Tabs](/Docs/3-components/tabs) styles.

### CSS Classes

|                Class                | Description                       |
| :---------------------------------: | :-------------------------------- |
| `.nvp__tabbed-shell-script__script` | The `<pre>` that holds the script |
