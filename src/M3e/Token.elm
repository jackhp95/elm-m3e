module M3e.Token exposing
    ( Value, Supported, toString, number, rounded, square
    , standard, vibrant, auto, dark, light, content
    , expressive, fidelity, fruitSalad, monochrome, neutral, rainbow
    , tonalSpot, high, medium, true, false, after
    , before, primary, secondary, both, none, selected
    , above, below, end, horizontal, vertical, elevated
    , filled, outlined, tonal, extraLarge, extraSmall, large
    , small, pulse, wave, circular, value12SidedCookie, value4LeafClover
    , value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, arch
    , arrow, boom, bun, burst, circle, diamond
    , fan, flower, gem, ghostIsh, heart, hexagon
    , oval, pentagon, pill, pixelCircle, pixelTriangle, puffy
    , puffyDiamond, semicircle, slanted, softBoom, softBurst, sunny
    , triangle, verySunny, docked, fullscreen, buffer, determinate
    , indeterminate, query, flat, wavy, all, compact
    , expanded, contained, uncontained, segmented, low, sharp
    , display, headline, label, title, tertiary, button
    , reset, submit, primaryContainer, secondaryContainer, surface, tertiaryContainer
    , over, push, side, modal, month, multiYear
    , year, off, on, aboveAfter, aboveBefore, belowAfter
    , belowBefore, connected, default, narrow, wide, text
    , date, location, page, step, time, contains
    , endsWith, startsWith, always, never, loading, noData
    , hide, reposition, aboveBelow
    )

{-| Token values for the typed enum attributes. A `Value tags` is a phantom-tagged string; each exposed token (e.g. `filled`, `outlined`) is admitted only where its tag is accepted, so a component can only be given values it actually supports. These are passed to the generated attribute setters.

@docs Value, Supported, toString, number, rounded, square
@docs standard, vibrant, auto, dark, light, content
@docs expressive, fidelity, fruitSalad, monochrome, neutral, rainbow
@docs tonalSpot, high, medium, true, false, after
@docs before, primary, secondary, both, none, selected
@docs above, below, end, horizontal, vertical, elevated
@docs filled, outlined, tonal, extraLarge, extraSmall, large
@docs small, pulse, wave, circular, value12SidedCookie, value4LeafClover
@docs value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, arch
@docs arrow, boom, bun, burst, circle, diamond
@docs fan, flower, gem, ghostIsh, heart, hexagon
@docs oval, pentagon, pill, pixelCircle, pixelTriangle, puffy
@docs puffyDiamond, semicircle, slanted, softBoom, softBurst, sunny
@docs triangle, verySunny, docked, fullscreen, buffer, determinate
@docs indeterminate, query, flat, wavy, all, compact
@docs expanded, contained, uncontained, segmented, low, sharp
@docs display, headline, label, title, tertiary, button
@docs reset, submit, primaryContainer, secondaryContainer, surface, tertiaryContainer
@docs over, push, side, modal, month, multiYear
@docs year, off, on, aboveAfter, aboveBefore, belowAfter
@docs belowBefore, connected, default, narrow, wide, text
@docs date, location, page, step, time, contains
@docs endsWith, startsWith, always, never, loading, noData
@docs hide, reposition, aboveBelow

-}

import M3e.Token.Core
import M3e.Token.Core.Internal


{-| A phantom-tagged token value, re-exported from `M3e.Token.Core`. Its `tags` row records which enum axes admit it, so a component only accepts values it actually supports.
-}
type alias Value tags =
    M3e.Token.Core.Value tags


{-| The marker recorded in a `Value` tag row for each axis a token is admitted on, re-exported from `M3e.Token.Core`.
-}
type alias Supported =
    M3e.Token.Core.Supported


{-| Render a `Value` back to its underlying string, re-exported from `M3e.Token.Core`. Used by the generated enum attribute setters.
-}
toString : Value tags -> String
toString =
    M3e.Token.Core.toString


{-| A numeric value, for attributes that accept a number alongside literal tokens (e.g. a page size of `50` or `all`).
-}
number : Float -> Value { a | number : Supported }
number n_ =
    M3e.Token.Core.Internal.token (String.fromFloat n_)


