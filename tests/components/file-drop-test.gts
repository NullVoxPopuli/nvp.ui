import { render, triggerEvent } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "ember-qunit";

import { FileDrop } from "#src/index.ts";

function fileOf(name: string, type: string) {
  return new File(["content"], name, { type });
}

/**
 * A real DataTransfer, as the browser makes for a drag of files.
 */
function transferOf(files: File[]) {
  const transfer = new DataTransfer();

  for (const file of files) transfer.items.add(file);

  return transfer;
}

module("FileDrop", function (hooks) {
  setupRenderingTest(hooks);

  test("a picked file is passed to @onFiles", async function (assert) {
    const handle = (files: File[]) => {
      for (const file of files) assert.step(`file ${file.name}`);
    };

    await render(<template><FileDrop @onFiles={{handle}} /></template>);

    assert.dom(".nvp__file-drop").hasText("Drop a file here, or click to choose one");
    assert.dom("label.nvp__file-drop input[type=file]").exists("the label text names the input");

    await triggerEvent("input[type=file]", "change", {
      files: [fileOf("clip.webm", "video/webm")],
    });

    assert.verifySteps(["file clip.webm"]);
  });

  test("a dropped file is passed to @onFiles, and the zone shows the drag", async function (assert) {
    const handle = (files: File[]) => {
      for (const file of files) assert.step(`file ${file.name}`);
    };

    await render(<template><FileDrop @onFiles={{handle}} /></template>);

    const dataTransfer = transferOf([fileOf("clip.webm", "video/webm")]);

    await triggerEvent(".nvp__file-drop", "dragenter", { dataTransfer });
    assert.dom(".nvp__file-drop").hasAttribute("data-dragging");

    await triggerEvent(".nvp__file-drop", "drop", { dataTransfer });
    assert.dom(".nvp__file-drop").doesNotHaveAttribute("data-dragging");
    assert.verifySteps(["file clip.webm"]);
  });

  test("leaving the zone ends the drag", async function (assert) {
    const handle = () => assert.step("files");

    await render(<template><FileDrop @onFiles={{handle}} /></template>);

    const dataTransfer = transferOf([fileOf("clip.webm", "video/webm")]);

    await triggerEvent(".nvp__file-drop", "dragenter", { dataTransfer });
    await triggerEvent(".nvp__file-drop", "dragleave", { dataTransfer });

    assert.dom(".nvp__file-drop").doesNotHaveAttribute("data-dragging");
    assert.verifySteps([]);
  });

  test("@accept ignores other files", async function (assert) {
    const handle = (files: File[]) => {
      for (const file of files) assert.step(`file ${file.name}`);
    };

    await render(<template><FileDrop @accept="video/*,.json" @onFiles={{handle}} /></template>);

    assert.dom("input[type=file]").hasAttribute("accept", "video/*,.json");

    await triggerEvent(".nvp__file-drop", "drop", {
      dataTransfer: transferOf([fileOf("notes.txt", "text/plain")]),
    });
    assert.verifySteps([], "a text file is not taken");

    await triggerEvent(".nvp__file-drop", "drop", {
      dataTransfer: transferOf([fileOf("notes.txt", "text/plain"), fileOf("graph.JSON", "")]),
    });
    assert.verifySteps(["file graph.JSON"], "the extension matches without case");
  });

  test("without @multiple, only the first file is passed", async function (assert) {
    const handle = (files: File[]) => {
      for (const file of files) assert.step(`file ${file.name}`);
    };

    await render(<template><FileDrop @onFiles={{handle}} /></template>);

    await triggerEvent(".nvp__file-drop", "drop", {
      dataTransfer: transferOf([fileOf("a.webm", "video/webm"), fileOf("b.webm", "video/webm")]),
    });
    assert.verifySteps(["file a.webm"]);
  });

  test("with @multiple, every file is passed", async function (assert) {
    const handle = (files: File[]) => {
      for (const file of files) assert.step(`file ${file.name}`);
    };

    await render(<template><FileDrop @multiple={{true}} @onFiles={{handle}} /></template>);

    assert.dom("input[type=file]").hasProperty("multiple", true);

    await triggerEvent(".nvp__file-drop", "drop", {
      dataTransfer: transferOf([fileOf("a.webm", "video/webm"), fileOf("b.webm", "video/webm")]),
    });
    assert.verifySteps(["file a.webm", "file b.webm"]);
  });

  test("the block replaces the text and knows about the drag", async function (assert) {
    const handle = () => {};

    await render(
      <template>
        <FileDrop @onFiles={{handle}} as |zone|>
          {{if zone.isDragging "Let go to load" "Drop a video"}}
        </FileDrop>
      </template>,
    );

    assert.dom(".nvp__file-drop").hasText("Drop a video");

    await triggerEvent(".nvp__file-drop", "dragenter", {
      dataTransfer: transferOf([fileOf("clip.webm", "video/webm")]),
    });

    assert.dom(".nvp__file-drop").hasText("Let go to load");
  });
});
