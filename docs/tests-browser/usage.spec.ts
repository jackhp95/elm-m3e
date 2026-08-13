import { test, expect } from "@playwright/test";

/**
 * The per-component Usage section renders a live preview plus the derived Elm
 * across the available API surfaces, switched by a per-example tab strip.
 *
 * Two rendering facts shape these assertions:
 *  - the code is syntax-highlighted, so a token like `M3e.Button.view` is split
 *    across multiple spans (no single leaf holds it contiguously), and
 *  - long code blocks fold into `<details class="cf-fold">`, which render OPEN
 *    by default as of Phase C, so their text is present and visible; every
 *    surface's panel is mounted at once (the tab strip slides between them, with
 *    inactive panels `inert`/off-screen).
 * So we assert code *presence* (`toBeAttached`) for surfaces behind inactive tabs,
 * reserve visibility checks for stable, unfolded anchors (the Usage heading and
 * the tab strip), and separately assert the `open` attribute on every fold.
 *
 * NOTE (phantom substrate migration): The barrel (M3e.button), middle
 * (M3e.Html.Button.button), and bottom (M3e.Raw.Button.button) surfaces are
 * not generated in the phantom substrate (gen-barrel and gen-record-build are
 * no-ops; M3e.Html and M3e.Raw layers retired). The top surface (M3e.Button.view)
 * and raw HTML are always present; Record/Build show a rationale tab.
 */
test("/components/button shows a live Usage section with preview + code", async ({
  page,
}) => {
  const errors: string[] = [];
  page.on("console", (m) => {
    if (m.type() === "error") errors.push(m.text());
  });
  page.on("pageerror", (e) => errors.push(String(e)));

  await page.goto("/components/button");
  // Not `waitForLoadState("networkidle")`: the elm-pages dev server holds a
  // long-lived `/stream` SSE connection open, so network idle never fires.
  await page.waitForFunction(() => {
    const hosts = [...document.querySelectorAll("raw-html")];
    return hosts
      .flatMap((h) => [...h.querySelectorAll("m3e-button")])
      .some((el) => (el as HTMLElement & { shadowRoot: unknown }).shadowRoot);
  });

  // (1) Usage heading present.
  await expect(page.getByText("Usage", { exact: true }).first()).toBeVisible();

  // (2) The live preview populated and upgraded.
  const upgraded = await page.evaluate(() => {
    const hosts = [...document.querySelectorAll("raw-html")];
    return hosts
      .flatMap((h) => [...h.querySelectorAll("m3e-button")])
      .some((el) => Boolean((el as HTMLElement & { shadowRoot: unknown }).shadowRoot));
  });
  expect(upgraded).toBe(true);

  // (3) The derived M3e (Standard) code is rendered (attached; may be folded).
  // The barrel form (M3e.button) is not generated in the phantom substrate;
  // the top surface uses the qualified form M3e.Button.view.
  await expect(page.getByText("M3e.Button.view").first()).toBeAttached();

  // Code folds render OPEN by default (Phase C). Assert with count queries
  // (race-free vs a per-fold loop): at least one fold exists and none lack `open`.
  await expect(page.locator("details.cf-fold").first()).toBeAttached();
  await expect
    .poll(async () => page.locator("details.cf-fold:not([open])").count())
    .toBe(0);

  expect(errors, `console errors:\n${errors.join("\n")}`).toEqual([]);
});

test("/components/button renders code for the available API surfaces", async ({
  page,
}) => {
  await page.goto("/components/button");
  // Wait for the Standard (top) surface code to be rendered. Barrel form
  // (M3e.button) is not generated in the phantom substrate; top uses M3e.Button.view.
  await page.waitForFunction(() =>
    [...document.querySelectorAll("code.elmsh")].some((c) =>
      (c.textContent || "").includes("M3e.Button.view"),
    ),
  );

  // Each surface's panel is mounted. Top (M3e.Button.view) and raw HTML are
  // always present. Mid/bottom (M3e.Html.*/M3e.Raw.*) are null in the phantom
  // substrate, so their tabs are absent. Match on text present in the rendered page.
  for (const code of [
    "M3e.Button.view", // M3e top surface (Standard form)
    "<m3e-button", // raw HTML
  ]) {
    await expect(page.getByText(code).first()).toBeAttached();
  }

  // The layer tab strip is rendered. Only "M3e" and "HTML" tabs are guaranteed
  // present in the phantom substrate (mid/bottom retired). Check "M3e" tab.
  const m3eTab = page.getByText("M3e", { exact: true }).first();
  await expect(m3eTab).toBeVisible();
});

