import { test, expect } from "@playwright/test";
test("drawer groups components by category", async ({ page }) => {
  await page.goto("/components/button");
  // No `waitForLoadState("networkidle")`: the elm-pages dev server keeps a
  // `/stream` SSE connection open (live-reload), so network idle never fires.
  // The `toBeVisible` assertions below already auto-wait for the nav to render.
  // All 7 category groups render as nav items.
  for (const c of ["Actions","Communication","Containment","Navigation","Selection","Text inputs","Layout & style"]) {
    await expect(page.getByText(c, { exact: true }).first()).toBeVisible();
  }
  // The "Components" nav group auto-opens on any /components/* route
  // (Shared.componentsGroup), so the "All components" leaf is already visible
  // without an extra expand click.
  await expect(page.getByRole("link", { name: "All components" })).toBeVisible();
});
