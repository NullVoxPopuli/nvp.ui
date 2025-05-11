import { configs } from "@nullvoxpopuli/eslint-configs";

const defaults = configs.ember(import.meta.dirname);

const config = [
  {
    ignores: ["dist", "node_modules", "declarations", "dist-app", "dist-docs", "dist-tests"],
  },
  ...defaults,
];

export default config;
