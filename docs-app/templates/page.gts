import { Page } from "kolay/components";

function removeLoader() {
  requestAnimationFrame(() => {
    document.querySelector("#kolay__loading")?.remove();
  });
}

function errorMessage(error: string | { reason: string; original: Error }): string {
  if (typeof error === "string") return error;

  return error.reason;
}

<template>
  <Page>
    <:pending>
      <div class="docs-page-loading">
        Loading&hellip;
      </div>
    </:pending>

    <:error as |error|>
      <div class="docs-page-error" data-page-error>
        {{errorMessage error}}
      </div>
      {{(removeLoader)}}
    </:error>

    <:success as |Prose|>
      <Prose />
      {{(removeLoader)}}
    </:success>

  </Page>
</template>
