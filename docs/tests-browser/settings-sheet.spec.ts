import { expect, test } from "@playwright/test";

/**
 * `Shared.settingsBottomSheet` is opened by a native `m3e-bottom-sheet-trigger`
 * nested inside the settings icon button (`Shared.settingsButton`) -- the
 * trigger's own `_onClick` calls `.show()` directly, with no Elm round-trip.
 * Dismissal (a swipe-down, an outside click, or Escape) is likewise entirely
 * element-owned; Elm no longer mirrors any of this in its model at all. This
 * is exactly the kind of runtime-only contract `Test.Html` cannot see (see
 * `contract.spec.ts`'s header comment) and this interaction has a documented
 * history of racing between the element and Elm's own render round-trip (see
 * `Shared.settingsBottomSheet`'s doc comment) -- so it gets its own coverage
 * here rather than relying on unit tests alone.
 */
test("the settings bottom sheet opens from the app bar and closes on Escape", async ({
  page,
}) => {
  await page.goto("/getting-started/welcome");

  const sheet = page.locator("#settings-sheet");
  await expect(sheet).not.toHaveAttribute("open", "");

  await page.getByRole("button", { name: "Settings" }).click();
  await expect(sheet).toHaveAttribute("open", "");

  await page.keyboard.press("Escape");
  await expect(sheet).not.toHaveAttribute("open", "");
});

test("the settings bottom sheet closes on an outside click", async ({ page }) => {
  await page.goto("/getting-started/welcome");

  const sheet = page.locator("#settings-sheet");
  await page.getByRole("button", { name: "Settings" }).click();
  await expect(sheet).toHaveAttribute("open", "");

  // `modal` scrims the page; the dismiss-outside-listener attach is deferred a
  // frame (see `Shared.settingsBottomSheet`'s doc comment), so click well away
  // from both the trigger and the sheet's own content.
  await page.mouse.click(5, 5);
  await expect(sheet).not.toHaveAttribute("open", "");
});
