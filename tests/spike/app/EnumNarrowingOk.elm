module EnumNarrowingOk exposing (narrowingExamples)

{-| Regression fixture: strict per-component enum narrowing COMPILES.

Proves the two-tier enum safety model (spec §3.4, §1.5), post `el`-unification:

  - Tier 1 (compile-time): `M3e.Component.*` setters (the ONLY setter surface
    now — the fluent-builder `M3e.Build.*` setters were deleted wholesale,
    but they narrowed the SAME closed Variant row `M3e.Component.*` still
    does) accept ONLY the closed Variant row for THAT component.
  - Tier 2 (elm-review): `M3e.Attributes` setters accept the global open union
    and are backstopped by `Cem.ValidEnumValue`.

Each assertion here MUST compile. The corresponding bad/ fixtures confirm that
the closed-row narrowing actually REJECTS wrong-component tokens.

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Component.Button as Button
import M3e.Component.SplitButton as SplitButton
import M3e.Component.Theme as Theme
import M3e.Values as V


type Msg
    = NoOp


{-|

1.  Theme.variant accepts V.rainbow — rainbow IS in Theme.Variant.

-}
themeVariantRainbow : Attr { c | variant : Supported } Msg
themeVariantRainbow =
    Theme.variant V.rainbow


{-|

1.  SplitButton.variant accepts V.filled — filled IS in SplitButton.Variant.

-}
splitButtonVariantFilled : Attr { c | variant : Supported } Msg
splitButtonVariantFilled =
    SplitButton.variant V.filled


{-|

1.  Button.variant accepts V.filled — the canonical `el`-attrs narrow value
    (locks the form from ApiConsolidation.elm's saveButton).

This WILL FAIL if Button's closed Component.Variant loses `filled`.

-}
buttonVariantFilled : Attr { c | variant : Supported } Msg
buttonVariantFilled =
    Button.variant V.filled


{-|

1.  Loose A.variant accepts V.rainbow — shared open-row, no narrowing.
    The elm-review Cem.ValidEnumValue rule is the backstop here, not the type.

-}
looseVariantRainbow : Attr { c | variant : Supported } Msg
looseVariantRainbow =
    A.variant V.rainbow


{-| Aggregate all examples to prevent DCE removing them from type-checking.
-}
narrowingExamples : ()
narrowingExamples =
    let
        _ =
            themeVariantRainbow

        _ =
            splitButtonVariantFilled

        _ =
            looseVariantRainbow
    in
    ()
