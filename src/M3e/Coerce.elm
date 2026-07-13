module M3e.Coerce exposing (asButton)

{-| **Blessed brand crossings** for the M3e library (WS6 / CX5).

Each function here is a **loud crossing**: a greppable, named re-brand
declared in `config/slots.json` under `_coerce`. These are the ONLY
config-blessed ways to move an element between kind rows.

The general escape hatch is `recast` (in the `Seam` module): it crosses
ANY brands but makes no semantic claim. Prefer the named coercions here
when the crossing has a stable identity.

@docs asButton

-}

import M3e.Kind
import Markup.Element.Internal as Element exposing (Element)


{-| Blessed brand crossing: re-brand a `Chip` element as a `button`-kinded element.

This is a **loud crossing** — never automatic. Use it when you want to
explicitly admit a `Chip` element into a `button`-typed slot.
For a general (unrestricted) brand escape, use `recast` instead.

-}
asButton : Element { k | chip : M3e.Kind.Brand } msg -> Element { s | button : M3e.Kind.Brand } msg
asButton =
    Element.toNode >> Element.fromNode
