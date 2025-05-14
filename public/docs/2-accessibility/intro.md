# Accessibility

All components strive for compliance with the [WAI-ARIA](https://www.w3.org/TR/wai-aria/) specification, which is a set of guidelines for accessibility, following [the recommended patterns](https://www.w3.org/WAI/ARIA/apg/patterns/).
The ARIA design patterns can be easily searched on [their site index](https://www.w3.org/WAI/ARIA/apg/example-index/).

## Automatic Accountability

A feature of [`ember-primitives`](https://ember-primitives.pages.dev/) (a library used by this design system) is that,
violations that can be caught via CSS are highlighted in the UI so that the developer knows exactly what to fix.

This only happens during development, and in production, the CSS that applies these warnings is not included.

## Tenents

- **Never** use tooltips (via [`title`](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/title#accessibility_concerns) or [`role='tooltip'](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tooltip_role#accessibility_concerns)`.  
This is because `title`and`role='tooltip'` are not focusable, and cannot have nested interactives within them.
  Without focus, the user is not able to interact with anything inside the tooltip or title, which includes text selection -- a useful capability if the user wants to communicate with support.

- **Never** use the `disabled` attribute on interactive elements. This is because `disabled` is not focusable.
  When an element would be disabled, it should use the [`aria-disabled`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-disabled) attribute, which is focusable, and gives the developer a chance to explain why the interactive element is disabled.
