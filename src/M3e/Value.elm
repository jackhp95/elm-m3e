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
    , before, after, above, below
    , aboveAfter, aboveBefore, belowAfter, belowBefore, aboveBelow
    , horizontal, vertical
    , none
    , month, multiYear, year
    , submit, reset, button
    , compact, expanded, over, push, side
    , hide, reposition
    , loading, noData
    , pulse, wave
    , both, selected
    , default, narrow, wide
    , low, high, dark, light
    , contains, startsWith, endsWith
    , indeterminate
    , value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie
    , arch, arrow, boom, bun, burst, circle, diamond, fan, flower, gem, ghostIsh, heart, hexagon, oval, pentagon, pill
    , pixelCircle, pixelTriangle, puffy, puffyDiamond, semicircle, slanted, softBoom, softBurst, sunny, triangle, verySunny
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


## Header / overlay positions

@docs before, after, above, below
@docs aboveAfter, aboveBefore, belowAfter, belowBefore, aboveBelow


## Orientations

@docs horizontal, vertical


## Miscellaneous axis values

@docs none
@docs month, multiYear, year
@docs submit, reset, button
@docs compact, expanded, over, push, side
@docs hide, reposition
@docs loading, noData
@docs pulse, wave
@docs both, selected
@docs default, narrow, wide
@docs low, high, dark, light
@docs contains, startsWith, endsWith
@docs indeterminate


## Shape names

@docs value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie
@docs arch, arrow, boom, bun, burst, circle, diamond, fan, flower, gem, ghostIsh, heart, hexagon, oval, pentagon, pill
@docs pixelCircle, pixelTriangle, puffy, puffyDiamond, semicircle, slanted, softBoom, softBurst, sunny, triangle, verySunny

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


{-| Emits `"before"`.
-}
before : Value { a | before : Supported }
before =
    Value "before"


{-| Emits `"after"`.
-}
after : Value { a | after : Supported }
after =
    Value "after"


{-| Emits `"above"`.
-}
above : Value { a | above : Supported }
above =
    Value "above"


{-| Emits `"below"`.
-}
below : Value { a | below : Supported }
below =
    Value "below"


{-| Emits `"horizontal"`.
-}
horizontal : Value { a | horizontal : Supported }
horizontal =
    Value "horizontal"


{-| Emits `"vertical"`.
-}
vertical : Value { a | vertical : Supported }
vertical =
    Value "vertical"


{-| Emits `"above-after"`.
-}
aboveAfter : Value { a | aboveAfter : Supported }
aboveAfter =
    Value "above-after"


{-| Emits `"above-before"`.
-}
aboveBefore : Value { a | aboveBefore : Supported }
aboveBefore =
    Value "above-before"


{-| Emits `"below-after"`.
-}
belowAfter : Value { a | belowAfter : Supported }
belowAfter =
    Value "below-after"


{-| Emits `"below-before"`.
-}
belowBefore : Value { a | belowBefore : Supported }
belowBefore =
    Value "below-before"


{-| Emits `"above-below"`.
-}
aboveBelow : Value { a | aboveBelow : Supported }
aboveBelow =
    Value "above-below"


{-| Emits `"none"`.
-}
none : Value { a | none : Supported }
none =
    Value "none"


{-| Emits `"month"`.
-}
month : Value { a | month : Supported }
month =
    Value "month"


{-| Emits `"multi-year"`.
-}
multiYear : Value { a | multiYear : Supported }
multiYear =
    Value "multi-year"


{-| Emits `"year"`.
-}
year : Value { a | year : Supported }
year =
    Value "year"


{-| Emits `"submit"`.
-}
submit : Value { a | submit : Supported }
submit =
    Value "submit"


{-| Emits `"reset"`.
-}
reset : Value { a | reset : Supported }
reset =
    Value "reset"


{-| Emits `"button"`.
-}
button : Value { a | button : Supported }
button =
    Value "button"


{-| Emits `"compact"`.
-}
compact : Value { a | compact : Supported }
compact =
    Value "compact"


{-| Emits `"expanded"`.
-}
expanded : Value { a | expanded : Supported }
expanded =
    Value "expanded"


{-| Emits `"over"`.
-}
over : Value { a | over : Supported }
over =
    Value "over"


{-| Emits `"push"`.
-}
push : Value { a | push : Supported }
push =
    Value "push"


{-| Emits `"side"`.
-}
side : Value { a | side : Supported }
side =
    Value "side"


{-| Emits `"hide"`.
-}
hide : Value { a | hide : Supported }
hide =
    Value "hide"


{-| Emits `"reposition"`.
-}
reposition : Value { a | reposition : Supported }
reposition =
    Value "reposition"


{-| Emits `"loading"`.
-}
loading : Value { a | loading : Supported }
loading =
    Value "loading"


{-| Emits `"no-data"`.
-}
noData : Value { a | noData : Supported }
noData =
    Value "no-data"


{-| Emits `"pulse"`.
-}
pulse : Value { a | pulse : Supported }
pulse =
    Value "pulse"


{-| Emits `"wave"`.
-}
wave : Value { a | wave : Supported }
wave =
    Value "wave"


{-| Emits `"both"`.
-}
both : Value { a | both : Supported }
both =
    Value "both"


{-| Emits `"selected"`.
-}
selected : Value { a | selected : Supported }
selected =
    Value "selected"


{-| Emits `"default"`.
-}
default : Value { a | default : Supported }
default =
    Value "default"


{-| Emits `"narrow"`.
-}
narrow : Value { a | narrow : Supported }
narrow =
    Value "narrow"


{-| Emits `"wide"`.
-}
wide : Value { a | wide : Supported }
wide =
    Value "wide"


{-| Emits `"low"`.
-}
low : Value { a | low : Supported }
low =
    Value "low"


