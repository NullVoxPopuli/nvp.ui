# Progress Circle

A circular progress indicator

```gjs live preview
import { ProgressCircle } from "nvp.ui/progress-circle";
import { cell, resource } from "ember-resources";

const randomValue = resource(({ on }) => {
  let value = cell(randomPercent());
  let interval = setInterval(() => (value.current = randomPercent()), 3000);
  on.cleanup(() => clearInterval(interval));

  return value;
});

const randomPercent = () => Math.random() * 100;

<template>
  <div style="display: flex; gap: 1.5rem">
    <ProgressCircle @color="#FF1E7D" @value={{(randomValue)}} aria-label="demo-pink" />

    <ProgressCircle @color="#1EFF7D" @value={{(randomValue)}} aria-label="demo-green" />
  </div>
</template>
```
