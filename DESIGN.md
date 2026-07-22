# Design

The design reference for `nvp.ui` — for humans and AI agents building apps with this kit,
following the [DESIGN.md](https://getdesign.md) convention.

Every value in this document comes from
[`src/components/variables.css`](https://github.com/NullVoxPopuli/nvp.ui/blob/main/src/components/variables.css).
When this document and that CSS disagree, the CSS wins.
On [the docs site](https://nullui.vercel.app/Docs/1-get-started/design), the code blocks below
render as live demos, driven by the real tokens.

## Identity

Professional and sleek.
Gently rounded corners, hairline borders, high-contrast system typography, restrained motion.
Depth comes from surface color-mixing and drop shadows — not gradients, blur, or decoration.

## Principles

1. **Tokens first.** Every color, radius, spacing, shadow, and duration is a CSS custom property.
   Never hardcode a hex value or pixel size in app CSS — reference a token, or derive from one with `color-mix()`.
2. **Structure comes from surfaces, not lines.** Borders are hairline and low-contrast — in light
   mode `--border-color` (`#efefef`) barely departs from the page background — so separation between
   regions reads primarily through surface shading and elevation, with borders as a quiet assist.
3. **Derive, don't invent.** Hover, pressed, and disabled states are `color-mix()` transformations of base
   tokens, not new colors — for example, hover mixes 30% of `--button-hover-color-mix` into a button's background.
4. **Light and dark are equals.** Every color token has a value in both themes. Theme is driven by
   `color-scheme` and may be overridden at any DOM level via the `Theme` component or the
   `theme-light` / `theme-dark` classes. Because class-based theming is in play, `light-dark()` cannot be
   used for anything that must respond to those classes.
5. **Accessibility is part of the aesthetic.** The two-layer focus ring, `prefers-reduced-motion`
   support, and disabled-reason tooltips are styled deliberately — never suppress them.

## Color

| Token                     | Light     | Dark      | Use                                      |
| ------------------------- | --------- | --------- | ---------------------------------------- |
| `--color-page-background` | `#eee`    | `#111`    | Page base; surfaces derive from this     |
| `--color-text`            | `#121212` | `#ffffff` | Body text                                |
| `--color-primary`         | `#88cdff` | `#00cdff` | Primary actions, accents, `accent-color` |
| `--color-secondary`       | `#aaaaff` | `#5555ff` | Secondary actions                        |
| `--color-danger`          | `#ff66bb` | `#ee0055` | Destructive actions                      |
| `--border-color`          | `#efefef` | `#222`    | Hairline structural borders              |

Accents are cool and saturated (cyan / periwinkle / pink) against near-neutral backgrounds.
Don't introduce new hues — mix from these tokens.
Both themes, same swatches — the values come from the tokens:

```gjs live preview no-shadow
import { Theme } from "nvp.ui/theme";

const Swatches = <template>
  <div class="swatch-row">
    <div class="swatch" style="background: var(--color-page-background)">page-background</div>
    <div
      class="swatch"
      style="background: var(--color-text); color: var(--color-page-background)"
    >text</div>
    <div class="swatch" style="background: var(--color-primary); color: #121212">primary</div>
    <div class="swatch" style="background: var(--color-secondary); color: #121212">secondary</div>
    <div class="swatch" style="background: var(--color-danger); color: #121212">danger</div>
    <div class="swatch" style="background: var(--border-color)">border</div>
  </div>
</template>;

<template>
  <Theme @name="light"><Swatches /></Theme>
  <Theme @name="dark"><Swatches /></Theme>

  <style>
    @scope {
      .swatch-row {
        display: flex;
        flex-wrap: wrap;
        gap: var(--gap-2);
        padding: var(--padding-4);
      }
      .swatch {
        border: var(--border-width) var(--border-style) var(--border-color);
        border-radius: var(--radius);
        padding: var(--padding-2) var(--padding-3);
        font-size: 80%;
      }
    }
  </style>
</template>
```

### Surfaces instead of panel colors

Never pick a background color for a panel, card, or popover. Use the `surface` class:
each level of `.surface` nesting mixes a few percent more white into `--color-page-background`
(via `color-mix(in oklab, ...)`), so elements "closer to the viewer" are automatically lighter.
Pair with an elevation class — `elevation-sm` through `elevation-xl2` — when a layer should
feel lifted off the one beneath it (bigger distance → bigger `drop-shadow`).

```gjs live preview no-shadow
<template>
  <div class="surface">
    surface
    <div class="surface">
      nested surface
      <div class="surface elevation-md">
        nested again, with elevation-md
      </div>
    </div>
  </div>

  <style>
    @scope {
      div {
        padding: var(--padding-4);
        border: var(--border-width) var(--border-style) var(--border-color);
        border-radius: var(--radius);
      }
    }
  </style>
</template>
```

## Typography

- Text: `--font: ui-sans-serif, sans-serif` — the platform's UI font, no webfonts.
- Code: the browser's default monospace stack; there is no mono token (yet).
- Baseline: `--line-height: 1.5rem`.

```gjs live preview no-shadow
<template>
  <p>The platform's own sans-serif, high contrast against the page — with
    <code>inline code</code>
    in the browser's monospace.</p>

  <style>
    @scope {
      p {
        font-family: var(--font);
        line-height: var(--line-height);
        padding: var(--padding-2);
      }
    }
  </style>
</template>
```

## Spacing

A `0.25rem` scale, exposed as parallel `gap` and `padding` tokens:

| Step | Value     | Tokens                    |
| ---- | --------- | ------------------------- |
| 1    | `0.25rem` | `--gap-1` / `--padding-1` |
| 2    | `0.5rem`  | `--gap-2` / `--padding-2` |
| 3    | `0.75rem` | `--gap-3` / `--padding-3` |
| 4    | `1rem`    | `--gap-4` / `--padding-4` |

`--gap` defaults to step 1 and `--padding` to step 2. Off-scale spacing should be computed
from the scale (e.g. `calc(2 * var(--padding-4))`), not written as a new literal.

```gjs live preview no-shadow
<template>
  <div class="steps">
    <span style="padding: var(--padding-1)">padding-1</span>
    <span style="padding: var(--padding-2)">padding-2</span>
    <span style="padding: var(--padding-3)">padding-3</span>
    <span style="padding: var(--padding-4)">padding-4</span>
  </div>

  <style>
    @scope {
      .steps {
        display: flex;
        align-items: flex-start;
        flex-wrap: wrap;
        gap: var(--gap-2);
        padding: var(--padding-2);
      }
      span {
        border: var(--border-width) var(--border-style) var(--border-color);
        border-radius: var(--radius);
        background: var(--surface-background-color, var(--color-page-background));
        font-size: 80%;
      }
    }
  </style>
</template>
```

## Shape and borders

- `--radius: 0.25rem` — gently rounded, never pill-shaped. Every component derives its corners
  from this one token, so changing it once on `:root` re-shapes the whole kit. Do not adjust the
  radius of individual components.
- Borders are `--border-width: 1px` `--border-style: solid` in `--border-color`.

The same component under three values of `--radius` — reshaping is a one-token decision:

```gjs live preview no-shadow
import { Button } from "nvp.ui/button";

<template>
  <div class="radii">
    <span style="--radius: 0"><Button>--radius: 0</Button></span>
    <span><Button>default (0.25rem)</Button></span>
    <span style="--radius: 1rem"><Button>--radius: 1rem</Button></span>
  </div>

  <style>
    @scope {
      .radii {
        display: flex;
        flex-wrap: wrap;
        gap: var(--gap-4);
        padding: var(--padding-4);
      }
    }
  </style>
</template>
```

## Interaction

- **Focus** is a two-layer ring: a 2px inner ring in `--ring-inner-color` (white in light, black in
  dark) and a `--ring-size` outer ring in `--ring-color`. It appears on `:focus-visible` only.
  Because of the ring's size, every interactive element needs at least 4px (`--padding-1`) of space
  between it and any hard boundary.
- **Hover / press** shift color via `color-mix()` and shrink/grow a 1px shadow spread — motion is
  in color and depth, not position. Pressed (`:active`, `[aria-pressed="true"]`) mixes toward black
  to look held down.
- **Disabled** is expressed as `[aria-disabled]` (still focusable, still hoverable), desaturated
  toward `--color-disable-mix` — and a disabled control explains itself: `Button`'s `@disabled`
  takes the _reason_, shown as a tooltip.
- **Motion**: transitions fade over `--fade-duration` (0.125s), which drops to 0s under
  `prefers-reduced-motion`. Nothing animates position; nothing loops.
- **Layering**: use the z-index scale — `--z-hover: 10`, `--z-focused: 11`, `--z-site-nav: 50`.
  Don't mint new z-index values.

Hover for the color shift, Tab through for the focus ring, and hover the disabled button for its reason:

```gjs live preview no-shadow
import { Button } from "nvp.ui/button";
import { PortalTargets } from "ember-primitives";

<template>
  <PortalTargets />
  <div class="states">
    <Button>Default</Button>
    <Button @variant="primary">Primary</Button>
    <Button @variant="secondary">Secondary</Button>
    <Button @variant="danger">Danger</Button>
    <Button
      @variant="primary"
      @disabled="Disabled, with the reason shown as a tooltip"
    >Disabled</Button>
  </div>

  <style>
    @scope {
      .states {
        display: flex;
        flex-wrap: wrap;
        gap: var(--gap-2);
        padding: var(--padding-4);
      }
    }
  </style>
</template>
```

## Gradients

Two exist, for hero/marketing moments only: `--gradient-hero` (blue → violet sweep) and
`--gradient-featured` (violet → indigo). Everything else is flat color.

```gjs live preview no-shadow
<template>
  <div class="bars">
    <div style="background: var(--gradient-hero)">--gradient-hero</div>
    <div style="background: var(--gradient-featured)">--gradient-featured</div>
  </div>

  <style>
    @scope {
      .bars {
        display: grid;
        gap: var(--gap-2);
        padding: var(--padding-2);
      }
      .bars > div {
        border-radius: var(--radius);
        color: white;
        padding: var(--padding-2) var(--padding-3);
      }
    }
  </style>
</template>
```

## Components

Reach for the kit before writing markup: `ApplicationShell`, `Avatar`, `BrowserWindow`, `Button`,
`ExternalLink`, `Header`, `Menu`, `Navigation`, `NavigationList`, `PoliteSticky`, `ProgressCircle`,
`Tabs`, `Theme`, `ThemeToggle`, `Timeline`, `ToggleButton` — each importable from its subpath
(e.g. `import { Button } from "nvp.ui/button";`). They already consume every token above, so a
correctly-themed app mostly means composing them and setting tokens.

Variants are args that map onto attributes (`<Button @variant="primary">` renders
`data-variant="primary"`), state is expressed through `aria-*` attributes, and native
attributes/modifiers are forwarded through `...attributes` — not framework-specific args.

## Don't

- Don't hardcode colors, radii, spacing, shadows, or durations — use the tokens.
- Don't pick panel backgrounds — nest `.surface`.
- Don't add webfonts.
- Don't use `light-dark()` where class-based theming must work.
- Don't remove or shrink focus rings, and don't crowd interactives within 4px of a hard edge.
- Don't animate position or add looping animation.
