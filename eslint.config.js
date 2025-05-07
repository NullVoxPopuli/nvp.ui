import { join } from "node:path";

import { configs } from "@nullvoxpopuli/eslint-configs";

const defaults = configs.ember(import.meta.dirname);

const tsconfig = join(import.meta.dirname, "tsconfig.tests.json");

const config = [
  {
    ignores: ["dist", "node_modules", "declarations", "dist-app", "dist-docs", "dist-tests"],
  },
  ...defaults,
  ...defaults.map((x) => {
    if (x.languageOptions?.parserOptions?.tsconfigRootDir) {
      x.languageOptions.parserOptions.project = tsconfig;
      delete x.languageOptions.parserOptions.projectService;
      x.rules ||= {};
      x.rules["@typescript-eslint/consistent-type-imports"] = "error";
    }

    return x;
  }),
];

export default config;
