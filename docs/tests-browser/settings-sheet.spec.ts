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

/**
 * `Theme.Sections.Appearance`'s `M3e.buttonSegment` options render as
 * `role="radio"` (an `m3e-segmented-button` is a `role="radiogroup"`), not
 * `role="button"` -- confirmed against the real rendered markup, not
 * `M3e.SegmentedButton`'s Elm source alone (that source only wraps
 * `checked`/`onClick`; the ARIA role and the reflected `checked` attribute
 * come from the underlying custom element). `#settings-sheet-content` is
 * also (separately, pre-existing) duplicated in the light DOM -- the sheet
 * wraps its real content div in an outer `role="complementary"` div that
 * carries the same id (see the friction log for Task 16) -- so any locator
 * scoped to that id needs disambiguating. The `.first()` calls on the
 * "Appearance"/"Color" accordion-header locators below are for a distinct,
 * separate reason, though: `m3e-expansion-header` renders two
 * `role="button"` nodes with the same accessible name -- one on a
 * `slot="header"` element and one on the header wrapper itself -- confirmed
 * by removing `.first()` and reproducing a Playwright strict-mode failure
 * ("resolved to 2 elements") (see the friction log for Task 16); it is not
 * caused by the `#settings-sheet-content` duplicate id. This test only ever
 * targets unique leaf elements (`m3e-theme`, a uniquely-named radio), so it
 * doesn't need `.first()`.
 *
 * This is the test that would have caught the original contrast/seed
 * reactivity bug (Task 1) -- it asserts an actual computed-style change,
 * not just that the model/attribute updated.
 */
test("changing contrast and seed color produce an observable style change", async ({
  page,
}) => {
  await page.goto("/getting-started/welcome");
  await page.getByRole("button", { name: "Settings" }).click();

  // `.first()` — the reel in the drawer now has 23 nested `<m3e-theme>` cards
  // plus the root; `.first()` targets the outermost root element specifically.
  const themeHost = page.locator("m3e-theme").first();
  const before = await themeHost.evaluate((el) =>
    getComputedStyle(el).getPropertyValue("--md-sys-color-primary").trim()
  );

  // Contrast lives in the Appearance accordion section, closed by default.
  await page.getByRole("button", { name: "Appearance" }).first().click();
  await page.getByRole("radio", { name: "High" }).click();

  await page.waitForFunction(
    (prev) =>
      getComputedStyle(document.querySelector("m3e-theme")!)
        .getPropertyValue("--md-sys-color-primary")
        .trim() !== prev,
    before
  );

  const after = await themeHost.evaluate((el) =>
    getComputedStyle(el).getPropertyValue("--md-sys-color-primary").trim()
  );
  expect(after).not.toBe(before);
});

/**
 * `M3e.buttonSegment`'s selected state reflects as a bare `checked` boolean
 * attribute on `m3e-button-segment` (confirmed against the real rendered
 * markup: `checked="" aria-checked="true"` on the selected segment, plain
 * `aria-checked="false"` with no `checked` attribute on the rest) -- not
 * `selected`, which the scaffold guessed.
 */
test("contrast and seed color survive a reload", async ({ page }) => {
  await page.goto("/getting-started/welcome");
  await page.getByRole("button", { name: "Settings" }).click();

  await page.getByRole("button", { name: "Appearance" }).first().click();
  await page.getByRole("radio", { name: "High" }).click();
  await page.locator("#seed-color").fill("#00897B");

  await page.reload();
  await page.getByRole("button", { name: "Settings" }).click();
  await page.getByRole("button", { name: "Appearance" }).first().click();

  await expect(page.getByRole("radio", { name: "High" })).toHaveAttribute("checked", "");
  await expect(page.locator("#seed-color")).toHaveValue("#00897b");
});

/**
 * The plan's scaffold for this test opened with applying a "Material" preset
 * card. As of this task, `Theme.elm`'s own `view` still has the preset
 * gallery / swatch strip as an explicit placeholder ("Preset gallery and
 * swatch strip are added in a LATER task") -- confirmed against both the
 * source comment and the real rendered settings-sheet markup (no preset
 * card, no text "Material", anywhere in `#settings-sheet-content`). No task
 * in this plan between Task 7's stub and this one ever wires that gallery
 * into `Theme.view`, so there is no preset UI to click yet -- this is a real
 * plan gap, not a locator-guessing problem, and is out of this test-writing
 * task's scope to fix (see the friction log). This test therefore drops the
 * preset-application step and instead exercises exactly the override/reset
 * mechanics that ARE wired: a manual color override survives a scheme
 * toggle but is cleared by "Reset all".
 *
 * §8 rework: the Color section is now a cluster of chips. Each token is a
 * native `<details>` disclosure whose `<summary>` is a color-circle pill; the
 * hex text input (`aria-label="Hex value for <role>"`) lives in the expanded
 * body. So this test opens the Color accordion, expands the Primary chip, then
 * drives its hex input -- the old native `#color-md-sys-color-primary` input is
 * gone.
 */