{-| The `rounded` token.
-}
rounded : Value { a | rounded : Supported }
rounded =
    M3e.Token.Core.Internal.token "rounded"


{-| The `square` token.
-}
square : Value { a | square : Supported }
square =
    M3e.Token.Core.Internal.token "square"


{-| The `standard` token.
-}
standard : Value { a | standard : Supported }
standard =
    M3e.Token.Core.Internal.token "standard"


{-| The `vibrant` token.
-}
vibrant : Value { a | vibrant : Supported }
vibrant =
    M3e.Token.Core.Internal.token "vibrant"


{-| The `auto` token.
-}
auto : Value { a | auto : Supported }
auto =
    M3e.Token.Core.Internal.token "auto"


{-| The `dark` token.
-}
dark : Value { a | dark : Supported }
dark =
    M3e.Token.Core.Internal.token "dark"


{-| The `light` token.
-}
light : Value { a | light : Supported }
light =
    M3e.Token.Core.Internal.token "light"


{-| The `content` token.
-}
content : Value { a | content : Supported }
content =
    M3e.Token.Core.Internal.token "content"


{-| The `expressive` token.
-}
expressive : Value { a | expressive : Supported }
expressive =
    M3e.Token.Core.Internal.token "expressive"


{-| The `fidelity` token.
-}
fidelity : Value { a | fidelity : Supported }
fidelity =
    M3e.Token.Core.Internal.token "fidelity"


{-| The `fruit-salad` token.
-}
fruitSalad : Value { a | fruitSalad : Supported }
fruitSalad =
    M3e.Token.Core.Internal.token "fruit-salad"


{-| The `monochrome` token.
-}
monochrome : Value { a | monochrome : Supported }
monochrome =
    M3e.Token.Core.Internal.token "monochrome"


{-| The `neutral` token.
-}
neutral : Value { a | neutral : Supported }
neutral =
    M3e.Token.Core.Internal.token "neutral"


{-| The `rainbow` token.
-}
rainbow : Value { a | rainbow : Supported }
rainbow =
    M3e.Token.Core.Internal.token "rainbow"


{-| The `tonal-spot` token.
-}
tonalSpot : Value { a | tonalSpot : Supported }
tonalSpot =
    M3e.Token.Core.Internal.token "tonal-spot"


{-| The `high` token.
-}
high : Value { a | high : Supported }
high =
    M3e.Token.Core.Internal.token "high"


{-| The `medium` token.
-}
medium : Value { a | medium : Supported }
medium =
    M3e.Token.Core.Internal.token "medium"


{-| The `true` token.
-}
true : Value { a | true : Supported }
true =
    M3e.Token.Core.Internal.token "true"


{-| The `false` token.
-}
false : Value { a | false : Supported }
false =
    M3e.Token.Core.Internal.token "false"


{-| The `after` token.
-}
after : Value { a | after : Supported }
after =
    M3e.Token.Core.Internal.token "after"


{-| The `before` token.
-}
before : Value { a | before : Supported }
before =
    M3e.Token.Core.Internal.token "before"


{-| The `primary` token.
-}
primary : Value { a | primary : Supported }
primary =
    M3e.Token.Core.Internal.token "primary"


{-| The `secondary` token.
-}
secondary : Value { a | secondary : Supported }
secondary =
    M3e.Token.Core.Internal.token "secondary"


{-| The `both` token.
-}
both : Value { a | both : Supported }
both =
    M3e.Token.Core.Internal.token "both"


{-| The `none` token.
-}
none : Value { a | none : Supported }
none =
    M3e.Token.Core.Internal.token "none"


{-| The `selected` token.
-}
selected : Value { a | selected : Supported }
selected =
    M3e.Token.Core.Internal.token "selected"


{-| The `above` token.
-}
above : Value { a | above : Supported }
above =
    M3e.Token.Core.Internal.token "above"


{-| The `below` token.
-}
below : Value { a | below : Supported }
below =
    M3e.Token.Core.Internal.token "below"


{-| The `end` token.
-}
end : Value { a | end : Supported }
end =
    M3e.Token.Core.Internal.token "end"


