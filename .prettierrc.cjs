"use strict";

module.exports = {
  printWidth: 100,
  plugins: ["prettier-plugin-ember-template-tag"],
  overrides: [
    {
      files: ["**/*.gjs", "**/*.gts"],
      plugins: ["prettier-plugin-ember-template-tag"],
    },
  ],
};
