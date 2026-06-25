# elm-m3e docs site

This directory hosts the elm-pages documentation app — Material 3 component
reference, studies, and design-token guides.

## Quickstart

```sh
pnpm install
pnpm run build:assets   # one-shot CSS + custom-element bundle + reference JSON
npx elm-pages dev       # serves on http://localhost:1234
```

`elm-pages dev` proxies through Vite which watches your `.elm` source.

## Tailwind caveat — rerun `build:css` after any class change

`pnpm run build:assets` invokes Tailwind v4 (`tailwindcss -i ./style.css -o
./public/style.css --minify`) **once**. There is no `--watch` flag wired into
the dev script.

That means: any time you add a class string in an `.elm` file (for example a
new `sm:px-6` or `lg:hidden`), Tailwind has not seen it yet, and the
already-shipped `public/style.css` will not contain a rule for it. The page
will render with the *old* stylesheet until you re-run:

```sh
pnpm run build:css      # or `pnpm run build:assets` to also rebuild m3e + reference
```

The fastest dev loop is two terminals: one running `elm-pages dev`, the
other running `pnpm run build:css` whenever you change classes (or wire
`tailwindcss --watch` locally if you're iterating heavily).

## Scripts

| script           | does                                                          |
| ---------------- | ------------------------------------------------------------- |
| `build:css`      | Tailwind v4 compile — re-run after editing classes in `.elm`. |
| `build:m3e`      | esbuild bundle of the @m3e/web custom elements.               |
| `build:reference`| Extracts API reference JSON from `elm make --docs`.           |
| `build:assets`   | Runs the three above, in order.                               |
| `start`          | `build:assets` + `elm-pages dev`.                             |
| `build`          | `build:assets` + `elm-pages build` (production output).       |