// Helpers for discriminating between Usage and API tab strips.
//
// The API strip (added by the API-reference-reorg) contains tabs "M3e",
// "Components", "Builder" (capital C/B). Usage strips contain tabs "M3e",
// "component", "build", "HTML" (lowercase c/b, plus HTML). The presence of
// a tab with text "Components" or "Builder" (exactly) uniquely identifies the
// API strip.
function isApiStrip(strip: Element): boolean {
  const tabs = [...strip.querySelectorAll("m3e-tab")];
  return tabs.some(
    (t) =>
      t.textContent?.trim() === "Components" ||
      t.textContent?.trim() === "Builder",
  );
}

function getSelectedTabText(strip: Element): string | undefined {
  const tabs = [...strip.querySelectorAll("m3e-tab")];
  return tabs.find((t) => t.hasAttribute("selected"))?.textContent?.trim();
}

test("/components/button Usage tab sync: clicking a tab updates all examples", async ({
  page,
}) => {
  await page.goto("/components/button");

  // Wait for the first Usage tab strip to appear and be interactive.
  // NOTE: The docs DEV server (:1234) does NOT wire Elm event listeners onto
  // SSR-hydrated <m3e-*> nodes. This test MUST run against the PROD build
  // served at :1239 (gate), never the dev server. Interactivity failures on
  // :1234 are false negatives, not bugs.
  await page.waitForFunction(() =>
    [...document.querySelectorAll("code.elmsh")].some((c) =>
      (c.textContent || "").includes("M3e.Button.view"),
    ),
  );

  // Discriminator: Usage strips contain an "HTML" tab; the API strip (added by
  // API-reorg) contains "Components"/"Builder" (capital) and has no "HTML" tab.
  // We scope the sync assertion to Usage-section strips only.
  const allStrips = page.locator("m3e-tabs");
  const totalCount = await allStrips.count();

  // The button component has at least one Usage example; skip this test if
  // somehow none render (data pipeline issue, not a tab-sync issue).
  if (totalCount < 1) {
    return;
  }

  // Identify the first Usage strip (has "HTML" tab) for initial click.
  // In practice Usage strips come before the API strip in the DOM.
  const firstUsageStrip = allStrips
    .filter({ has: page.locator("m3e-tab", { hasText: "HTML" }) })
    .first();
  await expect(firstUsageStrip).toBeAttached();

  // Click the "HTML" tab on the first Usage strip.
  await firstUsageStrip.getByText("HTML", { exact: true }).click();

  // After clicking, every USAGE strip should show "HTML" as selected. The API
  // strip is explicitly excluded: it has no HTML tab and should not be checked.
  await page.waitForFunction(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const usageStrips = strips.filter((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "HTML");
    });
    if (usageStrips.length < 2) return true; // Only one usage example — sync trivially holds
    return usageStrips.every((strip) => {
      const tabs = [...strip.querySelectorAll("m3e-tab")];
      const selected = tabs.find((t) => t.hasAttribute("selected"));
      return selected?.textContent?.trim() === "HTML";
    });
  });

  // Verify persistence: the selection must survive a reload.
  await page.reload();
  await page.waitForFunction(() =>
    [...document.querySelectorAll("code.elmsh")].some((c) =>
      (c.textContent || "").includes("<m3e-button"),
    ),
  );

  // After reload, at least one usage strip must show HTML as the active tab.
  const htmlTabActive = await page.evaluate(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const usageStrips = strips.filter((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "HTML");
    });
    return usageStrips.some((strip) => {
      const tabs = [...strip.querySelectorAll("m3e-tab")];
      const selected = tabs.find((t) => t.hasAttribute("selected"));
      return selected?.textContent?.trim() === "HTML";
    });
  });
  expect(htmlTabActive).toBe(true);
});

