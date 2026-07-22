# Design

The design reference for `nvp.ui` — for humans and AI agents building apps with this kit,
following the [DESIGN.md](https://getdesign.md) convention.

Every value in this document comes from
[`src/components/variables.css`](https://github.com/NullVoxPopuli/nvp.ui/blob/main/src/components/variables.css).
When this document and that CSS disagree, the CSS wins.

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

### Surfaces instead of panel colors

Never pick a background color for a panel, card, or popover. Use the `surface` class:
each level of `.surface` nesting mixes a few percent more white into `--color-page-background`
(via `color-mix(in oklab, ...)`), so elements "closer to the viewer" are automatically lighter.
Pair with an elevation class — `elevation-sm` through `elevation-xl2` — when a layer should
feel lifted off the one beneath it (bigger distance → bigger `drop-shadow`).

## Typography

- Text: `--font: ui-sans-serif, sans-serif` — the platform's UI font, no webfonts.
- Code: the browser's default monospace stack; there is no mono token (yet).
- Baseline: `--line-height: 1.5rem`.

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

## Shape and borders

- `--radius: 0.25rem` — gently rounded, never pill-shaped. Every component derives its corners
  from this one token, so changing it once on `:root` re-shapes the whole kit. Do not adjust the
  radius of individual components.
- Borders are `--border-width: 1px` `--border-style: solid` in `--border-color`.

## Interaction

- **Focus** is a two-layer ring: a 2px inner ring in `--ring-inner-color` (white in light, black in
  dark) and a `--ring-size` outer ring in `--ring-color`. It appears on `:focus-visible` only.
  Because of the ring's size, every interactive element needs at least 4px (`--padding-1`) of space
  between it and any hard boundary.
- **Hover / press** shift color via `color-mix()` and shrink/grow a 1px shadow spread — motion is
  in color and depth, not position. Pressed (`:active`, `[aria-pressed="true"]`) mixes toward black
  to look held down.
- **Disabled** uses `[aria-disabled]` (still focusable, still hoverable) and desaturates toward
  `--color-disable-mix`; a disabled control should explain itself through the Button component's
  disabled-reason tooltip.
- **Motion**: transitions fade over `--fade-duration` (0.125s), which drops to 0s under
  `prefers-reduced-motion`. Nothing animates position; nothing loops.
- **Layering**: use the z-index scale — `--z-hover: 10`, `--z-focused: 11`, `--z-site-nav: 50`.
  Don't mint new z-index values.

## Gradients

Two exist, for hero/marketing moments only: `--gradient-hero` (blue → violet sweep) and
`--gradient-featured` (violet → indigo). Everything else is flat color.

## Components

Reach for the kit before writing markup: `ApplicationShell`, `Avatar`, `BrowserWindow`, `Button`,
`ExternalLink`, `Header`, `Menu`, `Navigation`, `NavigationList`, `PoliteSticky`, `ProgressCircle`,
`Tabs`, `Theme`, `ThemeToggle`, `Timeline`, `ToggleButton` — each importable from its subpath
(e.g. `import { Button } from "nvp.ui/button";`). They already consume every token above, so a
correctly-themed app mostly means composing them and setting tokens.

Variants are HTML-first: `<Button data-variant="primary">`, state via `aria-*` attributes, and
native attributes/modifiers forwarded through `...attributes` — not framework-specific args.

## Don't

- Don't hardcode colors, radii, spacing, shadows, or durations — use the tokens.
- Don't pick panel backgrounds — nest `.surface`.
- Don't add webfonts.
- Don't use `light-dark()` where class-based theming must work.
- Don't remove or shrink focus rings, and don't crowd interactives within 4px of a hard edge.
- Don't animate position or add looping animation.
