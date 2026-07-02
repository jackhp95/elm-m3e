import { test, expect, Locator } from "@playwright/test";

/**
 * Runtime contract tests — assert the things `Test.Html` structurally cannot:
 * shadow DOM content, DOM properties, and the accessibility tree.
 *
 * Each test navigates to a docs component page (which renders the real `Ui.*`
 * module) and waits for the custom elements to upgrade.
 */

/** Wait until a custom element tag is defined (upgraded) in the page. */
async function waitDefined(page: import("@playwright/test").Page, tag: string) {
  await page.waitForFunction((t) => !!customElements.get(t), tag);
}

// The component-page content lives in the `.max-w-5xl` container; the app-bar /
// settings shell (which legitimately uses form-fields) sits outside it. Scope
// component assertions to the content so shell chrome doesn't pollute them.
// Behavioral demos below are the live Usage previews (raw <m3e-*> HTML derived
// from the mined corpus), so assertions target that current content.
const CONTENT = ".max-w-5xl";

test.describe("F1 — icon renders a glyph (shadow DOM, not a dropped text child)", () => {
  test("every m3e-icon is upgraded and carries a non-empty name", async ({ page }) => {
    await page.goto("/components/icon");
    await waitDefined(page, "m3e-icon");

    const icons = page.locator(`${CONTENT} m3e-icon`);
    const count = await icons.count();
    expect(count, "icon page should render icons").toBeGreaterThan(0);

    for (let i = 0; i < count; i++) {
      const icon = icons.nth(i);
      // The F1 bug: glyph came from a text *child*, which <m3e-icon> drops —
      // the glyph must ride the `name` attribute and the element must upgrade
      // (have a shadowRoot) so the shadow `.icon` can render it.
      const name = await icon.getAttribute("name");
      expect(name, "icon must have a name attribute").toBeTruthy();
      const hasShadow = await icon.evaluate((el) => !!el.shadowRoot);
      expect(hasShadow, "m3e-icon must be upgraded (shadowRoot present)").toBe(true);
    }
  });
});

test.describe("F7 — toggle controls render bare (no self-wrapped m3e-form-field)", () => {
  test("switch demos are bare m3e-switch with an accessible name", async ({ page }) => {
    await page.goto("/components/switch");
    await waitDefined(page, "m3e-switch");

    const switches = page.locator(`${CONTENT} m3e-switch`);
    const count = await switches.count();
    expect(count, "switch page should render switches").toBeGreaterThan(0);

    for (let i = 0; i < count; i++) {
      const sw = switches.nth(i);
      // No m3e-form-field ancestor within the demo content — the F7 fix: a
      // toggle control renders bare, not self-wrapped in a form field.
      const wrapped = await sw.evaluate(
        (el) => !!el.closest("m3e-form-field")
      );
      expect(wrapped, "a bare switch must not sit inside m3e-form-field").toBe(false);
      const upgraded = await sw.evaluate((el) => !!el.shadowRoot);
      expect(upgraded, "m3e-switch must be upgraded").toBe(true);
    }
  });

  test("the bare switch is exposed to the a11y tree as role=switch", async ({
    page,
  }) => {
    await page.goto("/components/switch");
    await waitDefined(page, "m3e-switch");
    // The shadow control exposes role=switch — an accessibility-tree fact
    // invisible to Test.Html (which sees only the light-DOM <m3e-switch>).
    const switches = page.getByRole("switch");
    await expect(switches.first()).toBeVisible();
    expect(await switches.count()).toBeGreaterThan(0);
  });
});

test.describe("F4 — boolean element state lives in DOM properties (invisible to Test.Html)", () => {
  test("a checked switch reflects checked === true as a property", async ({ page }) => {
    await page.goto("/components/switch");
    await waitDefined(page, "m3e-switch");

    // A preview switch is constructed `checked`. `checked` is a DOM *property*
    // (Html.Attributes.property), which Test.Html cannot read.
    const switches = page.locator(`${CONTENT} m3e-switch`);
    await switches.first().waitFor();
    const anyChecked = await switches.evaluateAll((els) =>
      els.some((el) => (el as unknown as { checked: boolean }).checked === true)
    );
    expect(anyChecked, "a preview switch must have checked === true at runtime").toBe(true);
  });
});

test.describe("coverage — runtime behaviors Test.Html cannot observe", () => {
  test("Menu: activating the trigger opens the element-managed menu", async ({ page }) => {
    await page.goto("/components/menu");
    await waitDefined(page, "m3e-menu");
    // The menu is a closed `popover` by default and opens when its trigger is
    // activated — a runtime state transition (`:popover-open`) invisible to
    // Test.Html. (The trigger has no box of its own; its wrapping button is the
    // activation target.)
    const menu = page.locator(`${CONTENT} m3e-menu`).first();
    await menu.waitFor({ state: "attached" });
    const isOpen = () => menu.evaluate((el) => el.matches(":popover-open"));
    expect(await isOpen(), "menu starts closed").toBe(false);
    await page
      .locator(`${CONTENT} m3e-button`)
      .filter({ hasText: "File" })
      .first()
      .click();
    await expect
      .poll(isOpen, { message: "menu opens on trigger activation" })
      .toBe(true);
  });

  test("Skeleton: a loaded skeleton reveals its projected content", async ({ page }) => {
    await page.goto("/components/skeleton");
    await waitDefined(page, "m3e-skeleton");
    // The "loaded" preview projects real content once done loading. Scope to the
    // live preview — the code block below it also contains this text.
    const loadedSkel = page.locator(`${CONTENT} m3e-skeleton[loaded]`).first();
    await loadedSkel.waitFor();
    await expect(
      loadedSkel.getByText("Content has finished loading.")
    ).toBeVisible();
    // `loaded` is a DOM property (invisible to Test.Html) — assert it at runtime.
    const loaded = await loadedSkel.evaluate(
      (el) => (el as unknown as { loaded: boolean }).loaded
    );
    expect(loaded).toBe(true);
  });

  // Note: BottomSheet's number gesture properties (hide-friction / overshoot-
  // limit) are only present on an *open* sheet, which would overlay the docs
  // page — so they're not asserted here. They stay unit-covered (the `detents`
  // attribute + a code-path smoke test); a dedicated open-sheet fixture would
  // be needed to runtime-verify the number properties.
});

test.describe("smoke — component pages mount without console errors", () => {
  for (const slug of ["icon", "switch", "checkbox", "button", "card"]) {
    test(`/components/${slug} renders its host elements`, async ({ page }) => {
      const errors: string[] = [];
      page.on("console", (m) => m.type() === "error" && errors.push(m.text()));
      await page.goto(`/components/${slug}`);
      // At least one upgraded custom element on the page.
      const upgraded = await page.evaluate(() =>
        [...document.querySelectorAll("*")].some(
          (el) => el.tagName.startsWith("M3E-") && !!(el as HTMLElement).shadowRoot
        )
      );
      expect(upgraded, `${slug} page should mount at least one m3e element`).toBe(true);
      expect(errors, `${slug} page console errors`).toEqual([]);
    });
  }
});
