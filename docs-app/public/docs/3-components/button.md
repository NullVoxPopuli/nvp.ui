# Button

The accessible button is an improvement on the native `<button>` by providing additional information when disabled, tooltips, etc


```gjs live no-shadow
import { Button } from '@universal-ember/preem';

<template>
  <Button>Default</Button>
  <Button @variant="primary">Primary</Button>
  <Button @variant="secondary">Secondary</Button>
  <Button @variant="danger">Danger</Button>

  <br><br>

  <Button>
    <:start>✨</:start>
    <:text>text with icons</:text>
    <:end>🎉</:end>
  </Button>
  <Button @start="✨">
    Button text
  </Button>
  <Button @end="✨">
    Button text
  </Button>


  <br><br>
  <Button @variant="primary" @disabled="Disabled for visual Demo">Primary</Button>
  <Button @variant="secondary" @disabled="Disabled for visual Demo">Secondary</Button>
  <Button @variant="danger" @disabled="Disabled for visual Demo">Danger</Button>
</template>
```

## Installation

```bash 
pnpm add @universal-ember/preem 
```

## API Reference

```gjs
import { ComponentSignature } from 'kolay';

<template>
  <ComponentSignature 
    @package="@universal-ember/preem" 
    @module="declarations/components/button" 
    @name="Signature" />
</template>
```

### State Attributes

none

### Styling 

Public selectors:

| key | description |  
| :---: | :----------- |  
