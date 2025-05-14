# Progress Circle

A circular progress indicator

```gjs live preview

import { ProgressCircle } from 'null.ui/components/progress-circle';
import { cell, resource } from 'ember-resources';

const randomValue = resource(({on}) => {
  let value = cell(randomPercent());
  let interval = setInterval(() => value.current = randomPercent(), 3000);
  on.cleanup(() => clearInterval(interval));

  return value;
}); 

const randomPercent = () => Math.random() * 100;

<template>
  <div style="display: flex; gap: 1.5rem">
    <ProgressCircle 
      @color="#FF1E7D" 
      aria-label="demo-pink" 
      @value={{(randomValue)}} 
    />

    <ProgressCircle 
      @color="#1EFF7D" 
      aria-label="demo-green" 
      @value={{(randomValue)}} 
    />
  </div>
</template>


```
