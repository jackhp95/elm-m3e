module IconUse exposing (menuIcon, customIcon)

{-| Compile-only spike for M3e.Icon element helpers (WS-C).

Verifies:
  - A named icon helper (menu) compiles with empty attrs + kids.
  - The custom escape hatch compiles with an arbitrary string.

-}

import HtmlIr.Element exposing (Element)
import M3e.Component.Icon exposing (Is)
import M3e.Icon


{-| Named icon helper — must compile. -}
menuIcon : Element (Is s) admittedBy msg
menuIcon =
    M3e.Icon.menu [] []


{-| Custom escape hatch — must compile. -}
customIcon : Element (Is s) admittedBy msg
customIcon =
    M3e.Icon.custom "foo" [] []
