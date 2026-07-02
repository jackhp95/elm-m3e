import { test, expect } from "@playwright/test";

/**
 * Plan 3 B3 — the per-component Usage section renders:
 *   1. a "Usage" heading appears above the "API" heading,
 *   2. the live preview (<raw-html>) populates and its <m3e-*> upgrades
 *      (has a shadowRoot), inheriting the page theme,
 *   3. a code block shows the derived M3e Elm.
 */
test("/components/button shows a live Usage section with code", async ({
  page,
}) => {
  const errors: string[] = [];
  page.on("console", (m) => {
    if (m.type() === "error") errors.push(m.text());
  });
  page.on("pageerror", (e) => errors.push(String(e)));

  await page.goto("/components/button");
  await page.waitForLoadState("networkidle");

  // (1) Usage heading present.
  await expect(page.getByText("Usage", { exact: true }).first()).toBeVisible();

  // (2) The live preview populated and upgraded: a raw-html host contains an
  //     m3e-button that has a shadowRoot.
  const upgraded = await page.evaluate(() => {
    const hosts = [...document.querySelectorAll("raw-html")];
    const btn = hosts
      .flatMap((h) => [...h.querySelectorAll("m3e-button")])
      .find((el) => (el as HTMLElement & { shadowRoot: unknown }).shadowRoot);
    return Boolean(btn);
  });
  expect(upgraded).toBe(true);

  // (3) The code block shows the M3e Elm the preview was derived from.
  await expect(page.getByText("M3e.Button.view").first()).toBeVisible();

  expect(errors, `console errors:\n${errors.join("\n")}`).toEqual([]);
});

test("the API-layer toggle switches Usage code across all four layers", async ({
  page,
}) => {
  await page.goto("/components/button");
  await page.waitForLoadState("networkidle");

  // Default layer = Top: strict M3e.* Elm.
  await expect(page.getByText("M3e.Button.view").first()).toBeVisible();

  await page.locator('[aria-label="Theme settings"]').click();

  // Middle -> M3e.Cem.Button.button
  await page.getByText("Middle", { exact: true }).click();
  await expect(page.getByText("M3e.Cem.Button.button").first()).toBeVisible();

  // Bottom -> M3e.Cem.Html.Button.button
  await page.getByText("Bottom", { exact: true }).click();
  await expect(
    page.getByText("M3e.Cem.Html.Button.button").first(),
  ).toBeVisible();

  // HTML -> raw <m3e-button ...> markup
  await page.getByText("HTML", { exact: true }).click();
  await expect(page.getByText("<m3e-button").first()).toBeVisible();

  // Back to Top.
  await page.getByText("Top", { exact: true }).click();
  await expect(page.getByText("M3e.Button.view").first()).toBeVisible();
});
