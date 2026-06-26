// NOTE: @m3e/web registration and the Tailwind stylesheet are shipped as
// pre-built static assets (public/m3e.js, public/style.css) linked from
// elm-pages.config.mjs headTagsTemplate — not bundled here, since this hook
// is loaded as a runtime module by the elm-pages client.

type ElmPagesInit = {
  load: (elmLoaded: Promise<unknown>) => Promise<void>;
  flags: unknown;
};

const config: ElmPagesInit = {
  load: async function (elmLoaded) {
    const app = (await elmLoaded) as { ports?: Record<string, { subscribe: (cb: (v: string) => void) => void }> };
    // Persist the chosen color scheme so it survives reloads (read back as a
    // flag in Shared.init).
    app?.ports?.storeScheme?.subscribe((scheme: string) => {
      try {
        window.localStorage.setItem("m3e-scheme", scheme);
      } catch (_) {
        /* localStorage unavailable (private mode / SSR) — ignore */
      }
    });
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
