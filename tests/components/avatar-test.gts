import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Avatar, AvatarGroup } from "#src/index.ts";

module("Avatar", function (hooks) {
  setupRenderingTest(hooks);

  test("renders with default medium size", async function (assert) {
    await render(
      <template>
        <Avatar @src="/non-existent.png" @alt="Test User">
          <:fallback>TU</:fallback>
        </Avatar>
      </template>,
    );

    assert.dom(".nvp__avatar").exists();
    assert.dom(".nvp__avatar").hasAttribute("data-size", "medium");
  });

  test("renders small size", async function (assert) {
    await render(
      <template>
        <Avatar @src="/non-existent.png" @size="small">
          <:fallback>S</:fallback>
        </Avatar>
      </template>,
    );

    assert.dom(".nvp__avatar").hasAttribute("data-size", "small");
  });

  test("renders large size", async function (assert) {
    await render(
      <template>
        <Avatar @src="/non-existent.png" @size="large">
          <:fallback>L</:fallback>
        </Avatar>
      </template>,
    );

    assert.dom(".nvp__avatar").hasAttribute("data-size", "large");
  });

  test("renders fallback content when image fails to load", async function (assert) {
    await render(
      <template>
        <Avatar @src="/non-existent.png" @delayMs={{0}}>
          <:fallback>AB</:fallback>
        </Avatar>
      </template>,
    );

    assert.dom(".nvp__avatar").containsText("AB");
  });

  test("renders default SVG fallback when no fallback block provided", async function (assert) {
    await render(<template><Avatar @src="/non-existent.png" @delayMs={{0}} /></template>);

    assert.dom(".nvp__avatar svg").exists();
  });

  test("splats attributes on the root element", async function (assert) {
    await render(
      <template>
        <Avatar @src="/non-existent.png" data-test-avatar>
          <:fallback>X</:fallback>
        </Avatar>
      </template>,
    );

    assert.dom("[data-test-avatar]").exists();
    assert.dom("[data-test-avatar]").hasClass("nvp__avatar");
  });
});

module("AvatarGroup", function (hooks) {
  setupRenderingTest(hooks);

  test("renders a group container", async function (assert) {
    await render(
      <template>
        <AvatarGroup>
          <Avatar @src="/a.png">
            <:fallback>A</:fallback>
          </Avatar>
          <Avatar @src="/b.png">
            <:fallback>B</:fallback>
          </Avatar>
        </AvatarGroup>
      </template>,
    );

    assert.dom(".nvp__avatar-group").exists();
    assert.dom(".nvp__avatar-group").hasAttribute("role", "group");
    assert.dom(".nvp__avatar").exists({ count: 2 });
  });

  test("sets data-size on the group", async function (assert) {
    await render(
      <template>
        <AvatarGroup @size="small">
          <Avatar @src="/a.png" @size="small">
            <:fallback>A</:fallback>
          </Avatar>
        </AvatarGroup>
      </template>,
    );

    assert.dom(".nvp__avatar-group").hasAttribute("data-size", "small");
  });

  test("splats attributes on the group", async function (assert) {
    await render(
      <template>
        <AvatarGroup data-test-group>
          <Avatar @src="/a.png">
            <:fallback>A</:fallback>
          </Avatar>
        </AvatarGroup>
      </template>,
    );

    assert.dom("[data-test-group]").exists();
    assert.dom("[data-test-group]").hasClass("nvp__avatar-group");
  });
});
