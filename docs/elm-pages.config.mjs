import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";
import adapter from "elm-pages/adapter/netlify.js";

export default {
  vite: defineConfig({
    plugins: [
      // Tailwind v4 + the m3e token/utility bridge, run by Vite so the
      // stylesheet is bundled + content-hashed (imported from index.ts).
      tailwindcss(),
    ],
    server: {
      // Needed for cloudflared trycloudflare.com tunnels during local preview.
      allowedHosts: [".trycloudflare.com"],
    },
  }),
  adapter,
  headTagsTemplate(context) {
    // The stylesheet (style.css) and @m3e/web custom-element registration are
    // imported from `index.ts` and bundled through Vite — hashed assets, with
    // the <link>/<script> injected automatically. No hand-linked static files.
    // Material Symbols Outlined is self-hosted via the @font-face in style.css.
    return `
<meta name="generator" content="elm-pages v${context.cliVersion}" />
`;
  },
  preloadTagForFile(file) {
    // add preload directives for JS assets and font assets, etc., skip for CSS files
    // this function will be called with each file that is processed by Vite, including any files in your headTagsTemplate in your config
    return !file.endsWith(".css");
  },
};