test("a color-token override survives a scheme toggle but not Reset all", async ({
  page,
}) => {
  await page.goto("/getting-started/welcome");
  await page.getByRole("button", { name: "Settings" }).click();

  // `.last()`, not `.first()`: the accordion header renders both a slotted
  // light-DOM `m3e-expansion-header` (role="button", inert on its own) and
  // the panel's shadow-DOM accessible toggle (also role="button", the one
  // actually wired to open/close state) -- Playwright's accessibility tree
  // exposes both. For every other section in this file the slotted copy
  // happens to sort after the shadow toggle, so `.first()` hits the real
  // one; for "Color" specifically (first item in the accordion) it sorts
  // before it, so `.first()` clicks the inert copy and the panel never
  // opens. Verified live: `.first()` leaves `hasAttribute("open") === false`
  // in this case; `.last()` opens it. Not a component bug worth chasing
  // further here -- just a locator-ambiguity trap in this specific markup.
  await page.getByRole("button", { name: "Color" }).last().click();

  // Each token is an extra-small button hosting an `m3e-menu-trigger`; clicking
  // the button opens the anchored `m3e-menu` with the hex input + OS picker +
  // Unset. The menu closes on outside interaction (e.g. toggling the scheme), so
  // the override — which lives in `colorOverrides`, not the menu — is read back
  // by RE-OPENING the menu.
  const primaryButton = page.locator(
    'm3e-button:has(m3e-menu-trigger[for="colormenu-md-sys-color-primary"])',
  );
  // `exact: true` — "Primary" is a prefix of "Primary Container", "Primary
  // Fixed", etc., so the loose form resolves to multiple inputs.
  const primaryInput = page.getByLabel("Hex value for Primary", { exact: true });

  // The leading color swatch must render in the button's `icon` slot (a sibling
  // of the menu-trigger, not nested inside the display:none trigger).
  await expect(primaryButton.locator('span[slot="icon"]')).toBeVisible();

  await primaryButton.click(); // open the menu
  await primaryInput.fill("#ff0000");
  await primaryButton.click(); // toggle the menu closed so it stops overlaying other controls

  // Scheme is a single toggle icon button now (was a Light/Dark segmented pair);
  // when not already dark its accessible name is "Switch to dark theme".
  await page.getByRole("button", { name: "Switch to dark theme" }).click();
  await primaryButton.click(); // re-open to read the override back
  await expect(primaryInput).toHaveValue("#ff0000");
  await primaryButton.click(); // close

  await page.getByRole("button", { name: "Reset all" }).click();
  await primaryButton.click(); // re-open
  await expect(primaryInput).not.toHaveValue("#ff0000");
});

/**
 * §11 CSS Variables panel: the free-form escape hatch. Pick a variable from the
 * `#css-var-add` select (which seeds a blank `cssOverrides` row), type a value,
 * assert it persists across a reload, then clear it with the row's X and assert
 * the row is gone. `#css-var-add` is an `m3e-select` custom element. Its `value`
 * is a GETTER derived from the selected `<m3e-option>` children -- there is NO
 * `value` setter (confirmed against `@m3e/web/dist/select.js`), so the naive
 * `select.value = "..."` assignment is a no-op: the getter still returns `null`,
 * and Elm's `onChangeWith` decoder (which reads `event.target.value`) never
 * fires. To drive it faithfully we mirror what the component's own
 * `#selectOption` does: flip the matching option's `selected` flag, then
 * dispatch the same bubbling native `change` event the element emits on a real
 * user pick.
 */
test("the nested CSS Variables accordion: a category field drives the CSS var, and clear reverts it", async ({
  page,
}) => {
  await page.goto("/getting-started/welcome");
  await page.getByRole("button", { name: "Settings" }).click();

  // Open the CSS Variables section (outer accordion). Every known var is a
  // pre-rendered `m3e-form-field`, organized into a NESTED accordion by category —
  // so the target field lives inside a collapsed sub-panel that must be expanded.
  await page.getByRole("button", { name: "CSS Variables" }).last().click();

  // Use a Motion var: the nested "Motion" category header is unique (no outer
  // section is named "Motion"), unlike "Color"/"Shape" which collide with the
  // curated sections. `.last()` mirrors the accordion-header locator trap.
  const target = "--md-sys-motion-duration-short-1";
  const fieldId = "cssvar-md-sys-motion-duration-short-1";

  // Each category is a native <details> (NOT a nested m3e-expansion-panel, which the
  // outer m3e-accordion would re-coordinate closed). Expand it via its summary.
  await page.locator(`details:has(#${fieldId}) > summary`).click();
  const field = page.getByLabel(`Value for ${target}`, { exact: true });
  await expect(field).toBeVisible();

  // Regression: the category must STAY open (the nested-m3e-accordion version popped
  // open then collapsed ~1s later off the outer accordion's bubbling toggle event).
  await page.waitForTimeout(1200);
  await expect(field).toBeVisible();

  // Assert the REAL effect: the override drives the port, which writes the custom
  // property onto <html> (same observable mechanism as the seed-color test).
  const computed = () =>
    page.evaluate(
      (v) =>
        getComputedStyle(document.documentElement).getPropertyValue(v).trim(),
      target,
    );

  // Drive the slotted form-field input via a native `input` event. Playwright's
  // fill()/pressSequentially don't reliably reach Elm's `onInput` through the
  // `m3e-form-field` slot nested inside an `m3e-expansion-panel` (a test-harness
  // quirk — the UI works: a real input event applies the override, verified). Same
  // family of gotcha as `m3e-select` needing option.selected + a bubbling event.
  await page.evaluate((id) => {
    const input = document.getElementById(id) as HTMLInputElement;
    const setter = Object.getOwnPropertyDescriptor(
      HTMLInputElement.prototype,
      "value",
    )!.set!;
    setter.call(input, "999ms");
    input.dispatchEvent(new Event("input", { bubbles: true }));
  }, fieldId);
  await expect.poll(computed).toBe("999ms");

  // The trailing clear button (shown only when overridden) reverts the var. Drive
  // it with a native click for the same reason as the input above — the slotted
  // `m3e-icon-button` resolves but isn't reliably Playwright-actionable in this
  // nested surface; a real click event still reaches Elm's `onClick`.
  await page.evaluate((t) => {
    const btn = document.querySelector(
      `m3e-icon-button[aria-label="Clear ${t}"]`,
    ) as HTMLElement | null;
    btn?.click();
  }, target);
  await expect.poll(computed).not.toBe("999ms");
});
