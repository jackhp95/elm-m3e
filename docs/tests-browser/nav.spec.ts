import { test, expect } from "@playwright/test";

/**
 * The drawer's Components group lists every component as ONE flat,
 * alphabetically-sorted list — not grouped by category. `componentCategories`
 * (the 7 editorial categories in `Shared.elm`) is real, used data, but it
 * orders the `/components/all` kitchen-sink page, not the drawer.
 * `Shared.componentsGroup` has been flat by design since the current app
 * shell's initial commit (`32e4f1e6`) — a wholesale rewrite of an older
 * `Shared.elm` that this test was originally written against, back when the
 * drawer did group by category.
 *
 * (See jackhp95/elm-m3e#212 — closed as stale: the category-grouped drawer
 * the test expected no longer exists, so the pre-existing test was updated to
 * match the current, intentional flat design rather than the other way
 * around.)
 */
test("drawer lists every component alphabetically under one Components group", async ({
  page,
}) => {
  await page.goto("/components/button");
  // The nav drawer starts closed (`Shared.Model.showMenu = False`) — open it
  // before asserting on its contents.
  await page.getByRole("button", { name: "Toggle navigation" }).click();

  // The "Components" nav group auto-opens on any /components/* route
  // (Shared.componentsGroup), so its children are already visible without an
  // extra expand click.
  await expect(page.getByRole("link", { name: "All components", exact: true })).toBeVisible();
  // A sampling of components render as flat, alphabetically-sorted leaves —
  // no category sub-group headers anywhere in between.
  for (const label of ["App Bar", "Button", "Tooltip"]) {
    await expect(page.getByRole("link", { name: label, exact: true })).toBeVisible();
  }
});
