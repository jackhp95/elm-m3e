# jackhp95/elm-m3e-families

Family-grouped nested module organization for elm-m3e components.

This package is a standalone sub-package of [elm-m3e](https://github.com/jackhp95/elm-m3e).
It is a **purely additive** re-organization: every module here re-exports an
existing flat `M3e.Component.*` element under a nested **family** path
(`M3e.Family.NavMenu.Item` re-exports `M3e.Component.NavMenuItem`), so nothing
built against the flat surface regresses. Depends on `jackhp95/elm-m3e-components`
— it adds no logic of its own.

**Generated file.** Do not edit `src/` by hand — run `npm run gen:src` in the
elm-m3e repo to regenerate from the `_families` config (`config/slots.json`).

## Usage

```elm
import M3e.Family.NavMenu as NavMenu
import M3e.Family.NavMenu.Item as NavMenuItem

NavMenu.el [] [ NavMenu.child (NavMenuItem.el { label = ... } [] []) ]
```

## License

BSD-3-Clause — see [LICENSE](LICENSE).
