import { join } from "node:path";

import { configs } from "@nullvoxpopuli/eslint-configs";

const defaults = configs.ember(import.meta.dirname);

export default [
  ...defaults,
  {
    files: ["**/*.ts", "**/*.gts"],
    languageOptions: {
      parserOptions: {
        project: join(import.meta.dirname, "tsconfig.tests.json"),
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
];
