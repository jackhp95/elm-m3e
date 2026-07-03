# elm-m3e docs site

This directory hosts the elm-pages documentation app — Material 3 component
reference, studies, and design-token guides.

## Quickstart

```sh
pnpm install
pnpm run build:assets   # generate reference + examples data JSON
pnpm start              # build:assets + elm-pages dev, serves on http://localhost:1234
```

`elm-pages dev` proxies through Vite, which watches your `.elm` source.

## Styling — no manual CSS rebuild

CSS is bundled by **Vite via the Tailwind v4 plugin** (`@tailwindcss/vite` in
`elm-pages.config.mjs`); `./style.css` is imported as a side effect from
`index.ts` (which also registers the `@m3e/web` custom elements). There is no
`build:css` script and no separately-emitted `public/style.css` or `m3e.js`
artifact — Vite content-hashes the bundle at build time and picks up new class
strings on its own during `elm-pages dev`. Just edit `.elm`/`style.css` and the
dev server rebuilds.

## Scripts

| script            | does                                                     |
| ----------------- | -------------------------------------------------------- |
| `build:reference` | Extracts API reference JSON from `elm make --docs`.      |
| `build:examples`  | Builds the examples data JSON from the example sources.  |
| `build:assets`    | Runs `build:reference` then `build:examples`.            |
| `start`           | `build:assets` + `elm-pages dev`.                        |
| `build`           | `build:assets` + `elm-pages build` (production output).  |
| `test:browser`    | Playwright runtime contract harness.                     |