{-| The `horizontal` token.
-}
horizontal : Value { a | horizontal : Supported }
horizontal =
    M3e.Token.Core.Internal.token "horizontal"


{-| The `vertical` token.
-}
vertical : Value { a | vertical : Supported }
vertical =
    M3e.Token.Core.Internal.token "vertical"


{-| The `elevated` token.
-}
elevated : Value { a | elevated : Supported }
elevated =
    M3e.Token.Core.Internal.token "elevated"


{-| The `filled` token.
-}
filled : Value { a | filled : Supported }
filled =
    M3e.Token.Core.Internal.token "filled"


{-| The `outlined` token.
-}
outlined : Value { a | outlined : Supported }
outlined =
    M3e.Token.Core.Internal.token "outlined"


{-| The `tonal` token.
-}
tonal : Value { a | tonal : Supported }
tonal =
    M3e.Token.Core.Internal.token "tonal"


{-| The `extra-large` token.
-}
extraLarge : Value { a | extraLarge : Supported }
extraLarge =
    M3e.Token.Core.Internal.token "extra-large"


{-| The `extra-small` token.
-}
extraSmall : Value { a | extraSmall : Supported }
extraSmall =
    M3e.Token.Core.Internal.token "extra-small"


{-| The `large` token.
-}
large : Value { a | large : Supported }
large =
    M3e.Token.Core.Internal.token "large"


{-| The `small` token.
-}
small : Value { a | small : Supported }
small =
    M3e.Token.Core.Internal.token "small"


{-| The `pulse` token.
-}
pulse : Value { a | pulse : Supported }
pulse =
    M3e.Token.Core.Internal.token "pulse"


{-| The `wave` token.
-}
wave : Value { a | wave : Supported }
wave =
    M3e.Token.Core.Internal.token "wave"


{-| The `circular` token.
-}
circular : Value { a | circular : Supported }
circular =
    M3e.Token.Core.Internal.token "circular"


{-| The `12-sided-cookie` token.
-}
value12SidedCookie : Value { a | value12SidedCookie : Supported }
value12SidedCookie =
    M3e.Token.Core.Internal.token "12-sided-cookie"


{-| The `4-leaf-clover` token.
-}
value4LeafClover : Value { a | value4LeafClover : Supported }
value4LeafClover =
    M3e.Token.Core.Internal.token "4-leaf-clover"


{-| The `4-sided-cookie` token.
-}
value4SidedCookie : Value { a | value4SidedCookie : Supported }
value4SidedCookie =
    M3e.Token.Core.Internal.token "4-sided-cookie"


{-| The `6-sided-cookie` token.
-}
value6SidedCookie : Value { a | value6SidedCookie : Supported }
value6SidedCookie =
    M3e.Token.Core.Internal.token "6-sided-cookie"


{-| The `7-sided-cookie` token.
-}
value7SidedCookie : Value { a | value7SidedCookie : Supported }
value7SidedCookie =
    M3e.Token.Core.Internal.token "7-sided-cookie"


{-| The `8-leaf-clover` token.
-}
value8LeafClover : Value { a | value8LeafClover : Supported }
value8LeafClover =
    M3e.Token.Core.Internal.token "8-leaf-clover"


{-| The `9-sided-cookie` token.
-}
value9SidedCookie : Value { a | value9SidedCookie : Supported }
value9SidedCookie =
    M3e.Token.Core.Internal.token "9-sided-cookie"


{-| The `arch` token.
-}
arch : Value { a | arch : Supported }
arch =
    M3e.Token.Core.Internal.token "arch"


{-| The `arrow` token.
-}
arrow : Value { a | arrow : Supported }
arrow =
    M3e.Token.Core.Internal.token "arrow"


{-| The `boom` token.
-}
boom : Value { a | boom : Supported }
boom =
    M3e.Token.Core.Internal.token "boom"


{-| The `bun` token.
-}
bun : Value { a | bun : Supported }
bun =
    M3e.Token.Core.Internal.token "bun"


{-| The `burst` token.
-}
burst : Value { a | burst : Supported }
burst =
    M3e.Token.Core.Internal.token "burst"