{-| Emits `"high"`.
-}
high : Value { a | high : Supported }
high =
    Value "high"


{-| Emits `"dark"`.
-}
dark : Value { a | dark : Supported }
dark =
    Value "dark"


{-| Emits `"light"`.
-}
light : Value { a | light : Supported }
light =
    Value "light"


{-| Emits `"contains"`.
-}
contains : Value { a | contains : Supported }
contains =
    Value "contains"


{-| Emits `"starts-with"`.
-}
startsWith : Value { a | startsWith : Supported }
startsWith =
    Value "starts-with"


{-| Emits `"ends-with"`.
-}
endsWith : Value { a | endsWith : Supported }
endsWith =
    Value "ends-with"


{-| Emits `"indeterminate"`.
-}
indeterminate : Value { a | indeterminate : Supported }
indeterminate =
    Value "indeterminate"



-- SHAPE NAMES ------------------------------------------------------------


{-| Emits `"12-sided-cookie"`.
-}
value12SidedCookie : Value { a | value12SidedCookie : Supported }
value12SidedCookie =
    Value "12-sided-cookie"


{-| Emits `"4-leaf-clover"`.
-}
value4LeafClover : Value { a | value4LeafClover : Supported }
value4LeafClover =
    Value "4-leaf-clover"


{-| Emits `"4-sided-cookie"`.
-}
value4SidedCookie : Value { a | value4SidedCookie : Supported }
value4SidedCookie =
    Value "4-sided-cookie"


{-| Emits `"6-sided-cookie"`.
-}
value6SidedCookie : Value { a | value6SidedCookie : Supported }
value6SidedCookie =
    Value "6-sided-cookie"


{-| Emits `"7-sided-cookie"`.
-}
value7SidedCookie : Value { a | value7SidedCookie : Supported }
value7SidedCookie =
    Value "7-sided-cookie"


{-| Emits `"8-leaf-clover"`.
-}
value8LeafClover : Value { a | value8LeafClover : Supported }
value8LeafClover =
    Value "8-leaf-clover"


{-| Emits `"9-sided-cookie"`.
-}
value9SidedCookie : Value { a | value9SidedCookie : Supported }
value9SidedCookie =
    Value "9-sided-cookie"


{-| Emits `"arch"`.
-}
arch : Value { a | arch : Supported }
arch =
    Value "arch"


{-| Emits `"arrow"`.
-}
arrow : Value { a | arrow : Supported }
arrow =
    Value "arrow"


{-| Emits `"boom"`.
-}
boom : Value { a | boom : Supported }
boom =
    Value "boom"


{-| Emits `"bun"`.
-}
bun : Value { a | bun : Supported }
bun =
    Value "bun"


{-| Emits `"burst"`.
-}
burst : Value { a | burst : Supported }
burst =
    Value "burst"


{-| Emits `"circle"`.
-}
circle : Value { a | circle : Supported }
circle =
    Value "circle"


{-| Emits `"diamond"`.
-}
diamond : Value { a | diamond : Supported }
diamond =
    Value "diamond"


{-| Emits `"fan"`.
-}
fan : Value { a | fan : Supported }
fan =
    Value "fan"


{-| Emits `"flower"`.
-}
flower : Value { a | flower : Supported }
flower =
    Value "flower"


{-| Emits `"gem"`.
-}
gem : Value { a | gem : Supported }
gem =
    Value "gem"


{-| Emits `"ghost-ish"`.
-}
ghostIsh : Value { a | ghostIsh : Supported }
ghostIsh =
    Value "ghost-ish"


{-| Emits `"heart"`.
-}
heart : Value { a | heart : Supported }
heart =
    Value "heart"


{-| Emits `"hexagon"`.
-}
hexagon : Value { a | hexagon : Supported }
hexagon =
    Value "hexagon"


{-| Emits `"oval"`.
-}
oval : Value { a | oval : Supported }
oval =
    Value "oval"


{-| Emits `"pentagon"`.
-}
pentagon : Value { a | pentagon : Supported }
pentagon =
    Value "pentagon"


{-| Emits `"pill"`.
-}
pill : Value { a | pill : Supported }
pill =
    Value "pill"


{-| Emits `"pixel-circle"`.
-}
pixelCircle : Value { a | pixelCircle : Supported }
pixelCircle =
    Value "pixel-circle"


{-| Emits `"pixel-triangle"`.
-}
pixelTriangle : Value { a | pixelTriangle : Supported }
pixelTriangle =
    Value "pixel-triangle"


{-| Emits `"puffy"`.
-}
puffy : Value { a | puffy : Supported }
puffy =
    Value "puffy"


{-| Emits `"puffy-diamond"`.
-}
puffyDiamond : Value { a | puffyDiamond : Supported }
puffyDiamond =
    Value "puffy-diamond"


{-| Emits `"semicircle"`.
-}
semicircle : Value { a | semicircle : Supported }
semicircle =
    Value "semicircle"


{-| Emits `"slanted"`.
-}
slanted : Value { a | slanted : Supported }
slanted =
    Value "slanted"


{-| Emits `"soft-boom"`.
-}
softBoom : Value { a | softBoom : Supported }
softBoom =
    Value "soft-boom"


{-| Emits `"soft-burst"`.
-}
softBurst : Value { a | softBurst : Supported }
softBurst =
    Value "soft-burst"


{-| Emits `"sunny"`.
-}
sunny : Value { a | sunny : Supported }
sunny =
    Value "sunny"


{-| Emits `"triangle"`.
-}
triangle : Value { a | triangle : Supported }
triangle =
    Value "triangle"


{-| Emits `"very-sunny"`.
-}
verySunny : Value { a | verySunny : Supported }
verySunny =
    Value "very-sunny"
