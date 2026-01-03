"use strict";

const { dirname } = require("path");
const { addonV1Shim } = require("@embroider/addon-shim");

module.exports = addonV1Shim(dirname(__dirname));