{-| The `circle` token.
-}
circle : Value { a | circle : Supported }
circle =
    M3e.Token.Core.Internal.token "circle"


{-| The `diamond` token.
-}
diamond : Value { a | diamond : Supported }
diamond =
    M3e.Token.Core.Internal.token "diamond"


{-| The `fan` token.
-}
fan : Value { a | fan : Supported }
fan =
    M3e.Token.Core.Internal.token "fan"


{-| The `flower` token.
-}
flower : Value { a | flower : Supported }
flower =
    M3e.Token.Core.Internal.token "flower"


{-| The `gem` token.
-}
gem : Value { a | gem : Supported }
gem =
    M3e.Token.Core.Internal.token "gem"


{-| The `ghost-ish` token.
-}
ghostIsh : Value { a | ghostIsh : Supported }
ghostIsh =
    M3e.Token.Core.Internal.token "ghost-ish"


{-| The `heart` token.
-}
heart : Value { a | heart : Supported }
heart =
    M3e.Token.Core.Internal.token "heart"


{-| The `hexagon` token.
-}
hexagon : Value { a | hexagon : Supported }
hexagon =
    M3e.Token.Core.Internal.token "hexagon"


{-| The `oval` token.
-}
oval : Value { a | oval : Supported }
oval =
    M3e.Token.Core.Internal.token "oval"


{-| The `pentagon` token.
-}
pentagon : Value { a | pentagon : Supported }
pentagon =
    M3e.Token.Core.Internal.token "pentagon"


{-| The `pill` token.
-}
pill : Value { a | pill : Supported }
pill =
    M3e.Token.Core.Internal.token "pill"


{-| The `pixel-circle` token.
-}
pixelCircle : Value { a | pixelCircle : Supported }
pixelCircle =
    M3e.Token.Core.Internal.token "pixel-circle"


{-| The `pixel-triangle` token.
-}
pixelTriangle : Value { a | pixelTriangle : Supported }
pixelTriangle =
    M3e.Token.Core.Internal.token "pixel-triangle"


{-| The `puffy` token.
-}
puffy : Value { a | puffy : Supported }
puffy =
    M3e.Token.Core.Internal.token "puffy"


{-| The `puffy-diamond` token.
-}
puffyDiamond : Value { a | puffyDiamond : Supported }
puffyDiamond =
    M3e.Token.Core.Internal.token "puffy-diamond"


{-| The `semicircle` token.
-}
semicircle : Value { a | semicircle : Supported }
semicircle =
    M3e.Token.Core.Internal.token "semicircle"


{-| The `slanted` token.
-}
slanted : Value { a | slanted : Supported }
slanted =
    M3e.Token.Core.Internal.token "slanted"


{-| The `soft-boom` token.
-}
softBoom : Value { a | softBoom : Supported }
softBoom =
    M3e.Token.Core.Internal.token "soft-boom"


{-| The `soft-burst` token.
-}
softBurst : Value { a | softBurst : Supported }
softBurst =
    M3e.Token.Core.Internal.token "soft-burst"


{-| The `sunny` token.
-}
sunny : Value { a | sunny : Supported }
sunny =
    M3e.Token.Core.Internal.token "sunny"


{-| The `triangle` token.
-}
triangle : Value { a | triangle : Supported }
triangle =
    M3e.Token.Core.Internal.token "triangle"


{-| The `very-sunny` token.
-}
verySunny : Value { a | verySunny : Supported }
verySunny =
    M3e.Token.Core.Internal.token "very-sunny"


{-| The `docked` token.
-}
docked : Value { a | docked : Supported }
docked =
    M3e.Token.Core.Internal.token "docked"


{-| The `fullscreen` token.
-}
fullscreen : Value { a | fullscreen : Supported }
fullscreen =
    M3e.Token.Core.Internal.token "fullscreen"


{-| The `buffer` token.
-}
buffer : Value { a | buffer : Supported }
buffer =
    M3e.Token.Core.Internal.token "buffer"


{-| The `determinate` token.
-}
determinate : Value { a | determinate : Supported }
determinate =
    M3e.Token.Core.Internal.token "determinate"


