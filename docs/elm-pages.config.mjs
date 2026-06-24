import { defineConfig } from "vite";
import adapter from "elm-pages/adapter/netlify.js";

export default {
  vite: defineConfig({}),
  adapter,
  headTagsTemplate(context) {
    // style.css (Tailwind + m3e bridge) and m3e.js (@m3e/web custom-element
    // registration) are pre-built into public/ by the npm build script.
    // Material Symbols Outlined is now self-hosted (public/material-symbols-outlined.woff2,
    // @font-face in style.css) so the Google Fonts <link> is gone.
    return `
<meta name="generator" content="elm-pages v${context.cliVersion}" />
<link rel="stylesheet" href="/style.css" />
<script type="module" src="/m3e.js"></script>
`;
  },
  preloadTagForFile(file) {
    // add preload directives for JS assets and font assets, etc., skip for CSS files
    // this function will be called with each file that is processed by Vite, including any files in your headTagsTemplate in your config
    return !file.endsWith(".css");
  },
};
