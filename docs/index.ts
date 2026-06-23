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
    const app = await elmLoaded;
    console.log("App loaded", app);
  },
  flags: function () {
    return "You can decode this in Shared.elm using Json.Decode.string!";
  },
};

export default config;
