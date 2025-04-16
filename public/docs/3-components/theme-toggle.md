# ThemeToggle

Switches between light mode and dark mode


```gjs live no-shadow
import { ThemeToggle } from '@universal-ember/preem';

<template>
  <div class="demo">
    <ThemeToggle />
    <ThemeToggle class="bigger" />
    <ThemeToggle class="big" />
  </div>

  <style>
    .demo {
      display: flex; 
      gap: 0.5rem;
      justify-content: center;
      align-items: center;

      .bigger label {
        height: 3rem;
      }
      .big label {
        height: 5rem;
      }
    }
  </style>
</template>
```


## Features 

* Toggles the theme, managed by ['color-scheme'](https://ember-primitives.pages.dev/6-utils/color-scheme) 
* Live updates if anything else changes the current color scheme. 
* Defaults to the user's preferred color scheme.


## Installation 

```bash 
pnpm add @universal-ember/preem 
```

## Anatomy

```js 
import { ThemeToggle } from '@universal-ember/preem';
```

or for non-tree-shaking environments:
```js 
import { ThemeToggle } from '@universal-ember/preem/components/theme-toggle';
```


```gjs 
import { ThemeToggle } from '@universal-ember/preem';

<template>
  <ThemeToggle />
</template>
```


## API Reference

none

### State Attributes

none

### Styling 

Public selectors:

| key | description |  
| :---: | :----------- |  
| `.preem__site-theme-toggle` | Wrapper element around the underlying switch |  


## Accessibility

See [`Switch`](https://ember-primitives.pages.dev/3-components/switch)

### Keyboard Interactions

| key | description |  
| :---: | :----------- |  
| <kbd>Space</kbd> | Toggles the component's state |  

