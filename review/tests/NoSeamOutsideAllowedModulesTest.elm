module NoSeamOutsideAllowedModulesTest exposing (all)

import NoSeamOutsideAllowedModules exposing (rule)
import Review.Test
import Test exposing (Test, describe, test)


all : Test
all =
    describe "NoSeamOutsideAllowedModules"
        [ test "flags Seam.asAttribute in a non-allowed module" <|
            \() ->
                """module Route.Home exposing (v)

import Html.Attributes as Attr
import Seam

v =
    Seam.asAttribute (Attr.class "flex")
"""
                    |> Review.Test.run (rule [ "Native", "Layout" ])
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`Seam.asAttribute` used outside an allowed module"
                            , details =
                                [ "`Seam.asAttribute` is a seam that discards a type guarantee — it should be contained to the adapter modules in this rule's allow-list, not used in feature code."
                                , "Move this into an allowed module (a Native/Layout-style layer), or reach for a typed M3e API that doesn't need the escape hatch."
                                ]
                            , under = "Seam.asAttribute"
                            }
                        ]
        , test "flags a point-free Seam.stripPhantom use" <|
            \() ->
                """module Route.Home exposing (v)

import Seam

v =
    List.map Seam.stripPhantom xs
"""
                    |> Review.Test.run (rule [ "Native" ])
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`Seam.stripPhantom` used outside an allowed module"
                            , details =
                                [ "`Seam.stripPhantom` is a seam that discards a type guarantee — it should be contained to the adapter modules in this rule's allow-list, not used in feature code."
                                , "Move this into an allowed module (a Native/Layout-style layer), or reach for a typed M3e API that doesn't need the escape hatch."
                                ]
                            , under = "Seam.stripPhantom"
                            }
                        ]
        , test "allows the seam inside an allowed module" <|
            \() ->
                """module Native exposing (div)

import Html.Attributes as Attr
import Seam

div cls =
    Seam.asAttribute (Attr.class cls)
"""
                    |> Review.Test.run (rule [ "Native", "Layout" ])
                    |> Review.Test.expectNoErrors
        , test "allows the seam in a submodule of an allow-list prefix" <|
            \() ->
                """module Kit.Surface exposing (view)

import Html.Attributes as Attr
import Seam

view cls =
    Seam.asAttribute (Attr.class cls)
"""
                    |> Review.Test.run (rule [ "Native", "Kit" ])
                    |> Review.Test.expectNoErrors
        , test "empty allow-list gates the seam everywhere (even a would-be-allowed module)" <|
            \() ->
                -- With `rule []` no module is allowed, so `gated` is True even for
                -- `Native` (allowed under a non-empty list in the tests above).
                """module Native exposing (v)

import Html.Attributes as Attr
import Seam

v =
    Seam.asAttribute (Attr.class "flex")
"""
                    |> Review.Test.run (rule [])
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`Seam.asAttribute` used outside an allowed module"
                            , details =
                                [ "`Seam.asAttribute` is a seam that discards a type guarantee — it should be contained to the adapter modules in this rule's allow-list, not used in feature code."
                                , "Move this into an allowed module (a Native/Layout-style layer), or reach for a typed M3e API that doesn't need the escape hatch."
                                ]
                            , under = "Seam.asAttribute"
                            }
                        ]
        , test "does not flag a Seam.*-named value that resolves to an unrelated module" <|
            \() ->
                -- `Seam` here is an alias for `Widget.Internal`, so the lookup table
                -- resolves `Seam.asElement` to the Widget.Internal module — not the real
                -- `Seam` module — and the rule leaves it alone even though the module is
                -- gated (`Route.Home` is not in the allow-list).
                """module Route.Home exposing (v)

import Widget.Internal as Seam

v =
    Seam.asElement thing
"""
                    |> Review.Test.run (rule [ "Native" ])
                    |> Review.Test.expectNoErrors
        ]
