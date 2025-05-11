'use strict';

const VIRTUAL_PACKAGES = [
  'ember-source',
  '@glimmer/tracking',
  '@glimmer/validator',
  // not virtual, but still not something we want
  'ember-cached-decorator-polyfill',
];

function readPackage(pkg, _context) {
    if (!pkg['ember-addon']) {
        return pkg;
    }

    if (pkg.dependencies) {
    VIRTUAL_PACKAGES.forEach((name) => {
            delete pkg.dependencies[name];
    })
    }

    if (pkg.peerDependencies) {
        VIRTUAL_PACKAGES.forEach((name) => {
                delete pkg.peerDependencies[name];
        })
    }

    return pkg;
}

module.exports = {
    hooks: {
        readPackage,
    },
};
