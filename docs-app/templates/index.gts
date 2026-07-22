import { fn } from "@ember/helper";

import { PortalTargets } from "ember-primitives";
import { cell } from "ember-resources";
import Route from "ember-route-template";

import { BrowserWindow, Button, Menu, ToggleButton } from "#src/index.ts";

const starred = cell(false);
const lastAction = cell("nothing yet");

const toggleStarred = () => starred.set(!starred.current);
const setLastAction = (action: string) => lastAction.set(action);

export default Route(
  <template>
    <PortalTargets />

    <div class="docs-landing">
      <section class="docs-hero">
        <h1>nvp.ui</h1>
        <p class="docs-hero__tagline">
          A UI kit for building professional, sleek Ember apps quickly. Accessible components, light
          &amp; dark theming, and a surface-based design system &mdash; powered by
          <a href="https://ember-primitives.pages.dev/">ember-primitives</a>.
        </p>

        <p class="docs-hero__install"><code>pnpm add nvp.ui</code></p>

        <p class="docs-hero__actions">
          <a class="nvp__button" data-variant="primary" href="/Docs/1-get-started/intro">
            Get started
          </a>
          <a class="nvp__button" href="/Docs/3-components/button">
            Browse components
          </a>
        </p>
      </section>

      <section class="docs-landing__section">
        <h2>See it in action</h2>
        <p>
          These are the real components, running live. Everything you see in these docs is built
          with nvp.ui itself.
        </p>

        <BrowserWindow @os="mac" @url="https://your-app.example">
          <div class="docs-showcase">
            <div class="docs-showcase__row">
              <Button @onClick={{fn setLastAction "saved"}}>Save</Button>
              <Button @variant="primary" @onClick={{fn setLastAction "published"}}>
                Publish
              </Button>
              <Button @variant="secondary" @onClick={{fn setLastAction "previewed"}}>
                Preview
              </Button>
              <Button @variant="danger" @onClick={{fn setLastAction "deleted"}}>
                Delete
              </Button>
            </div>

            <div class="docs-showcase__row">
              <Menu as |menu|>
                <menu.Trigger>Actions</menu.Trigger>
                <menu.Content as |Items|>
                  <Items.Item @onSelect={{fn setLastAction "renamed"}}>Rename</Items.Item>
                  <Items.Item @onSelect={{fn setLastAction "duplicated"}}>Duplicate</Items.Item>
                  <Items.Separator />
                  <Items.Item @onSelect={{fn setLastAction "archived"}}>Archive</Items.Item>
                </menu.Content>
              </Menu>

              <ToggleButton @pressed={{starred.current}} @onClick={{toggleStarred}}>
                {{if starred.current "★ Starred" "☆ Star"}}
              </ToggleButton>
            </div>

            <p class="docs-showcase__status" aria-live="polite">
              Last action:
              {{lastAction.current}}
            </p>
          </div>
        </BrowserWindow>
      </section>

      <section class="docs-landing__section">
        <h2>What you get</h2>

        <ul class="docs-features">
          <li class="surface elevation-sm">
            <h3>Accessible by default</h3>
            <p>
              Keyboard navigation, focus management, and sensible ARIA come built-in. Every docs
              page is audited with axe on every change.
            </p>
          </li>
          <li class="surface elevation-sm">
            <h3>Light &amp; dark, for free</h3>
            <p>
              Components are themeable through CSS custom properties and adapt to the user's color
              scheme preference automatically.
            </p>
          </li>
          <li class="surface elevation-sm">
            <h3>Surfaces &amp; elevation</h3>
            <p>
              A physical-world-inspired surface system keeps nested panels, cards, and menus
              visually consistent without manual color picking.
            </p>
          </li>
          <li class="surface elevation-sm">
            <h3>Typed, modern Ember</h3>
            <p>
              Glint-ready signatures, native
              <code>&lt;template&gt;</code>
              components, and zero-config usage with Vite.
            </p>
          </li>
        </ul>
      </section>
    </div>

    <style>
      .docs-hero {
        padding-top: 2rem;
      }

      .docs-hero h1 {
        font-family: var(--font-mono);
        font-size: 3rem;
        letter-spacing: -0.03em;
      }

      /* Terminal cursor sign-off on the wordmark */
      .docs-hero h1::after {
        content: "_";
        color: var(--color-primary);
      }

      .docs-hero__tagline {
        max-width: 38rem;
        font-size: 1.1875rem;
      }

      .docs-hero__install code {
        display: inline-block;
        margin-top: 0.5rem;
        padding: 0.5rem 1rem;
        border: var(--docs-border);
        border-radius: var(--docs-radius);
        font-size: 0.9375rem;
      }

      .docs-hero__install code::before {
        content: "$ ";
        color: var(--docs-muted);
      }

      .docs-hero__actions {
        display: flex;
        flex-wrap: wrap;
        gap: var(--gap-3);
        margin-top: 1.25rem;
      }

      .docs-landing a.nvp__button {
        text-decoration: none;
      }

      .docs-landing__section {
        margin-top: 1.5rem;
      }

      .docs-showcase {
        display: grid;
        gap: var(--gap-4);
        padding: 1.5rem;
      }

      .docs-showcase__row {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: var(--gap-3);
      }

      .docs-showcase__status {
        margin: 0;
        font-size: 0.875rem;
        color: var(--docs-muted);
      }

      .docs-features {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(min(100%, 20rem), 1fr));
        gap: var(--gap-4);
        margin: 1.25rem 0 0;
        padding: 0;
        list-style: none;
      }

      .docs-features li {
        --bracket-color: var(--color-primary);

        position: relative;
        margin: 0;
        padding: 1.25rem;
        border: var(--docs-border);
        border-radius: var(--docs-radius);
      }

      /* The pastel light-mode primary washes out on white cards */
      .theme-light .docs-features li {
        --bracket-color: var(--docs-link);
      }

      /* HUD corner brackets, sitting on the card's own border */
      .docs-features li::before,
      .docs-features li::after {
        content: "";
        position: absolute;
        width: 0.625rem;
        height: 0.625rem;
        border: 2px solid var(--bracket-color);
        pointer-events: none;
      }

      .docs-features li::before {
        top: -1px;
        left: -1px;
        border-right: none;
        border-bottom: none;
      }

      .docs-features li::after {
        right: -1px;
        bottom: -1px;
        border-top: none;
        border-left: none;
      }

      .docs-features h3 {
        margin: 0 0 0.5rem;
        font-size: 1.0625rem;
      }

      .docs-features p {
        margin: 0;
        font-size: 0.9375rem;
        line-height: 1.6;
        color: color-mix(in oklab, var(--color-text) 80%, transparent);
      }
    </style>
  </template>,
);
