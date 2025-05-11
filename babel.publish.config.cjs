"use strict";

module.exports = {
  plugins: [
    ["@babel/plugin-transform-typescript", { allowDeclareFields: true }],
    [
      "babel-plugin-ember-template-compilation",
      {
        targetFormat: "hbs",
        transforms: [],
      },
    ],
    ["module:decorator-transforms", { runtime: { import: "decorator-transforms/runtime" } }],
  ],

  generatorOpts: {
    compact: false,
  },
};
