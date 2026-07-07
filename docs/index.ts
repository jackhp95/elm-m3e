// @m3e/web custom-element registration + the Tailwind stylesheet are bundled
// through elm-pages' Vite client pipeline (content-hashed; <link>/<script>
// injected automatically) — not hand-linked static assets. These are
// side-effect imports: registering the <m3e-*> elements and pulling in the CSS.
import "@m3e/web/all";
import "../js/avt-snackbar.js";
import "../js/raw-html.js";
import "../js/slide-panels.js";
import "./style.css";

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
