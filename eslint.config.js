import { configs } from "@nullvoxpopuli/eslint-configs";

const defaults = configs.ember(import.meta.dirname);

export default [
  ...defaults,
  {
    languageOptions: {
      parserOptions: {
        project: "./tsconfig.tests.json",
      },
    },
  },
];