test("/components/button API strip and Usage strips share activeSurface state", async ({
  page,
}) => {
  // Label mapping between API and Usage strips (same shared activeSurface):
  //   API "M3e"        == Usage "M3e"       == Surface Top
  //   API "Components" == Usage "component"  == Surface Record
  //   API "Builder"    == Usage "build"      == Surface Build
  // The API strip has no "HTML" / Raw surface tab.

  await page.goto("/components/button");

  // Wait for Elm hydration and code rendering.
  await page.waitForFunction(() =>
    [...document.querySelectorAll("code.elmsh")].some((c) =>
      (c.textContent || "").includes("M3e.Button.view"),
    ),
  );

  // Locate the API strip (has "Components" tab, capital C) and the first Usage
  // strip (has "HTML" tab). Both must be present for the cross-sync test.
  const apiStrip = page
    .locator("m3e-tabs")
    .filter({ has: page.locator("m3e-tab", { hasText: "Components" }) })
    .first();
  const firstUsageStrip = page
    .locator("m3e-tabs")
    .filter({ has: page.locator("m3e-tab", { hasText: "HTML" }) })
    .first();

  await expect(apiStrip).toBeAttached();
  await expect(firstUsageStrip).toBeAttached();

  // --- Part A: clicking a Usage strip tab → API strip reflects shared surface ---
  // Click "M3e" on the first Usage strip (resets to Top surface if it moved).
  await firstUsageStrip.getByText("M3e", { exact: true }).click();

  // API strip should show "M3e" selected (Top surface).
  await page.waitForFunction(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const apiStrip = strips.find((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "Components");
    });
    if (!apiStrip) return false;
    const tabs = [...apiStrip.querySelectorAll("m3e-tab")];
    const selected = tabs.find((t) => t.hasAttribute("selected"));
    return selected?.textContent?.trim() === "M3e";
  });

  // --- Part B: clicking the API strip tab → Usage strips reflect shared surface ---
  // Click "Components" on the API strip → should move Usage strips to "component".
  await apiStrip.getByText("Components", { exact: true }).click();

  // All Usage strips should now show "component" selected (Record surface).
  await page.waitForFunction(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const usageStrips = strips.filter((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "HTML");
    });
    if (usageStrips.length === 0) return false;
    return usageStrips.every((strip) => {
      const tabs = [...strip.querySelectorAll("m3e-tab")];
      const selected = tabs.find((t) => t.hasAttribute("selected"));
      return selected?.textContent?.trim() === "component";
    });
  });

  // API strip should also show "Components" selected.
  await page.waitForFunction(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const apiStrip = strips.find((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "Components");
    });
    if (!apiStrip) return false;
    const tabs = [...apiStrip.querySelectorAll("m3e-tab")];
    const selected = tabs.find((t) => t.hasAttribute("selected"));
    return selected?.textContent?.trim() === "Components";
  });

  // --- Part C: clicking API "Builder" → Usage strips move to "build" ---
  await apiStrip.getByText("Builder", { exact: true }).click();

  await page.waitForFunction(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const usageStrips = strips.filter((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "HTML");
    });
    if (usageStrips.length === 0) return false;
    return usageStrips.every((strip) => {
      const tabs = [...strip.querySelectorAll("m3e-tab")];
      const selected = tabs.find((t) => t.hasAttribute("selected"));
      return selected?.textContent?.trim() === "build";
    });
  });

  // --- Part D: setting Usage to HTML → API strip does not crash or show "HTML" ---
  // HTML / Raw surface is not offered by the API strip, so clicking HTML on a
  // Usage strip has no matching API tab. The API strip may show no tab selected
  // (activeSurface=Raw is simply unmapped for the API strip). We only assert that
  // no tab on the API strip is falsely labelled "HTML" — it has no such tab.

  // Click "HTML" on the first Usage strip.
  await firstUsageStrip.getByText("HTML", { exact: true }).click();

  // Usage strips should show "HTML".
  await page.waitForFunction(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const usageStrips = strips.filter((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "HTML");
    });
    return usageStrips.every((strip) => {
      const tabs = [...strip.querySelectorAll("m3e-tab")];
      const selected = tabs.find((t) => t.hasAttribute("selected"));
      return selected?.textContent?.trim() === "HTML";
    });
  });

  // API strip has no "HTML" tab: confirm none of its tabs show text "HTML"
  // (structural sanity — the reorg must not have accidentally added an HTML tab).
  const apiHasHtmlTab = await page.evaluate(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    const apiStrip = strips.find((s) => {
      const tabs = [...s.querySelectorAll("m3e-tab")];
      return tabs.some((t) => t.textContent?.trim() === "Components");
    });
    if (!apiStrip) return false;
    const tabs = [...apiStrip.querySelectorAll("m3e-tab")];
    return tabs.some((t) => t.textContent?.trim() === "HTML");
  });
  expect(apiHasHtmlTab).toBe(false);
});
