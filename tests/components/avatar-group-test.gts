import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { Avatar, AvatarGroup } from "#src/index.ts";

module("AvatarGroup", function (hooks) {
  setupRenderingTest(hooks);

  test("it renders multiple avatars", async function (assert) {
    await render(
      <template>
        <AvatarGroup>
          <Avatar @src="https://via.placeholder.com/150" @alt="User 1" />
          <Avatar @src="https://via.placeholder.com/150" @alt="User 2" />
          <Avatar @src="https://via.placeholder.com/150" @alt="User 3" />
        </AvatarGroup>
      </template>,
    );

    assert.dom(".nvp__avatar-group").exists();
    assert.dom(".nvp__avatar").exists({ count: 3 });
  });

  test("it accepts size variant", async function (assert) {
    await render(
      <template>
        <AvatarGroup @size="large">
          <Avatar @src="https://via.placeholder.com/150" @alt="User 1" />
          <Avatar @src="https://via.placeholder.com/150" @alt="User 2" />
        </AvatarGroup>
      </template>,
    );

    assert.dom(".nvp__avatar-group[data-size='large']").exists();
  });

  test("it renders with no avatars", async function (assert) {
    await render(
      <template>
        <AvatarGroup />
      </template>,
    );

    assert.dom(".nvp__avatar-group").exists();
    assert.dom(".nvp__avatar").doesNotExist();
  });
});