{-| The `indeterminate` token.
-}
indeterminate : Value { a | indeterminate : Supported }
indeterminate =
    M3e.Token.Core.Internal.token "indeterminate"


{-| The `query` token.
-}
query : Value { a | query : Supported }
query =
    M3e.Token.Core.Internal.token "query"


{-| The `flat` token.
-}
flat : Value { a | flat : Supported }
flat =
    M3e.Token.Core.Internal.token "flat"


{-| The `wavy` token.
-}
wavy : Value { a | wavy : Supported }
wavy =
    M3e.Token.Core.Internal.token "wavy"


{-| The `all` token.
-}
all : Value { a | all : Supported }
all =
    M3e.Token.Core.Internal.token "all"


{-| The `compact` token.
-}
compact : Value { a | compact : Supported }
compact =
    M3e.Token.Core.Internal.token "compact"


{-| The `expanded` token.
-}
expanded : Value { a | expanded : Supported }
expanded =
    M3e.Token.Core.Internal.token "expanded"


{-| The `contained` token.
-}
contained : Value { a | contained : Supported }
contained =
    M3e.Token.Core.Internal.token "contained"


{-| The `uncontained` token.
-}
uncontained : Value { a | uncontained : Supported }
uncontained =
    M3e.Token.Core.Internal.token "uncontained"


{-| The `segmented` token.
-}
segmented : Value { a | segmented : Supported }
segmented =
    M3e.Token.Core.Internal.token "segmented"


{-| The `low` token.
-}
low : Value { a | low : Supported }
low =
    M3e.Token.Core.Internal.token "low"


{-| The `sharp` token.
-}
sharp : Value { a | sharp : Supported }
sharp =
    M3e.Token.Core.Internal.token "sharp"


{-| The `display` token.
-}
display : Value { a | display : Supported }
display =
    M3e.Token.Core.Internal.token "display"


{-| The `headline` token.
-}
headline : Value { a | headline : Supported }
headline =
    M3e.Token.Core.Internal.token "headline"


{-| The `label` token.
-}
label : Value { a | label : Supported }
label =
    M3e.Token.Core.Internal.token "label"


{-| The `title` token.
-}
title : Value { a | title : Supported }
title =
    M3e.Token.Core.Internal.token "title"


{-| The `tertiary` token.
-}
tertiary : Value { a | tertiary : Supported }
tertiary =
    M3e.Token.Core.Internal.token "tertiary"


{-| The `button` token.
-}
button : Value { a | button : Supported }
button =
    M3e.Token.Core.Internal.token "button"


{-| The `reset` token.
-}
reset : Value { a | reset : Supported }
reset =
    M3e.Token.Core.Internal.token "reset"


{-| The `submit` token.
-}
submit : Value { a | submit : Supported }
submit =
    M3e.Token.Core.Internal.token "submit"


{-| The `primary-container` token.
-}
primaryContainer : Value { a | primaryContainer : Supported }
primaryContainer =
    M3e.Token.Core.Internal.token "primary-container"


{-| The `secondary-container` token.
-}
secondaryContainer : Value { a | secondaryContainer : Supported }
secondaryContainer =
    M3e.Token.Core.Internal.token "secondary-container"


{-| The `surface` token.
-}
surface : Value { a | surface : Supported }
surface =
    M3e.Token.Core.Internal.token "surface"


{-| The `tertiary-container` token.
-}
tertiaryContainer : Value { a | tertiaryContainer : Supported }
tertiaryContainer =
    M3e.Token.Core.Internal.token "tertiary-container"


{-| The `over` token.
-}
over : Value { a | over : Supported }
over =
    M3e.Token.Core.Internal.token "over"


{-| The `push` token.
-}
push : Value { a | push : Supported }
push =
    M3e.Token.Core.Internal.token "push"


{-| The `side` token.
-}
side : Value { a | side : Supported }
side =
    M3e.Token.Core.Internal.token "side"


{-| The `modal` token.
-}
modal : Value { a | modal : Supported }
modal =
    M3e.Token.Core.Internal.token "modal"


