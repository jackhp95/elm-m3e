import { expect, test } from "@playwright/test";

/**
 * App-shell layout contract — pins the CURRENT split between the two branches
 * of `Shared.view`:
 *
 *  - `/` (docs shell): `<m3e-theme>` (itself `display: contents` — it carries
 *    no layout classes of its own anymore) renders a fixed-viewport
 *    `<div class="h-dvh flex flex-row">` with a nav rail on the left and a main
 *    column on the right holding the app bar above the drawer/content area. The
 *    ONE scroll region is the content-pane inside the drawer (`overflow-y: auto`);
 *    the shell div itself does not scroll.
 *  - `/examples/*` (full-viewport examples): `<m3e-theme>`'s child is the
 *    example page's OWN root — no docs-shell wrapper, no app bar, no nav —
 *    so double-nav is avoided and the page owns 100% of its own layout.
 *
 * Two failure modes are in scope and both are silent — no compile error, no
 * console warning:
 *
 *  1. Branch collapse. If the docs-shell wrapper is ever rendered for
 *     `/examples/*` too, an example gains a second app bar/nav it never
 *     asked for.
 *  2. A tall example's content becoming unreachable. Each example page is
 *     responsible for its OWN scrolling (internal `overflow-y-auto`, or the
 *     document itself) — nothing in the shared shell provides that for it.
 *     If an example page's root stops being tall enough to scroll (or a
 *     future ancestor re-adds a clipping `overflow: hidden`), content past
 *     the fold silently becomes unreachable rather than erroring.
 */
const DOCS_SHELL = "m3e-theme > div.h-dvh.flex.flex-row";
const MAIN_COLUMN = `${DOCS_SHELL} > div.flex.flex-1.flex-col`;

// A `/examples/*` route whose content is taller than the viewport, so the
// "content is reachable" assertion is meaningful rather than vacuous.
const TALL_EXAMPLE = "/examples/shop";

test("the docs shell is a fixed-viewport flex row (rail | main column) with one scroll region", async ({
  page,
}) => {
  await page.goto("/");
  await expect(page.locator("#docs-app-bar")).toBeVisible();

  const shell = page.locator(DOCS_SHELL);
  // `flex` + `flex-row` places the nav rail on the left and the main column on
  // the right. If this reads `contents` or `block`, the shell has flattened.
  await expect(shell).toHaveCSS("display", "flex");
  await expect(shell).toHaveCSS("flex-direction", "row");

  // The shell itself must NOT be the scroller — the content-pane inside the
  // drawer is the one bounded scroll region (`Shared.drawerShell`).
  await expect(shell).toHaveCSS("overflow-y", "visible");

  const mainColumn = page.locator(MAIN_COLUMN);
  await expect(mainColumn).toHaveCSS("display", "flex");
  await expect(mainColumn).toHaveCSS("flex-direction", "column");

  await expect(page.locator("#main-content m3e-content-pane").first()).toHaveCSS(
    "overflow-y",
    "auto",
  );
});

test("a full-viewport example route skips the docs shell entirely", async ({ page }) => {
  await page.goto(TALL_EXAMPLE);

  // No docs-shell wrapper, no docs app bar, no docs nav main landmark — the
  // example owns its own chrome instead of getting a second one layered on.
  await expect(page.locator(DOCS_SHELL)).toHaveCount(0);
  await expect(page.locator("#docs-app-bar")).toHaveCount(0);
  await expect(page.locator("#main-content")).toHaveCount(0);
});

test("a tall example's content is reachable, not clipped off past the fold", async ({
  page,
}) => {
  await page.goto(TALL_EXAMPLE);

  // The page's own footer strip (`ExampleNav.footer`) sits at the very end of
  // its content — reachable only if SOMETHING scrolls (the document itself,
  // or the page's own internal scroll region; the shared shell contract
  // doesn't care which).
  const footerLink = page.getByRole("link", { name: "← Back to examples" });
  await expect(footerLink).not.toBeInViewport();

  await footerLink.scrollIntoViewIfNeeded();
  await expect(footerLink).toBeInViewport();
});

test("a component page composes rail, tree, content, and TOC together", async ({ page }) => {
  await page.goto("/components/button");

  // Rail: present, Components selected. `m3e-nav-item` is upgraded to
  // role="link" (href is set on every rail item — see nav-rail.spec.ts).
  await expect(
    page.locator("m3e-nav-rail").getByRole("link", { name: "Components", exact: true }),
  ).toHaveAttribute("selected", "");

  // Tree: pinned open on desktop, showing Button's category.
  await expect(page.locator("#docs-drawer")).toHaveAttribute("start", "");
  await expect(
    page.locator("#docs-drawer [slot='start']").getByText("Actions", { exact: true }),
  ).toBeVisible();

  // Content: the page's own heading renders in the content pane.
  await expect(
    page
      .locator("#main-content m3e-content-pane")
      .first()
      .getByRole("heading", { name: "Button" }),
  ).toBeVisible();

  // TOC: pinned open on desktop (no toggle button needed — see toc.spec.ts),
  // the API jump-link is visible in the end drawer slot.
  await expect(
    page.locator("#docs-drawer [slot='end']").getByRole("link", { name: "API" }),
  ).toBeVisible();
});

test("the shell carries the document direction", async ({ page }) => {
  await page.goto("/");
  await expect(page.locator("#docs-app-bar")).toBeVisible();

  const theme = page.locator("m3e-theme").first();
  // `dir` lives on the `m3e-theme` host itself (part of elm-cem's open-row
  // `_globals` axis), so direction must resolve there and inherit down to the
  // app bar and drawer. A missing `dir` would leave the RTL control in the
  // settings sheet with nothing to flip.
  await expect(theme).toHaveAttribute("dir", /^(ltr|rtl|auto)$/);
  await expect(theme).toHaveCSS("direction", "ltr");
});
