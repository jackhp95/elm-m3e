import { test, expect } from "@playwright/test";

/**
 * The drawer's Components group groups components by category (Actions,
 * Communication, Containment, Navigation, Selection, Text inputs, Layout & style),
 * each category displayed as a sub-group within the Components group.
 * `componentCategories` (the 7 editorial categories in `Shared.elm`) was
 * previously used only for the `/components/all` kitchen-sink page, but is now
 * also used to structure the drawer's Components group.
 */
test("drawer groups components by category", async ({ page }) => {
  await page.goto("/components/button");
  // At a desktop width the tree is already pinned open (`Shared.init` seeds
  // `treeOpen` from `treePinsOpen`), so there is nothing to click first —
  // tapping the hamburger here would CLOSE it.

  // The "Components" nav group auto-opens on any /components/* route
  // (Shared.componentsGroup), so its children are already visible without an
  // extra expand click. Verify "All components" is visible.
  const drawer = page.locator(".primary-nav-drawer");
  await expect(drawer.getByRole("link", { name: "All components", exact: true })).toBeVisible();

  // Components are now grouped by category. Verify the category headers exist.
  // We check for the category text in the drawer (these appear as slot="label"
  // in the navMenuItem elements for category groups).
  for (const category of [
    "Actions",
    "Communication",
    "Containment",
    "Navigation",
    "Selection",
    "Text inputs",
    "Layout & style",
  ]) {
    // Exact match, not `.filter({ hasText })` (a SUBSTRING match): with a
    // substring match a category renamed to "Navigation & routing" would still
    // satisfy "Navigation", and "Actions" would be satisfied by any longer
    // label containing it -- so the assertion could not fail for the reason it
    // exists.
    await expect(drawer.getByText(category, { exact: true }).first()).toBeVisible();
  }
  // Verify Button is accessible (should be visible when on /components/button route)
  await expect(drawer.getByRole("link", { name: "Button", exact: true })).toBeVisible();
});

test("Reference is dissolved into Guide", async ({ page }) => {
  await page.goto("/guide");
  // Pinned open at a desktop width — see the note in the test above.

  // Reference is gone as its own group (a non-interactive `NavMenuItem.label`
  // group title, hence a text check, not a role check); its 4 links live
  // under Guide instead, as real `navLeaf` anchors (role "link" is correct
  // here — `navLeaf` renders a genuine `TypedHtml.a [ href ]`, unlike the
  // rail's `m3e-nav-item`, which is role "button" — see nav-rail-layout.md
  // Task 1).
  const drawer = page.locator(".primary-nav-drawer");
  await expect(drawer.getByText("Reference", { exact: true })).toHaveCount(0);

  // The 4 Reference links now live under Guide, as real navLeaf anchors
  // within the drawer
  await expect(drawer.getByRole("link", { name: "Full API reference", exact: true })).toBeVisible();
  await expect(drawer.getByRole("link", { name: "Round-trip report", exact: true })).toBeVisible();
  await expect(drawer.getByRole("link", { name: "Cheat sheet", exact: true })).toBeVisible();
  await expect(drawer.getByRole("link", { name: "Glossary", exact: true })).toBeVisible();
});
