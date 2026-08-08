// @m3e/web custom-element registration + the Tailwind stylesheet are bundled
// through elm-pages' Vite client pipeline (content-hashed; <link>/<script>
// injected automatically) — not hand-linked static assets. These are
// side-effect imports: registering the <m3e-*> elements and pulling in the CSS.
import "@m3e/web/all";
import "./gen/icons.js";
import "../js/avt-snackbar.js";
import "../js/raw-html.js";
import "../js/slide-panels.js";
import "./style.css";

// ─── Cascade-specificity fix ────────────────────────────────────────────────
//
// ROOT CAUSE: vendor static CSS uses `:root { --md-sys-color-* }` (specificity
// 0,1,0). @m3e/web's <m3e-theme> adopted stylesheet uses `html { --md-sys-color-* }`
// (specificity 0,0,1). Pseudo-class `:root` BEATS type-selector `html`, so the
// static vendor palette silently wins every time — color/contrast attribute
// changes on <m3e-theme> recompute the adopted-sheet values correctly but are
// never visible in getComputedStyle.
//
// The CSS-layer fix (wrapping vendor :root in @layer) is the right approach per
// spec, but Tailwind v4 / LightningCSS strips all @layer annotations from
// non-entry imported files AND normalizes :where(:root) back to :root, making
// any pure-CSS fix impossible without forking the build pipeline.
//
// JS FIX: after every <m3e-theme> `change` event (fired post-_apply()), copy
// the computed --md-sys-color-* values from the adopted stylesheet to inline
// styles on <html>. Inline styles have specificity (1,0,0,0) — always beats
// any selector in any author stylesheet.
//
// LISTENER PLACEMENT: registered at module-evaluation time (before Elm renders
// and before the first Lit update cycle), so the first `change` from <m3e-theme>
// is never missed. `capture: true` so it fires before other listeners in case
// any sibling handler calls stopPropagation.
function _applyThemeInlineStyles(): void {
  for (const sheet of document.adoptedStyleSheets) {
    const rule = sheet.cssRules[0] as CSSStyleRule | undefined;
    if (rule?.selectorText === "html") {
      const { style } = rule;
      for (let i = 0; i < style.length; i++) {
        const prop = style.item(i);
        if (prop.startsWith("--md-sys-color-")) {
          document.documentElement.style.setProperty(prop, style.getPropertyValue(prop));
        }
      }
      return;
    }
  }
}
document.addEventListener(
  "change",
  (e) => {
    if ((e.target as Element | null)?.tagName === "M3E-THEME") {
      _applyThemeInlineStyles();
    }
  },
  true,
);
// ─────────────────────────────────────────────────────────────────────────────

type ElmPagesInit = {
  load: (elmLoaded: Promise<unknown>) => Promise<void>;
  flags: unknown;
};

/**
 * Dev-only feedback widget (mirrors kinfolk's embed). The vendored feedback-fab
 * build is hosted-only — the GitHub-link fallback was removed — so a submit
 * needs a reachable backend on this origin, which only exists while running
 * `elm-pages dev` locally. The whole call site is guarded by
 * `import.meta.env.DEV`, so Vite dead-code-eliminates it from the production
 * Netlify build and public visitors never see a dead button.
 *
 * The widget is a self-contained custom element (its own shadow DOM + M3
 * tokens), so it does NOT need to live inside the app's `<m3e-theme>`. It mounts
 * under `<html>`, NOT `<body>`: elm-pages runs a Browser.application whose vdom
 * owns `<body>` and would wipe a body-level sibling on hydration/morph.
 */
