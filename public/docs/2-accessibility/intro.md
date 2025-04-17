# Accessibility

All components strive for compliance with the [WAI-ARIA](https://www.w3.org/TR/wai-aria/) specification, which is a set of guidelines for accessibility, following [the recommended patterns](https://www.w3.org/WAI/ARIA/apg/patterns/).
The ARIA design patterns can be easily searched on [their site index](https://www.w3.org/WAI/ARIA/apg/example-index/).

## Automatic Accountability

A feature of [`ember-primitives`](https://ember-primitives.pages.dev/),
violations that can be caught via CSS are highlighted in the UI so that the developer knows exactly what to fix.

This only happens during development, and in production, the CSS that applies these warnings is not included.
