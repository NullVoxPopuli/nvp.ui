---
version: 1
name: nvp-ui-design
description: A professional, sleek interface system for Ember apps. Gently rounded corners, hairline low-contrast borders, high-contrast system typography, and restrained fade-only motion. Depth comes from surface color-mixing and drop shadows — never gradients, blur, or decoration. Light and dark are equal first-class themes, driven by color-scheme with per-subtree overrides. Every token below is a CSS custom property from src/components/variables.css (colors.primary is --color-primary, rounded.radius is --radius, and so on); when this file and that CSS disagree, the CSS wins.

colors:
  page-background: "#eeeeee"
  text: "#121212"
  primary: "#88cdff"
  secondary: "#aaaaff"
  danger: "#ff66bb"
  border: "#efefef"
  button: "rgb(220, 220, 220)"
  header-background: "#ffffff"
  disable-mix: "#bbbbbb"
  ring: "rgb(100, 100, 224)"
  ring-inner: "#ffffff"

colors-dark:
  page-background: "#111111"
  text: "#ffffff"
  primary: "#00cdff"
  secondary: "#5555ff"
  danger: "#ee0055"
  border: "#222222"
  button: "rgb(100, 100, 100)"
  header-background: "#111111"
  disable-mix: "#000000"
  ring: "rgb(224, 78, 57)"
  ring-inner: "#000000"

typography:
  body:
    fontFamily: "ui-sans-serif, sans-serif"
    lineHeight: 1.5rem

rounded:
  radius: 0.25rem

spacing:
  gap-1: 0.25rem
  gap-2: 0.5rem
  gap-3: 0.75rem
  gap-4: 1rem
  padding-1: 0.25rem
  padding-2: 0.5rem
  padding-3: 0.75rem
  padding-4: 1rem

borders:
  width: 1px
  style: solid

shadows:
  sm: "drop-shadow(0px 2px 0.125rem rgba(0, 0, 0, 0.15))"
  md: "drop-shadow(0px 2px 0.25rem rgba(0, 0, 0, 0.2))"
  lg: "drop-shadow(0px 2px 0.5rem rgba(0, 0, 0, 0.25))"
  xl: "drop-shadow(0px 2px 0.75rem rgba(0, 0, 0, 0.3))"
  xl2: "drop-shadow(0px 2px 1rem rgba(0, 0, 0, 0.3))"

z-index:
  hover: 10
  focused: 11
  site-nav: 50

motion:
  fade-duration: 0.125s

components:
  button:
    import: "nvp.ui/button"
    backgroundColor: "{colors.button}"
    textColor: "{colors.text}"
    rounded: "{rounded.radius}"
    padding: "{spacing.padding-1} {spacing.padding-3}"
    variants: "primary | secondary | danger — swap backgroundColor for {colors.primary} / {colors.secondary} / {colors.danger}"
    states: "hover/pressed/disabled are color-mix() derivations; disabled via [aria-disabled] with a reason tooltip"
    cssApi: "--button-*"
  toggle-button:
    import: "nvp.ui"
    extends: "{components.button}"
    states: "[aria-pressed='true'] renders held-down (mixes toward black)"
  menu:
    import: "nvp.ui"
    trigger: "{components.button}"
    surface: "nested .surface with {shadows.md}"
    cssApi: "--menu-border-color"
  tabs:
    import: "nvp.ui/tabs"
    tab: "{components.button}"
    panel: "1px {colors.border} border; the selected tab fuses with the panel edge"
    cssApi: "--tab-*, --tabpanel-*"
  header:
    import: "nvp.ui/header"
    backgroundColor: "{colors.header-background}"
    zIndex: "{z-index.site-nav}"
    position: "auto | top | bottom (container-aware)"
  application-shell:
    import: "nvp.ui"
    regions: "header, navigation, main; built-in mobile menu"
  card:
    pattern: "a composition, not a component — there is deliberately no Card in the kit"
    surface: ".surface, plus .elevation-sm when it should float"
    border: "{borders.width} {borders.style} {colors.border}"
    rounded: "{rounded.radius}"
    padding: "calc(1.25 * {spacing.padding-4})"
    bodyText: "color-mix(in oklab, {colors.text} 80%, transparent)"
    grid: "repeat(auto-fit, minmax(min(100%, 20rem), 1fr)) with {spacing.gap-4} gutters"
  navigation:
    import: "nvp.ui"
    cssApi: "--navigation-*"
  navigation-list:
    import: "nvp.ui"
    current: "accent-derived background from {colors.primary}"
    cssApi: "--navigation-list-*"
  polite-sticky:
    import: "nvp.ui/polite-sticky"
    behavior: "sticky chrome that slides away while scrolling into content"
  avatar:
    import: "nvp.ui/avatar"
    rounded: "{rounded.radius}"
    cssApi: "--avatar-*"
  timeline:
    import: "nvp.ui/timeline"
    dot: "status colors derive from {colors.primary}"
    cssApi: "--timeline-*"
  browser-window:
    import: "nvp.ui/browser-window"
    cssApi: "--browser-window-*"
  progress-circle:
    import: "nvp.ui/progress-circle"
    stroke: "{colors.primary}"
  external-link:
    import: "nvp.ui"
    behavior: "external-indicator icon, safe rel defaults"
  theme:
    import: "nvp.ui/theme"
    behavior: "scopes a subtree to light or dark; sets color-scheme"
  theme-toggle:
    import: "nvp.ui/theme-toggle"
    behavior: "user-facing switch, synchronized with color-scheme"