function mountFeedbackFab(): void {
  // Idempotent across dev hot-reloads.
  if (document.querySelector("feedback-fab")) return;

  const fab = document.createElement("feedback-fab");
  fab.setAttribute("repo", "jackhp95/elm-m3e");
  fab.setAttribute("labels", "feedback,needs-triage");
  fab.setAttribute("title-prefix", "[feedback] ");
  // Hosted-mode endpoint: prefer VITE_FEEDBACK_ENDPOINT (injected at build/dev
  // time for flightdeck or other custom backends), otherwise fall back to the
  // real browser origin so submit stays same-origin even behind a cloudflared /
  // `tailscale serve` proxy where the server sees a different Host.
  const endpoint = import.meta.env.VITE_FEEDBACK_ENDPOINT ?? location.origin;
  fab.setAttribute("endpoint", endpoint);
  // Optional: point the widget's dashboard at a flightdeck instance.
  const fd = import.meta.env.VITE_FLIGHTDECK_URL;
  if (fd) fab.setAttribute("flightdeck-url", fd);
  document.documentElement.appendChild(fab);

  // The widget bundles its OWN Elm program. Elm's `_Platform_export` refuses to
  // load a second program onto a page that already exposes `window.Elm` (this
  // docs app), throwing elm/core hints/6 BEFORE the widget can register its
  // custom element (verified: the `<feedback-fab>` stayed `:not(:defined)`).
  // Free `window.Elm` for the duration of the widget bundle's own export, then
  // restore this app's object on load so nothing else regresses. Elm's running
  // app reads window.Elm only at export time, so a temporary swap is safe.
  const w = window as unknown as { Elm?: unknown };
  const savedElm = w.Elm;
  w.Elm = undefined;

  const script = document.createElement("script");
  script.src = "/feedback-fab.js";
  script.addEventListener("load", () => {
    w.Elm = savedElm;
  });
  document.head.appendChild(script);
}

const config: ElmPagesInit = {
  load: async function (elmLoaded) {
    const app = (await elmLoaded) as {
      ports?: {
        storeScheme?: { subscribe: (cb: (v: string) => void) => void };
        onOpenSearchRequested?: { send: (v: null) => void };
      };
    };
    // elm-pages hard-codes its route-change announcer as aria-live="assertive"
    // (in its pre-render template + AriaLiveAnnouncer.elm, both under
    // node_modules). Assertive interrupts whatever the user is reading on every
    // navigation; a route change is a status update, not an alert — WAI-ARIA
    // says use "polite". Downgrade it once the app has mounted.
    document
      .getElementById("elm-pages-announcer")
      ?.setAttribute("aria-live", "polite");
    // Persist the chosen color scheme so it survives reloads (read back as a
    // flag in Shared.init).
    app?.ports?.storeScheme?.subscribe((scheme: string) => {
      try {
        window.localStorage.setItem("m3e-scheme", scheme);
      } catch (_) {
        /* localStorage unavailable (private mode / SSR) — ignore */
      }
    });

    // Cmd/Ctrl+K opens search from anywhere. Chrome and Edge bind that
    // shortcut to focusing the address bar, and Browser.Events.onKeyDown
    // cannot call preventDefault (it only decodes event data) -- so this has
    // to be a real DOM listener that calls preventDefault before sending on
    // the port, or our shortcut would fire ALONGSIDE the browser's, not
    // instead of it.
    //
    // `/examples/*` routes render with no docs shell (Shared.view
    // short-circuits to the bare page body), so there is no FAB and no
    // overlay to open there. Shared.subscriptions already refuses to produce
    // OpenSearch on those routes; mirror the same prefix check HERE, before
    // preventDefault, so the browser keeps its own Cmd/Ctrl+K instead of
    // having it swallowed for no visible effect. Keep in sync with
    // `Shared.hasDocsShell`.
    document.addEventListener("keydown", (event) => {
      const isSearchShortcut = (event.metaKey || event.ctrlKey) && event.key.toLowerCase() === "k";
      if (!isSearchShortcut) return;
      if (window.location.pathname.startsWith("/examples/")) return;
      event.preventDefault();
      app?.ports?.onOpenSearchRequested?.send(null);
    });

    if (import.meta.env.DEV) {
      mountFeedbackFab();
    }

    // (The MutationObserver + requestUpdate() shim that lived here was removed.
    //  It was added under commit eb30e90b based on a wrong diagnosis — the
    //  element was always recomputing correctly. The real fix is the inline-style
    //  sync via the `change` event listener registered at module-init above.)

    // Safety-net initial sync: defer past the microtask queue so Lit's first
    // update cycle (which fills the adopted stylesheet) has completed before we
    // read from it. setTimeout(0) runs after ALL pending microtasks drain — the
    // `change` event listener above handles all subsequent updates.
    await new Promise<void>((resolve) => setTimeout(resolve, 0));
    _applyThemeInlineStyles();
  },
  flags: function () {
    // `width` picks the initial drawer mode (side vs over) before
    // Browser.Events.onResize takes over; `scheme` restores the persisted
    // color scheme (Shared.init defaults to "auto" — follow the OS).
    let scheme: string | null = null;
    try {
      scheme = window.localStorage.getItem("m3e-scheme");
    } catch (_) {
      /* ignore */
    }
    return {
      width: typeof window !== "undefined" ? window.innerWidth : 1024,
      scheme,
    };
  },
};

export default config;
