module M3e.Value exposing
    ( Value, toString
    , AxisSupports, emptyAxis, toAxis, axisString, axisStringOr
    , extraSmall, small, medium, large, extraLarge
    , elevated, filled, tonal, outlined, textVariant, standard, connected
    , primary, primaryContainer, secondary, secondaryContainer, tertiary, tertiaryContainer, surface
    , display, headline, title, label
    , vibrant, content, expressive, fidelity, fruitSalad, monochrome, neutral, rainbow, tonalSpot
    , flat, wavy, uncontained, contained, segmented
    , rounded, sharp, auto, docked, modal
    , square, circular
    )

{-| Shared, phantom-tagged enum values for the M3e component library.

A `Value` is an opaque token carrying the string a component emits (e.g.
`"small"`), tagged at the type level with an **open row** advertising which
member it is. Each component publishes a **closed** supported-row for its
`variant` / `size` / `shape` field; row unification then accepts the members a
component supports and rejects everything else at compile time.

    import M3e.Value as Value
    import M3e.Button as Button
    import M3e.Fab as Fab


    -- The SAME value is valid for Button AND Fab (both support `large`):
    Button.view { label = "Save", variant = Button.Filled }
        [ Button.size Value.large ]

    Fab.view { icon = "add", ariaLabel = "Add" }
        [ Fab.size Value.large ]

The single `Value` type spans the variant / size / shape axes deliberately: a
member is admitted purely by which component **field** it is passed to (each
field carries its own closed row), so the same token name never needs an
axis-specific spelling and cross-axis names (e.g. `rounded`) cannot collide.


## Type

@docs Value, toString


## Axis fields

A component stores an enum-valued attribute (e.g. `size`) as an `AxisSupports`
field rather than a bare [`Value`](#Value): the field's phantom row records the
set the component accepts, and its runtime payload is the chosen value's string
(or none). The universal axis builders in [`M3e.Attr`](M3e-Attr) (`Attr.size`,
`Attr.sizeMedium`, …) set this field; the helpers below read it back out inside
a component's `view`.

@docs AxisSupports, emptyAxis, toAxis, axisString, axisStringOr


## Sizes

@docs extraSmall, small, medium, large, extraLarge


## Variants

@docs elevated, filled, tonal, outlined, textVariant, standard, connected
@docs primary, primaryContainer, secondary, secondaryContainer, tertiary, tertiaryContainer, surface
@docs display, headline, title, label
@docs vibrant, content, expressive, fidelity, fruitSalad, monochrome, neutral, rainbow, tonalSpot
@docs flat, wavy, uncontained, contained, segmented
@docs rounded, sharp, auto, docked, modal


## Shapes

`rounded` and `auto` (above) are shared with the variant axis; the
shape-only tokens are:

@docs square, circular

-}

import M3e.Element exposing (Supported)


{-| An opaque, phantom-tagged enum value. The `tags` row records which members
this value satisfies; it has no runtime representation beyond the carried
string.
-}
type Value tags
    = Value String


{-| The string a component emits for this value (e.g. `Value.toString small`
is `"small"`). Used internally by component `view` functions.
-}
toString : Value tags -> String
toString (Value s) =
    s


{-| A component's enum-valued attribute field. The `values` row is the **closed**
set the component supports (so a value outside it is a compile error); the
runtime payload is the chosen value's string, or `Nothing` when unset.

A component declares the field as `AxisSupports { small : Supported, … }` and
defaults it to [`emptyAxis`](#emptyAxis); the universal [`M3e.Attr`](M3e-Attr)
axis builders fill it.

-}
type AxisSupports values
    = AxisSupports (Maybe String)


{-| The unset axis field — emits no attribute. The component's default `view`
value applies (see [`axisStringOr`](#axisStringOr)).
-}
emptyAxis : AxisSupports values
emptyAxis =
    AxisSupports Nothing


{-| Lift a chosen [`Value`](#Value) into an [`AxisSupports`](#AxisSupports)
field. Used by the universal axis builders in [`M3e.Attr`](M3e-Attr); the row is
carried through so the field keeps the value's membership proof.
-}
toAxis : Value values -> AxisSupports values
toAxis (Value s) =
    AxisSupports (Just s)


{-| The chosen value's string, or `Nothing` when unset. Use in a `view` for an
attribute the component omits when unset.
-}
axisString : AxisSupports values -> Maybe String
axisString (AxisSupports m) =
    m


{-| The chosen value's string, falling back to the given default when unset. The
fallback is a [`Value`](#Value) typed against the same row, so a component can
only default to a value it actually supports. Use in a `view` for an attribute
the component always emits.
-}
axisStringOr : Value values -> AxisSupports values -> String
axisStringOr (Value fallback) (AxisSupports m) =
    Maybe.withDefault fallback m


{-| The smallest size step. Emits `"extra-small"`.
-}
extraSmall : Value { a | extraSmall : Supported }
extraSmall =
    Value "extra-small"


{-| A small size. Emits `"small"`.
-}
small : Value { a | small : Supported }
small =
    Value "small"


{-| A medium size. Emits `"medium"`.
-}
medium : Value { a | medium : Supported }
medium =
    Value "medium"


{-| A large size. Emits `"large"`.
-}
large : Value { a | large : Supported }
large =
    Value "large"


{-| The largest size step. Emits `"extra-large"`.
-}
extraLarge : Value { a | extraLarge : Supported }
extraLarge =
    Value "extra-large"



-- VARIANTS ---------------------------------------------------------------


{-| Emits `"elevated"`.
-}
elevated : Value { a | elevated : Supported }
elevated =
    Value "elevated"


{-| Emits `"filled"`.
-}
filled : Value { a | filled : Supported }
filled =
    Value "filled"


{-| Emits `"tonal"`.
-}
tonal : Value { a | tonal : Supported }
tonal =
    Value "tonal"


{-| Emits `"outlined"`.
-}
outlined : Value { a | outlined : Supported }
outlined =
    Value "outlined"


{-| Emits `"text"`.
-}
textVariant : Value { a | text : Supported }
textVariant =
    Value "text"


{-| Emits `"standard"`.
-}
standard : Value { a | standard : Supported }
standard =
    Value "standard"


{-| Emits `"connected"`.
-}
connected : Value { a | connected : Supported }
connected =
    Value "connected"


{-| Emits `"primary"`.
-}
primary : Value { a | primary : Supported }
primary =
    Value "primary"


{-| Emits `"primary-container"`.
-}
primaryContainer : Value { a | primaryContainer : Supported }
primaryContainer =
    Value "primary-container"


{-| Emits `"secondary"`.
-}
secondary : Value { a | secondary : Supported }
secondary =
    Value "secondary"


{-| Emits `"secondary-container"`.
-}
secondaryContainer : Value { a | secondaryContainer : Supported }
secondaryContainer =
    Value "secondary-container"


{-| Emits `"tertiary"`.
-}
tertiary : Value { a | tertiary : Supported }
tertiary =
    Value "tertiary"


{-| Emits `"tertiary-container"`.
-}
tertiaryContainer : Value { a | tertiaryContainer : Supported }
tertiaryContainer =
    Value "tertiary-container"


{-| Emits `"surface"`.
-}
surface : Value { a | surface : Supported }
surface =
    Value "surface"


{-| Emits `"display"`.
-}
display : Value { a | display : Supported }
display =
    Value "display"


{-| Emits `"headline"`.
-}
headline : Value { a | headline : Supported }
headline =
    Value "headline"


{-| Emits `"title"`.
-}
title : Value { a | title : Supported }
title =
    Value "title"


{-| Emits `"label"`.
-}
label : Value { a | label : Supported }
label =
    Value "label"


{-| Emits `"vibrant"`.
-}
vibrant : Value { a | vibrant : Supported }
vibrant =
    Value "vibrant"


{-| Emits `"content"`.
-}
content : Value { a | content : Supported }
content =
    Value "content"


{-| Emits `"expressive"`.
-}
expressive : Value { a | expressive : Supported }
expressive =
    Value "expressive"


{-| Emits `"fidelity"`.
-}
fidelity : Value { a | fidelity : Supported }
fidelity =
    Value "fidelity"


{-| Emits `"fruit-salad"`.
-}
fruitSalad : Value { a | fruitSalad : Supported }
fruitSalad =
    Value "fruit-salad"


{-| Emits `"monochrome"`.
-}
monochrome : Value { a | monochrome : Supported }
monochrome =
    Value "monochrome"


{-| Emits `"neutral"`.
-}
neutral : Value { a | neutral : Supported }
neutral =
    Value "neutral"


{-| Emits `"rainbow"`.
-}
rainbow : Value { a | rainbow : Supported }
rainbow =
    Value "rainbow"


{-| Emits `"tonal-spot"`.
-}
tonalSpot : Value { a | tonalSpot : Supported }
tonalSpot =
    Value "tonal-spot"


{-| Emits `"flat"`.
-}
flat : Value { a | flat : Supported }
flat =
    Value "flat"


{-| Emits `"wavy"`.
-}
wavy : Value { a | wavy : Supported }
wavy =
    Value "wavy"


{-| Emits `"uncontained"`.
-}
uncontained : Value { a | uncontained : Supported }
uncontained =
    Value "uncontained"


{-| Emits `"contained"`.
-}
contained : Value { a | contained : Supported }
contained =
    Value "contained"


{-| Emits `"segmented"`.
-}
segmented : Value { a | segmented : Supported }
segmented =
    Value "segmented"


{-| Emits `"rounded"`.
-}
rounded : Value { a | rounded : Supported }
rounded =
    Value "rounded"


{-| Emits `"sharp"`.
-}
sharp : Value { a | sharp : Supported }
sharp =
    Value "sharp"


{-| Emits `"auto"`.
-}
auto : Value { a | auto : Supported }
auto =
    Value "auto"


{-| Emits `"docked"`.
-}
docked : Value { a | docked : Supported }
docked =
    Value "docked"


{-| Emits `"modal"`.
-}
modal : Value { a | modal : Supported }
modal =
    Value "modal"


{-| Emits `"square"`.
-}
square : Value { a | square : Supported }
square =
    Value "square"


{-| Emits `"circular"`.
-}
circular : Value { a | circular : Supported }
circular =
    Value "circular"
