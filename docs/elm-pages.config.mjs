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
      // Allow any Host header — safe on a trusted tailnet (tailscale-serve access).
      allowedHosts: true,
    },
  }),
  adapter,
  headTagsTemplate(context) {
    // The stylesheet (style.css) and @m3e/web custom-element registration are
    // imported from `index.ts` and bundled through Vite — hashed assets, with
    // the <link>/<script> injected automatically. No hand-linked static files.
    // Material Symbols Outlined is self-hosted via the @font-face in style.css.
    //
    // T1 — prod theme flash: synchronous inline script reads localStorage
    // ["m3e-theme-state"] before Elm/index.ts execute and pre-applies the
    // saved scheme/contrast/color to <m3e-theme> + cssOverrides to <html>.
    // Shape mirrors Theme.Ports.encoder/decoder exactly — do NOT diverge.
    // Falls back to data attributes on <html> if <m3e-theme> is absent from
    // the SSR snapshot (should not happen, but resilient either way).
    const themeHeadScript = /* js */ `(function(){try{
  var raw=localStorage.getItem("m3e-theme-state");
  if(!raw)return;
  var s=JSON.parse(raw);
  if(typeof s!=="object"||s===null)return;
  var th=document.querySelector("m3e-theme");
  if(th){
    if(typeof s.scheme==="string")th.setAttribute("scheme",s.scheme);
    if(typeof s.contrast==="string")th.setAttribute("contrast",s.contrast);
    if(typeof s.seed==="string")th.setAttribute("color",s.seed);
  } else {
    var d=document.documentElement.dataset;
    if(typeof s.scheme==="string")d.m3eScheme=s.scheme;
    if(typeof s.contrast==="string")d.m3eContrast=s.contrast;
    if(typeof s.seed==="string")d.m3eColor=s.seed;
  }
  if(s.cssOverrides&&typeof s.cssOverrides==="object"){
    var ov=Array.isArray(s.cssOverrides)?s.cssOverrides:Object.entries(s.cssOverrides);
    for(var i=0;i<ov.length;i++){
      var k=ov[i][0],v=ov[i][1];
      if(typeof k==="string"&&typeof v==="string"&&v!=="")
        document.documentElement.style.setProperty("--"+k,v);
    }
  }
}catch(e){}})();`;
    return `
<meta name="generator" content="elm-pages v${context.cliVersion}" />
<script>${themeHeadScript}</script>
`;
  },
  preloadTagForFile(file) {
    // add preload directives for JS assets and font assets, etc., skip for CSS files
    // this function will be called with each file that is processed by Vite, including any files in your headTagsTemplate in your config
    return !file.endsWith(".css");
  },
};
