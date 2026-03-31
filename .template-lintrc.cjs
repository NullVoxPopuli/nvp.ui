"use strict";

module.exports = {
  extends: "recommended",
  overrides: [
    {
      files: ["docs-app/**"],
      rules: {
        "no-inline-styles": false,
        "no-forbidden-elements": false,
      },
    },
    {
      files: ["tests/**"],
      rules: {
        "no-inline-styles": false,
      },
    },
  ],
};