---

# Design

The design reference for `nvp.ui` — for humans and AI agents building apps with this kit,
following the [DESIGN.md](https://getdesign.md) convention.

Every value in this document comes from
[`src/components/variables.css`](https://github.com/NullVoxPopuli/nvp.ui/blob/main/src/components/variables.css).
When this document and that CSS disagree, the CSS wins.

> The code fences below are live demos, driven by the real components and tokens —
> [view this document rendered on the docs site](https://nullui.vercel.app/Docs/1-get-started/design).
> On GitHub they read as source.

## Overview

Professional and sleek.
Gently rounded corners, hairline borders, high-contrast system typography, restrained motion.
Depth comes from surface color-mixing and drop shadows — not gradients, blur, or decoration.
The system has no imagery of its own: structure, color, and elevation do all of the visual work,
so the app's content is always the subject.

**Key Characteristics:**

- Near-neutral page canvas in both themes, with cool saturated accents (cyan / periwinkle / pink).
- Structure reads through _surfaces_ — nesting automatically lightens panels — while borders stay
  hairline and quiet.
- One radius token shapes the entire kit; one font token sets all type. Re-theming is a
  handful of `:root` declarations, never a rewrite.
- States (hover, pressed, disabled) are `color-mix()` transformations of base tokens, not new colors.
- Light and dark are equals: theme flows from `color-scheme` and can be overridden at any DOM level.
- Accessibility is part of the aesthetic — the two-layer focus ring, `prefers-reduced-motion`
  support, and disabled-reason tooltips are styled deliberately, never suppressed.

## Colors

Semantic roles, not palettes — the values live in the tokens:

| Token                     | Light                                                                  | Dark                                                                  | Use                                                                                |
| ------------------------- | ---------------------------------------------------------------------- | --------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `--color-page-background` | ![light page background](https://placehold.co/48x24/eeeeee/eeeeee.png) | ![dark page background](https://placehold.co/48x24/111111/111111.png) | The canvas; surfaces derive from this                                              |
| `--color-text`            | ![light text](https://placehold.co/48x24/121212/121212.png)            | ![dark text](https://placehold.co/48x24/ffffff/ffffff.png)            | Body text — near-max contrast against the canvas                                   |
| `--color-primary`         | ![light primary](https://placehold.co/48x24/88cdff/88cdff.png)         | ![dark primary](https://placehold.co/48x24/00cdff/00cdff.png)         | Primary actions, accents, `accent-color`                                           |
| `--color-secondary`       | ![light secondary](https://placehold.co/48x24/aaaaff/aaaaff.png)       | ![dark secondary](https://placehold.co/48x24/5555ff/5555ff.png)       | Secondary actions                                                                  |
| `--color-danger`          | ![light danger](https://placehold.co/48x24/ff66bb/ff66bb.png)          | ![dark danger](https://placehold.co/48x24/ee0055/ee0055.png)          | Destructive actions                                                                |
| `--border-color`          | ![light border](https://placehold.co/48x24/efefef/efefef.png)          | ![dark border](https://placehold.co/48x24/222222/222222.png)          | Hairline borders — barely apart from the canvas; separation reads through surfaces |

Accents are cool and saturated (cyan / periwinkle / pink) against a near-neutral canvas.
Don't introduce new hues — derive with `color-mix()` from these tokens.
The same tokens, rendered live in both themes:

```gjs live no-shadow
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

### Theming

Theme is driven by `color-scheme`, overridable at any DOM level via the `Theme` component or the
`theme-light` / `theme-dark` classes — nestable indefinitely. Because class-based theming is in
play, `light-dark()` cannot be used for anything that must respond to those classes.

## Typography

- Text: `--font` — the platform's own sans-serif UI font. No webfonts, ever: the system defers
  to the reader's platform the way it defers to the app's content.
- Code: the browser's default monospace stack; there is no mono token (yet).
- Baseline rhythm: `--line-height`.

```gjs live no-shadow
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

## Layout

### Spacing System

A `0.25rem` base unit, exposed as parallel `gap` and `padding` scales, four steps each:
`--gap-1` … `--gap-4` and `--padding-1` … `--padding-4`. The bare `--gap` defaults to step 1
and `--padding` to step 2.

Off-scale spacing is computed from the scale (e.g. `calc(2 * var(--padding-4))`), never written
as a new literal.

```gjs live no-shadow
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

### Grid & Breakpoints

There is deliberately no grid or breakpoint system. Components adapt to their _container_
(the `Header` even measures its own aspect ratio), so composition — flexbox, CSS grid, and the
`ApplicationShell` regions — is left to the app.

## Elevation & Depth

| Level     | Treatment                                                  | Use                                  |
| --------- | ---------------------------------------------------------- | ------------------------------------ |
| Flat      | Canvas, no border                                          | Page body                            |
| Hairline  | 1px `--border-color` border                                | Quiet outlines, dividers, table rows |
| Surface   | `.surface` — nesting mixes the canvas lighter per level    | Panels, cards, popovers, menus       |
| Elevation | `.elevation-sm` … `.elevation-xl2` — growing `drop-shadow` | Layers that float above their parent |

Never pick a background color for a panel: nest `.surface` and let the system derive it.
Each nesting level is assumed closer to the viewer and mixes a few percent more white into
`--color-page-background` via `color-mix(in oklab, …)`. Elevation classes add the _feeling of
distance_ — the further apart two layers, the bigger the shadow.

```gjs live no-shadow
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

## Shapes

- `--radius` — gently rounded, never pill-shaped. Every component derives its corners from this
  one token, so changing it once on `:root` re-shapes the whole kit. Do not adjust the radius of
  individual components.
- Borders are `--border-width` `--border-style` in `--border-color` — hairline, quiet, structural.

The same component under three values of `--radius` — reshaping is a one-token decision:

```gjs live no-shadow
import { Button } from "nvp.ui/button";

<template>
  <div class="radii">
    <span style="--radius: 0"><Button>--radius: 0</Button></span>
    <span><Button>default</Button></span>
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

- **Focus** is a two-layer ring: an inner ring in `--ring-inner-color` (inverts with the theme)
  and a `--ring-size` outer ring in `--ring-color`. It appears on `:focus-visible` only.
  Because of the ring's size, every interactive element needs at least `--padding-1` of space
  between it and any hard boundary.
- **Hover / press** shift color via `color-mix()` and shrink/grow a 1px shadow spread — motion is
  in color and depth, not position. Pressed (`:active`, `[aria-pressed="true"]`) mixes toward
  black to look held down.
- **Disabled** is expressed as `[aria-disabled]` (still focusable, still hoverable), desaturated
  toward `--color-disable-mix` — and a disabled control explains itself: `Button`'s `@disabled`
  takes the _reason_, shown as a focusable tooltip.
- **Motion**: transitions fade over `--fade-duration`, which drops to 0s under
  `prefers-reduced-motion`. Nothing animates position; nothing loops.
- **Layering**: use the z-index scale — `--z-hover`, `--z-focused`, `--z-site-nav`.
  Don't mint new z-index values.

Hover for the color shift, Tab through for the focus ring, and hover the disabled button for its reason:

```gjs live no-shadow
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

```gjs live no-shadow
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

Reach for the kit before writing markup — every component below already consumes the global
tokens, and each exposes its own `--<component>-*` custom-property API (defaulted from the
global tokens) for local tuning. Variants are args that map onto attributes
(`<Button @variant="primary">` renders `data-variant="primary"`), state is expressed through
`aria-*` attributes, and native attributes/modifiers are forwarded through `...attributes` —
not framework-specific args.

### Structure

**`ApplicationShell`** — The page scaffold: header, navigation, and content regions with a
mobile menu built in. Compose everything else inside it.

**`Header`** — Site header on `--header-background`, layered at `--z-site-nav`.
`@position="auto"` lets it sit at the top or bottom of the viewport based on its container.

**`Navigation`** + **`NavigationList`** — Sidebar navigation: `Navigation` is the labeled
container, `NavigationList` a titled group of links. Current-page and hover treatments derive
from the accent tokens; tune with `--navigation-*` / `--navigation-list-*`.

**`PoliteSticky`** — Sticky chrome that politely slides out of the way as you scroll into
content and returns when you scroll back.

### Cards & containers

There is deliberately no `Card` component — a card is a composition, and every panel-shaped
thing (cards, popovers, menus) is built the same way: a `.surface` (plus `elevation-sm` when it
should float), a hairline border, `--radius` corners, and padding from the scale. Body copy
inside a card softens by mixing `--color-text` toward transparent. Card grids use
`auto-fit` / `minmax` columns with `--gap-4` gutters — cards reflow rather than shrink.

```gjs live no-shadow
<template>
  <ul class="cards">
    <li class="surface elevation-sm">
      <h3>A surface</h3>
      <p>The background is derived from the canvas — never picked by hand.</p>
    </li>
    <li class="surface elevation-sm">
      <h3>A quiet border</h3>
      <p>Hairline, in the border token — the surface does the separating.</p>
    </li>
    <li class="surface elevation-sm">
      <h3>Tokens all the way</h3>
      <p>Radius, padding, and gaps come from the scales, so cards reshape with the kit.</p>
    </li>
  </ul>

  <style>
    @scope {
      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(min(100%, 14rem), 1fr));
        gap: var(--gap-4);
        margin: 0;
        padding: var(--padding-2);
        list-style: none;
      }
      li {
        padding: calc(1.25 * var(--padding-4));
        border: var(--border-width) var(--border-style) var(--border-color);
        border-radius: var(--radius);
      }
      h3 {
        margin: 0 0 var(--gap-2);
      }
      p {
        margin: 0;
        color: color-mix(in oklab, var(--color-text) 80%, transparent);
      }
    }
  </style>
</template>
```

### Actions

**`Button`** — The reference interactive element. Variants `primary` / `secondary` / `danger`
via `@variant`; `@disabled` takes a _reason_ (string or component) rendered as a focusable
tooltip; icons via `@start` / `@end` or named blocks. All states are `color-mix()` derivations —
see [Interaction](#interaction).

**`ToggleButton`** — A `Button` that manages `aria-pressed`, styled held-down while pressed.

**`Menu`** — A popover menu; the trigger is a `Button`, the popover is a `.surface`, items reuse
the button state derivations.

**`Tabs`** — Tabs share the button styling; the selected tab visually fuses with its panel
(the panel border runs under the active tab).

**`ExternalLink`** — An anchor for leaving the site: external-indicator icon and safe
`rel` defaults.

### Content

**`Avatar`** — Image-or-initials identity disc; size, border, and background via `--avatar-*`.

**`Timeline`** — An ordered list (`role="list"` / `listitem`) of dots and content, vertical or
`@horizontal`; per-item `@status` (complete / current) colors the dot from the accent tokens.

**`BrowserWindow`** — Decorative browser chrome for framing demos and screenshots; fully
themeable via `--browser-window-*`.

**`ProgressCircle`** — A circular progress indicator stroked in `--color-primary`.

**`Theme`** + **`ThemeToggle`** — Scope a subtree to a theme; give the user the switch.

## Do

- Use the tokens — never hardcode colors, radii, spacing, shadows, or durations.
- Nest `.surface` instead of picking panel backgrounds.
- Derive state colors with `color-mix()` from the base tokens.
- Express state as `aria-*` attributes and give disabled controls a reason.
- Keep at least `--padding-1` between interactives and hard edges — the focus ring needs room.
- Verify every screen in both themes; they are equals.

## Don't

- Don't add webfonts.
- Don't use `light-dark()` where class-based theming must work.
- Don't remove or shrink focus rings.
- Don't animate position or add looping animation.
- Don't mint new z-index values outside the scale.
- Don't introduce new hues outside the token set.

## Iteration Guide

1. Compose from the components above before writing new markup.
2. New components define their own `--<component>-*` properties, defaulted from the global
   tokens — never from literals — so they inherit theming and reshaping for free.
3. Variants are attribute-driven (`data-*` from args); states are `aria-*`.
4. Forward native attributes and modifiers with `...attributes`.
5. Every docs page is axe-audited in light and dark on every change — new UI must pass both.

## Known Gaps

- No monospace font token yet; code falls back to the browser's default stack.
- No grid or breakpoint system — intentionally container-driven, but that means layout
  conventions live in apps, not in the kit.
- Motion vocabulary is fades only; there is no shared easing or duration scale beyond
  `--fade-duration`.
- The two gradients are the only sanctioned decoration, and only for hero/marketing moments.
