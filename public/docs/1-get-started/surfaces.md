# Surfaces & Elevation


The surfaces system automatically adjusts the background color of panels, buttons, and anything that _could_ be considered to have a "surface", if it were in the real physical world.

How it works is that the more nesting there is, the closer it is assumed to be to the viewer's face -- that is, the greater the z-distance from the base of the page.



```gjs live preview no-shadow

<template>
  <div class="surface">
    <div class="surface">
      <div class="surface">
        <div class="surface">
          <div class="surface">
          </div>
        </div>
      </div>
    </div>
  </div>

  <style>
    @scope {
      div {
        padding: var(--padding-4);
        border: 1px solid var(--border-color);
      }
    }
  </style>

</template>

```

Separate from the _nesting_, we can specify "elevation" which adds a feeling of distance from the underlying layer -- the closer in elevation the two layers are, the smaller the shadow -- and likewise, the greater elevation the bigger the shadow.


```gjs live preview no-shadow

<template>
  <div class="surface elevation-sm">
    <div class="surface elevation-md">
      <div class="surface elevation-lg">
        <div class="surface elevation-xl">
          <div class="surface elevation-xl2">
          </div>
        </div>
      </div>
    </div>
  </div>

  <style>
    @scope {
      div {
        padding: calc(2 * var(--padding-4));
        border: 1px solid var(--border-color);
      }
    }
  </style>

</template>

```
