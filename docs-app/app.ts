import Application from "@ember/application";

import * as PageTitle from "ember-page-title/services/page-title";
import { sync } from "ember-primitives/color-scheme";
// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-expect-error
import * as ResizeObserverService from "ember-resize-observer-service/addon/services/resize-observer";
import Resolver from "ember-resolver";
// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-expect-error
import * as SetBodyClassService from "ember-set-body-class/addon/services/body-class";
import { registry as kolayServices } from "kolay";

import config from "./config.ts";
import * as Router from "./router.ts";
import * as ApplicationRoute from "./routes/application.ts";
import * as IndexRoute from "./routes/index.ts";
import * as PageRoute from "./routes/page.ts";
import * as ApplicationTemplate from "./templates/application.gts";
import * as PageTemplate from "./templates/page.gts";

sync();

// @babel/traverse (from babel-plugin-ember-template-imports)
// accesses process.....
// maybe one day we can have a browser-only version?
// But they aren't used.... so.. that's fun.
Object.assign(window, {
  process: { env: {} },
  Buffer: {},
});

export default class App extends Application {
  modulePrefix = config.modulePrefix;
  Resolver = Resolver.withModules({
    // This App
    "docs-app/router": Router,
    "docs-app/routes/application": ApplicationRoute,
    "docs-app/routes/index": IndexRoute,
    "docs-app/routes/page": PageRoute,
    "docs-app/templates/application": ApplicationTemplate,
    "docs-app/templates/page": PageTemplate,
    // From Libraries
    "docs-app/services/page-title": PageTitle,
    ...kolayServices("docs-app"),

    // From V1 libraries...
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    "docs-app/services/resize-observer": ResizeObserverService,
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    "docs-app/services/body-class": SetBodyClassService,
  });
}
