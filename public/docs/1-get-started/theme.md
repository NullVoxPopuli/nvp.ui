# Theme

Global theme is determined by [color-scheme](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/color-scheme) and synchronized to controllable CSS class behavior via the [ember-primitives utility](https://ember-primitives.pages.dev/6-utils/color-scheme.md) by the same name.

Then, at each DOM-level, the theme may be overridden via either the `Theme` component, or the `theme-dark` or `theme-light` classes.

The only benefit that the `Theme` component provides over the theme classes is setting the `color-scheme` _property_.

<div style="display: grid; gap: 1rem; grid-auto-flow: column;">

<div>

```gjs live preview no-shadow
import { Theme } from "nvp.ui/theme";
import { Button } from "nvp.ui/button";

<template>
  With the theme component:

  <Theme @name="light">
    light theme
    <Button>a button</Button>

    <Theme @name="dark">
      dark theme
      <Button>a button</Button>

      <Theme @name="light">
        light theme
        <Button>a button</Button>

        <Theme @name="dark">
          dark theme
          <Button>a button</Button>
        </Theme>
      </Theme>
    </Theme>
  </Theme>

  <style>
    @scope {
      div {
        border-radius: var(--radius);
        display: flex;
        flex-direction: column;
        gap: var(--gap);
        padding: var(--padding-4);
      }
    }
  </style>
</template>
```

</div>
<div>

```gjs live preview no-shadow
import { Theme } from "nvp.ui/theme";
import { Button } from "nvp.ui/button";

<template>
  With the theme classes:

  <div class="theme-light">
    light theme
    <Button>a button</Button>

    <div class="theme-dark">
      dark theme
      <Button>a button</Button>

      <div class="theme-light">
        light theme
        <Button>a button</Button>

        <div class="theme-dark">
          dark theme
          <Button>a button</Button>
        </div>
      </div>
    </div>
  </div>

  <style>
    @scope {
      div[class*="theme"] {
        border-radius: var(--radius);
        display: flex;
        flex-direction: column;
        gap: var(--gap);
        padding: var(--padding-4);
      }
    }
  </style>
</template>
```

</div>

</div>
