import { test, expect } from "@playwright/test";

/**
 * Mobile app-shell contract (Jack's rule: every UI-facing change ships a
 * Playwright test at the 411×761 mobile viewport before merge).
 *
 * What this pins:
 *  1. URL-bar stability — the mechanism is a NON-scrolling document. Mobile
 *     browsers only collapse the URL bar when the *document* scrolls; our shell
 *     makes html/body `overflow:hidden` at a fixed `100dvh`, so the document
 *     can't scroll and the bar stays put. We assert the document is pinned.
 *  2. Content is still reachable — scrolling is delegated to ONE bounded inner
 *     region, so a page taller than the viewport must have a scrollable inner
 *     scroller (else content would be clipped by the overflow:hidden shell).
 *  3. FOUC guard — the `:not(:defined)` rule ships (custom elements stay hidden
 *     until upgraded) and nothing is left stuck undefined after load.
 *  4. feedback-fab (dev-only) — present + upgraded with the right repo when the
 *     dev build injected it. Gated on EXPECT_FAB so the prod dist (no fab) still
 *     passes in CI.
 */

const MOBILE = { width: 411, height: 761 };
// A guaranteed-tall route so the inner-scroll assertion is meaningful.
const LONG_ROUTE = "/reference";

test.use({ viewport: MOBILE });

test("mobile shell: document does not scroll (URL bar stays visible)", async ({ page }) => {
  await page.goto(LONG_ROUTE);
  // No networkidle: elm-pages dev holds a /stream SSE open. Wait on the shell.
  await expect(page.locator("#docs-app-bar")).toBeVisible();

  // html + body are the fixed, non-scrolling shell.
  const overflow = await page.evaluate(() => ({
    html: getComputedStyle(document.documentElement).overflowY,
    body: getComputedStyle(document.body).overflowY,
    bodyH: document.body.clientHeight,
    innerH: window.innerHeight,
  }));
  expect(overflow.html).toBe("hidden");
  expect(overflow.body).toBe("hidden");
  // The shell fits the visible viewport (no vh-vs-dvh bottom overhang).
  expect(Math.abs(overflow.bodyH - overflow.innerH)).toBeLessThanOrEqual(2);

  // The document is pinned: trying to scroll it does nothing → the mobile URL
  // bar never gets a document-scroll signal to collapse.
  const scrolled = await page.evaluate(() => {
    window.scrollTo(0, 10000);
    return { x: window.scrollX, y: window.scrollY };
  });
  expect(scrolled.y).toBe(0);
});

test("mobile shell: content scrolls in a bounded inner region (nothing clipped)", async ({ page }) => {
  await page.goto(LONG_ROUTE);
  await expect(page.locator("#docs-app-bar")).toBeVisible();

  // Find the effective scroller for the main content, piercing shadow roots
  // (the m3e-drawer-container scrolls its content in shadow DOM). We assert at
  // least one descendant is a real overflow scroller with content taller than
  // its box, and that setting scrollTop actually moves it.
  const scroll = await page.evaluate(() => {
    const scrollers: Element[] = [];
    const visit = (root: Document | ShadowRoot) => {
      for (const el of Array.from(root.querySelectorAll("*"))) {
        const cs = getComputedStyle(el);
        const oy = cs.overflowY;
        if (
          (oy === "auto" || oy === "scroll") &&
          el.scrollHeight - el.clientHeight > 20
        ) {
          scrollers.push(el);
        }
        if ((el as HTMLElement).shadowRoot) visit((el as HTMLElement).shadowRoot!);
      }
    };
    visit(document);
    if (scrollers.length === 0) return { found: false, moved: 0, max: 0 };
    // Drive the deepest/largest scroller and confirm it actually moves.
    const target = scrollers.sort(
      (a, b) => b.scrollHeight - b.clientHeight - (a.scrollHeight - a.clientHeight),
    )[0];
    target.scrollTop = 300;
    return {
      found: true,
      moved: target.scrollTop,
      max: target.scrollHeight - target.clientHeight,
    };
  });

  expect(scroll.found).toBe(true);
  expect(scroll.max).toBeGreaterThan(20);
  expect(scroll.moved).toBeGreaterThan(0);
});

test("FOUC guard is shipped and nothing stays undefined after load", async ({ page }) => {
  await page.goto("/");
  await expect(page.locator("#docs-app-bar")).toBeVisible();

  // The `:not(:defined)` hide rule is present in a loaded stylesheet.
  const hasGuard = await page.evaluate(() => {
    for (const ss of Array.from(document.styleSheets)) {
      let rules: CSSRuleList;
      try {
        rules = ss.cssRules;
      } catch {
        continue; // cross-origin sheet — skip
      }
      for (const r of Array.from(rules)) {
        const sel = (r as CSSStyleRule).selectorText;
        if (sel && sel.includes(":not(:defined)")) return true;
      }
    }
    return false;
  });
  expect(hasGuard).toBe(true);

  // After load, the themed shell is upgraded (not stuck hidden).
  const undefinedCount = await page.evaluate(
    () => document.querySelectorAll(":not(:defined)").length,
  );
  expect(undefinedCount).toBe(0);
  const themeOpacity = await page
    .locator("m3e-theme")
    .first()
    .evaluate((el) => getComputedStyle(el).opacity);
  expect(themeOpacity).toBe("1");
});

// Dev-only: the widget is compiled out of the prod build, so only assert it when
// the run targets a dev server (EXPECT_FAB=1).
test("feedback-fab is present and upgraded in dev", async ({ page }) => {
  test.skip(!process.env.EXPECT_FAB, "prod build strips the dev-only feedback-fab");
  await page.goto("/");
  const fab = page.locator("feedback-fab");
  await expect(fab).toHaveCount(1);
  await expect(fab).toHaveAttribute("repo", "jackhp95/elm-m3e");
  // The widget bundle is injected as a dynamically-created <script> (async, not
  // parser-`defer`ed), so upgrade is not synchronous with page load — wait for
  // the bundle to load and register the custom element.
  await page.waitForFunction(
    () => document.querySelector("feedback-fab")?.matches(":defined") === true,
    { timeout: 15000 },
  );
});