{-| The `month` token.
-}
month : Value { a | month : Supported }
month =
    M3e.Token.Core.Internal.token "month"


{-| The `multi-year` token.
-}
multiYear : Value { a | multiYear : Supported }
multiYear =
    M3e.Token.Core.Internal.token "multi-year"


{-| The `year` token.
-}
year : Value { a | year : Supported }
year =
    M3e.Token.Core.Internal.token "year"


{-| The `off` token.
-}
off : Value { a | off : Supported }
off =
    M3e.Token.Core.Internal.token "off"


{-| The `on` token.
-}
on : Value { a | on : Supported }
on =
    M3e.Token.Core.Internal.token "on"


{-| The `above-after` token.
-}
aboveAfter : Value { a | aboveAfter : Supported }
aboveAfter =
    M3e.Token.Core.Internal.token "above-after"


{-| The `above-before` token.
-}
aboveBefore : Value { a | aboveBefore : Supported }
aboveBefore =
    M3e.Token.Core.Internal.token "above-before"


{-| The `below-after` token.
-}
belowAfter : Value { a | belowAfter : Supported }
belowAfter =
    M3e.Token.Core.Internal.token "below-after"


{-| The `below-before` token.
-}
belowBefore : Value { a | belowBefore : Supported }
belowBefore =
    M3e.Token.Core.Internal.token "below-before"


{-| The `connected` token.
-}
connected : Value { a | connected : Supported }
connected =
    M3e.Token.Core.Internal.token "connected"


{-| The `default` token.
-}
default : Value { a | default : Supported }
default =
    M3e.Token.Core.Internal.token "default"


{-| The `narrow` token.
-}
narrow : Value { a | narrow : Supported }
narrow =
    M3e.Token.Core.Internal.token "narrow"


{-| The `wide` token.
-}
wide : Value { a | wide : Supported }
wide =
    M3e.Token.Core.Internal.token "wide"


{-| The `text` token.
-}
text : Value { a | text : Supported }
text =
    M3e.Token.Core.Internal.token "text"


{-| The `date` token.
-}
date : Value { a | date : Supported }
date =
    M3e.Token.Core.Internal.token "date"


{-| The `location` token.
-}
location : Value { a | location : Supported }
location =
    M3e.Token.Core.Internal.token "location"


{-| The `page` token.
-}
page : Value { a | page : Supported }
page =
    M3e.Token.Core.Internal.token "page"


{-| The `step` token.
-}
step : Value { a | step : Supported }
step =
    M3e.Token.Core.Internal.token "step"


{-| The `time` token.
-}
time : Value { a | time : Supported }
time =
    M3e.Token.Core.Internal.token "time"


{-| The `contains` token.
-}
contains : Value { a | contains : Supported }
contains =
    M3e.Token.Core.Internal.token "contains"


{-| The `ends-with` token.
-}
endsWith : Value { a | endsWith : Supported }
endsWith =
    M3e.Token.Core.Internal.token "ends-with"


{-| The `starts-with` token.
-}
startsWith : Value { a | startsWith : Supported }
startsWith =
    M3e.Token.Core.Internal.token "starts-with"


{-| The `always` token.
-}
always : Value { a | always : Supported }
always =
    M3e.Token.Core.Internal.token "always"


{-| The `never` token.
-}
never : Value { a | never : Supported }
never =
    M3e.Token.Core.Internal.token "never"


{-| The `loading` token.
-}
loading : Value { a | loading : Supported }
loading =
    M3e.Token.Core.Internal.token "loading"


{-| The `no-data` token.
-}
noData : Value { a | noData : Supported }
noData =
    M3e.Token.Core.Internal.token "no-data"


{-| The `hide` token.
-}
hide : Value { a | hide : Supported }
hide =
    M3e.Token.Core.Internal.token "hide"


{-| The `reposition` token.
-}
reposition : Value { a | reposition : Supported }
reposition =
    M3e.Token.Core.Internal.token "reposition"


{-| The `above-below` token.
-}
aboveBelow : Value { a | aboveBelow : Supported }
aboveBelow =
    M3e.Token.Core.Internal.token "above-below"
