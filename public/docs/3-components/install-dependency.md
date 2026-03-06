# InstallDependency

The `<InstallDependency />` component shows package installation commands for all major JavaScript package managers (npm, yarn, pnpm, bun) in a tabbed interface.

```gjs live no-shadow
import { InstallDependency } from "nvp.ui";

<template>
  <InstallDependency @package="nvp.ui" />
</template>
```

## Custom commands

You can override any of the default commands by passing the corresponding arg:

```gjs live no-shadow
import { InstallDependency } from "nvp.ui";

<template>
  <InstallDependency
    @package="nvp.ui"
    @npm="npm install nvp.ui --save-dev"
    @yarn="yarn add nvp.ui --dev"
    @pnpm="pnpm add -D nvp.ui"
    @bun="bun add -d nvp.ui"
  />
</template>
```

## Installation

```bash
pnpm add nvp.ui
```

## API Reference

```gjs live no-shadow
import { ComponentSignature } from "kolay";

<template>
  <ComponentSignature @package="." @module="declarations/components/install-dependency.gts" @name="Signature" />
</template>
```
