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

import Markup.Token.Core
import Markup.Token.Core.Internal


{-| A phantom-tagged token value, re-exported from `Markup.Token.Core`. Its `tags` row records which enum axes admit it, so a component only accepts values it actually supports.
-}
type alias Value tags =
    Markup.Token.Core.Value tags


{-| The marker recorded in a `Value` tag row for each axis a token is admitted on, re-exported from `Markup.Token.Core`.
-}
type alias Supported =
    Markup.Token.Core.Supported


{-| Render a `Value` back to its underlying string, re-exported from `Markup.Token.Core`. Used by the generated enum attribute setters.
-}
toString : Value tags -> String
toString =
    Markup.Token.Core.toString


{-| A numeric value, for attributes that accept a number alongside literal tokens (e.g. a page size of `50` or `all`).
-}
number : Float -> Value { a | number : Supported }
number n_ =
    Markup.Token.Core.Internal.token (String.fromFloat n_)


{-| The `rounded` token.
-}
rounded : Value { a | rounded : Supported }
rounded =
    Markup.Token.Core.Internal.token "rounded"


{-| The `square` token.
-}
square : Value { a | square : Supported }
square =
    Markup.Token.Core.Internal.token "square"


{-| The `standard` token.
-}
standard : Value { a | standard : Supported }
standard =
    Markup.Token.Core.Internal.token "standard"


{-| The `vibrant` token.
-}
vibrant : Value { a | vibrant : Supported }
vibrant =
    Markup.Token.Core.Internal.token "vibrant"


{-| The `auto` token.
-}
auto : Value { a | auto : Supported }
auto =
    Markup.Token.Core.Internal.token "auto"


{-| The `dark` token.
-}
dark : Value { a | dark : Supported }
dark =
    Markup.Token.Core.Internal.token "dark"


{-| The `light` token.
-}
light : Value { a | light : Supported }
light =
    Markup.Token.Core.Internal.token "light"


{-| The `content` token.
-}
content : Value { a | content : Supported }
content =
    Markup.Token.Core.Internal.token "content"


{-| The `expressive` token.
-}
expressive : Value { a | expressive : Supported }
expressive =
    Markup.Token.Core.Internal.token "expressive"


{-| The `fidelity` token.
-}
fidelity : Value { a | fidelity : Supported }
fidelity =
    Markup.Token.Core.Internal.token "fidelity"


{-| The `fruit-salad` token.
-}
fruitSalad : Value { a | fruitSalad : Supported }
fruitSalad =
    Markup.Token.Core.Internal.token "fruit-salad"


{-| The `monochrome` token.
-}
monochrome : Value { a | monochrome : Supported }
monochrome =
    Markup.Token.Core.Internal.token "monochrome"


{-| The `neutral` token.
-}
neutral : Value { a | neutral : Supported }
neutral =
    Markup.Token.Core.Internal.token "neutral"


{-| The `rainbow` token.
-}
rainbow : Value { a | rainbow : Supported }
rainbow =
    Markup.Token.Core.Internal.token "rainbow"


{-| The `tonal-spot` token.
-}
tonalSpot : Value { a | tonalSpot : Supported }
tonalSpot =
    Markup.Token.Core.Internal.token "tonal-spot"


{-| The `high` token.
-}
high : Value { a | high : Supported }
high =
    Markup.Token.Core.Internal.token "high"


{-| The `medium` token.
-}
medium : Value { a | medium : Supported }
medium =
    Markup.Token.Core.Internal.token "medium"


{-| The `true` token.
-}
true : Value { a | true : Supported }
true =
    Markup.Token.Core.Internal.token "true"


{-| The `false` token.
-}
false : Value { a | false : Supported }
false =
    Markup.Token.Core.Internal.token "false"


{-| The `after` token.
-}
after : Value { a | after : Supported }
after =
    Markup.Token.Core.Internal.token "after"


{-| The `before` token.
-}
before : Value { a | before : Supported }
before =
    Markup.Token.Core.Internal.token "before"


{-| The `primary` token.
-}
primary : Value { a | primary : Supported }
primary =
    Markup.Token.Core.Internal.token "primary"


{-| The `secondary` token.
-}
secondary : Value { a | secondary : Supported }
secondary =
    Markup.Token.Core.Internal.token "secondary"


{-| The `both` token.
-}
both : Value { a | both : Supported }
both =
    Markup.Token.Core.Internal.token "both"


{-| The `none` token.
-}
none : Value { a | none : Supported }
none =
    Markup.Token.Core.Internal.token "none"


{-| The `selected` token.
-}
selected : Value { a | selected : Supported }
selected =
    Markup.Token.Core.Internal.token "selected"


{-| The `above` token.
-}
above : Value { a | above : Supported }
above =
    Markup.Token.Core.Internal.token "above"


{-| The `below` token.
-}
below : Value { a | below : Supported }
below =
    Markup.Token.Core.Internal.token "below"


{-| The `end` token.
-}
end : Value { a | end : Supported }
end =
    Markup.Token.Core.Internal.token "end"


{-| The `horizontal` token.
-}
horizontal : Value { a | horizontal : Supported }
horizontal =
    Markup.Token.Core.Internal.token "horizontal"


{-| The `vertical` token.
-}
vertical : Value { a | vertical : Supported }
vertical =
    Markup.Token.Core.Internal.token "vertical"


{-| The `elevated` token.
-}
elevated : Value { a | elevated : Supported }
elevated =
    Markup.Token.Core.Internal.token "elevated"


{-| The `filled` token.
-}
filled : Value { a | filled : Supported }
filled =
    Markup.Token.Core.Internal.token "filled"


{-| The `outlined` token.
-}
outlined : Value { a | outlined : Supported }
outlined =
    Markup.Token.Core.Internal.token "outlined"


{-| The `tonal` token.
-}
tonal : Value { a | tonal : Supported }
tonal =
    Markup.Token.Core.Internal.token "tonal"


{-| The `extra-large` token.
-}
extraLarge : Value { a | extraLarge : Supported }
extraLarge =
    Markup.Token.Core.Internal.token "extra-large"


{-| The `extra-small` token.
-}
extraSmall : Value { a | extraSmall : Supported }
extraSmall =
    Markup.Token.Core.Internal.token "extra-small"


{-| The `large` token.
-}
large : Value { a | large : Supported }
large =
    Markup.Token.Core.Internal.token "large"


{-| The `small` token.
-}
small : Value { a | small : Supported }
small =
    Markup.Token.Core.Internal.token "small"


{-| The `pulse` token.
-}
pulse : Value { a | pulse : Supported }
pulse =
    Markup.Token.Core.Internal.token "pulse"


{-| The `wave` token.
-}
wave : Value { a | wave : Supported }
wave =
    Markup.Token.Core.Internal.token "wave"


{-| The `circular` token.
-}
circular : Value { a | circular : Supported }
circular =
    Markup.Token.Core.Internal.token "circular"


{-| The `12-sided-cookie` token.
-}
value12SidedCookie : Value { a | value12SidedCookie : Supported }
value12SidedCookie =
    Markup.Token.Core.Internal.token "12-sided-cookie"


{-| The `4-leaf-clover` token.
-}
value4LeafClover : Value { a | value4LeafClover : Supported }
value4LeafClover =
    Markup.Token.Core.Internal.token "4-leaf-clover"


{-| The `4-sided-cookie` token.
-}
value4SidedCookie : Value { a | value4SidedCookie : Supported }
value4SidedCookie =
    Markup.Token.Core.Internal.token "4-sided-cookie"


{-| The `6-sided-cookie` token.
-}
value6SidedCookie : Value { a | value6SidedCookie : Supported }
value6SidedCookie =
    Markup.Token.Core.Internal.token "6-sided-cookie"


{-| The `7-sided-cookie` token.
-}
value7SidedCookie : Value { a | value7SidedCookie : Supported }
value7SidedCookie =
    Markup.Token.Core.Internal.token "7-sided-cookie"


{-| The `8-leaf-clover` token.
-}
value8LeafClover : Value { a | value8LeafClover : Supported }
value8LeafClover =
    Markup.Token.Core.Internal.token "8-leaf-clover"


{-| The `9-sided-cookie` token.
-}
value9SidedCookie : Value { a | value9SidedCookie : Supported }
value9SidedCookie =
    Markup.Token.Core.Internal.token "9-sided-cookie"


{-| The `arch` token.
-}
arch : Value { a | arch : Supported }
arch =
    Markup.Token.Core.Internal.token "arch"


{-| The `arrow` token.
-}
arrow : Value { a | arrow : Supported }
arrow =
    Markup.Token.Core.Internal.token "arrow"


{-| The `boom` token.
-}
boom : Value { a | boom : Supported }
boom =
    Markup.Token.Core.Internal.token "boom"


{-| The `bun` token.
-}
bun : Value { a | bun : Supported }
bun =
    Markup.Token.Core.Internal.token "bun"


{-| The `burst` token.
-}
burst : Value { a | burst : Supported }
burst =
    Markup.Token.Core.Internal.token "burst"


{-| The `circle` token.
-}
circle : Value { a | circle : Supported }
circle =
    Markup.Token.Core.Internal.token "circle"


{-| The `diamond` token.
-}
diamond : Value { a | diamond : Supported }
diamond =
    Markup.Token.Core.Internal.token "diamond"


{-| The `fan` token.
-}
fan : Value { a | fan : Supported }
fan =
    Markup.Token.Core.Internal.token "fan"


{-| The `flower` token.
-}
flower : Value { a | flower : Supported }
flower =
    Markup.Token.Core.Internal.token "flower"


{-| The `gem` token.
-}
gem : Value { a | gem : Supported }
gem =
    Markup.Token.Core.Internal.token "gem"


{-| The `ghost-ish` token.
-}
ghostIsh : Value { a | ghostIsh : Supported }
ghostIsh =
    Markup.Token.Core.Internal.token "ghost-ish"


{-| The `heart` token.
-}
heart : Value { a | heart : Supported }
heart =
    Markup.Token.Core.Internal.token "heart"


{-| The `hexagon` token.
-}
hexagon : Value { a | hexagon : Supported }
hexagon =
    Markup.Token.Core.Internal.token "hexagon"


{-| The `oval` token.
-}
oval : Value { a | oval : Supported }
oval =
    Markup.Token.Core.Internal.token "oval"


{-| The `pentagon` token.
-}
pentagon : Value { a | pentagon : Supported }
pentagon =
    Markup.Token.Core.Internal.token "pentagon"


{-| The `pill` token.
-}
pill : Value { a | pill : Supported }
pill =
    Markup.Token.Core.Internal.token "pill"


{-| The `pixel-circle` token.
-}
pixelCircle : Value { a | pixelCircle : Supported }
pixelCircle =
    Markup.Token.Core.Internal.token "pixel-circle"


{-| The `pixel-triangle` token.
-}
pixelTriangle : Value { a | pixelTriangle : Supported }
pixelTriangle =
    Markup.Token.Core.Internal.token "pixel-triangle"


{-| The `puffy` token.
-}
puffy : Value { a | puffy : Supported }
puffy =
    Markup.Token.Core.Internal.token "puffy"


{-| The `puffy-diamond` token.
-}
puffyDiamond : Value { a | puffyDiamond : Supported }
puffyDiamond =
    Markup.Token.Core.Internal.token "puffy-diamond"


{-| The `semicircle` token.
-}
semicircle : Value { a | semicircle : Supported }
semicircle =
    Markup.Token.Core.Internal.token "semicircle"


{-| The `slanted` token.
-}
slanted : Value { a | slanted : Supported }
slanted =
    Markup.Token.Core.Internal.token "slanted"


{-| The `soft-boom` token.
-}
softBoom : Value { a | softBoom : Supported }
softBoom =
    Markup.Token.Core.Internal.token "soft-boom"


{-| The `soft-burst` token.
-}
softBurst : Value { a | softBurst : Supported }
softBurst =
    Markup.Token.Core.Internal.token "soft-burst"


{-| The `sunny` token.
-}
sunny : Value { a | sunny : Supported }
sunny =
    Markup.Token.Core.Internal.token "sunny"


{-| The `triangle` token.
-}
triangle : Value { a | triangle : Supported }
triangle =
    Markup.Token.Core.Internal.token "triangle"


{-| The `very-sunny` token.
-}
verySunny : Value { a | verySunny : Supported }
verySunny =
    Markup.Token.Core.Internal.token "very-sunny"


{-| The `docked` token.
-}
docked : Value { a | docked : Supported }
docked =
    Markup.Token.Core.Internal.token "docked"


{-| The `fullscreen` token.
-}
fullscreen : Value { a | fullscreen : Supported }
fullscreen =
    Markup.Token.Core.Internal.token "fullscreen"


{-| The `buffer` token.
-}
buffer : Value { a | buffer : Supported }
buffer =
    Markup.Token.Core.Internal.token "buffer"


{-| The `determinate` token.
-}
determinate : Value { a | determinate : Supported }
determinate =
    Markup.Token.Core.Internal.token "determinate"


{-| The `indeterminate` token.
-}
indeterminate : Value { a | indeterminate : Supported }
indeterminate =
    Markup.Token.Core.Internal.token "indeterminate"


{-| The `query` token.
-}
query : Value { a | query : Supported }
query =
    Markup.Token.Core.Internal.token "query"


{-| The `flat` token.
-}
flat : Value { a | flat : Supported }
flat =
    Markup.Token.Core.Internal.token "flat"


{-| The `wavy` token.
-}
wavy : Value { a | wavy : Supported }
wavy =
    Markup.Token.Core.Internal.token "wavy"


{-| The `all` token.
-}
all : Value { a | all : Supported }
all =
    Markup.Token.Core.Internal.token "all"


{-| The `compact` token.
-}
compact : Value { a | compact : Supported }
compact =
    Markup.Token.Core.Internal.token "compact"


{-| The `expanded` token.
-}
expanded : Value { a | expanded : Supported }
expanded =
    Markup.Token.Core.Internal.token "expanded"


{-| The `contained` token.
-}
contained : Value { a | contained : Supported }
contained =
    Markup.Token.Core.Internal.token "contained"


{-| The `uncontained` token.
-}
uncontained : Value { a | uncontained : Supported }
uncontained =
    Markup.Token.Core.Internal.token "uncontained"


{-| The `segmented` token.
-}
segmented : Value { a | segmented : Supported }
segmented =
    Markup.Token.Core.Internal.token "segmented"


{-| The `low` token.
-}
low : Value { a | low : Supported }
low =
    Markup.Token.Core.Internal.token "low"


{-| The `sharp` token.
-}
sharp : Value { a | sharp : Supported }
sharp =
    Markup.Token.Core.Internal.token "sharp"


{-| The `display` token.
-}
display : Value { a | display : Supported }
display =
    Markup.Token.Core.Internal.token "display"


{-| The `headline` token.
-}
headline : Value { a | headline : Supported }
headline =
    Markup.Token.Core.Internal.token "headline"


{-| The `label` token.
-}
label : Value { a | label : Supported }
label =
    Markup.Token.Core.Internal.token "label"


{-| The `title` token.
-}
title : Value { a | title : Supported }
title =
    Markup.Token.Core.Internal.token "title"


{-| The `tertiary` token.
-}
tertiary : Value { a | tertiary : Supported }
tertiary =
    Markup.Token.Core.Internal.token "tertiary"


{-| The `button` token.
-}
button : Value { a | button : Supported }
button =
    Markup.Token.Core.Internal.token "button"


{-| The `reset` token.
-}
reset : Value { a | reset : Supported }
reset =
    Markup.Token.Core.Internal.token "reset"


{-| The `submit` token.
-}
submit : Value { a | submit : Supported }
submit =
    Markup.Token.Core.Internal.token "submit"


{-| The `primary-container` token.
-}
primaryContainer : Value { a | primaryContainer : Supported }
primaryContainer =
    Markup.Token.Core.Internal.token "primary-container"


{-| The `secondary-container` token.
-}
secondaryContainer : Value { a | secondaryContainer : Supported }
secondaryContainer =
    Markup.Token.Core.Internal.token "secondary-container"


{-| The `surface` token.
-}
surface : Value { a | surface : Supported }
surface =
    Markup.Token.Core.Internal.token "surface"


{-| The `tertiary-container` token.
-}
tertiaryContainer : Value { a | tertiaryContainer : Supported }
tertiaryContainer =
    Markup.Token.Core.Internal.token "tertiary-container"


{-| The `over` token.
-}
over : Value { a | over : Supported }
over =
    Markup.Token.Core.Internal.token "over"


{-| The `push` token.
-}
push : Value { a | push : Supported }
push =
    Markup.Token.Core.Internal.token "push"


{-| The `side` token.
-}
side : Value { a | side : Supported }
side =
    Markup.Token.Core.Internal.token "side"


{-| The `modal` token.
-}
modal : Value { a | modal : Supported }
modal =
    Markup.Token.Core.Internal.token "modal"


{-| The `month` token.
-}
month : Value { a | month : Supported }
month =
    Markup.Token.Core.Internal.token "month"


{-| The `multi-year` token.
-}
multiYear : Value { a | multiYear : Supported }
multiYear =
    Markup.Token.Core.Internal.token "multi-year"


{-| The `year` token.
-}
year : Value { a | year : Supported }
year =
    Markup.Token.Core.Internal.token "year"


{-| The `off` token.
-}
off : Value { a | off : Supported }
off =
    Markup.Token.Core.Internal.token "off"


{-| The `on` token.
-}
on : Value { a | on : Supported }
on =
    Markup.Token.Core.Internal.token "on"


{-| The `above-after` token.
-}
aboveAfter : Value { a | aboveAfter : Supported }
aboveAfter =
    Markup.Token.Core.Internal.token "above-after"


{-| The `above-before` token.
-}
aboveBefore : Value { a | aboveBefore : Supported }
aboveBefore =
    Markup.Token.Core.Internal.token "above-before"


{-| The `below-after` token.
-}
belowAfter : Value { a | belowAfter : Supported }
belowAfter =
    Markup.Token.Core.Internal.token "below-after"


{-| The `below-before` token.
-}
belowBefore : Value { a | belowBefore : Supported }
belowBefore =
    Markup.Token.Core.Internal.token "below-before"


{-| The `connected` token.
-}
connected : Value { a | connected : Supported }
connected =
    Markup.Token.Core.Internal.token "connected"


{-| The `default` token.
-}
default : Value { a | default : Supported }
default =
    Markup.Token.Core.Internal.token "default"


{-| The `narrow` token.
-}
narrow : Value { a | narrow : Supported }
narrow =
    Markup.Token.Core.Internal.token "narrow"


{-| The `wide` token.
-}
wide : Value { a | wide : Supported }
wide =
    Markup.Token.Core.Internal.token "wide"


{-| The `text` token.
-}
text : Value { a | text : Supported }
text =
    Markup.Token.Core.Internal.token "text"


{-| The `date` token.
-}
date : Value { a | date : Supported }
date =
    Markup.Token.Core.Internal.token "date"


{-| The `location` token.
-}
location : Value { a | location : Supported }
location =
    Markup.Token.Core.Internal.token "location"


{-| The `page` token.
-}
page : Value { a | page : Supported }
page =
    Markup.Token.Core.Internal.token "page"


{-| The `step` token.
-}
step : Value { a | step : Supported }
step =
    Markup.Token.Core.Internal.token "step"


{-| The `time` token.
-}
time : Value { a | time : Supported }
time =
    Markup.Token.Core.Internal.token "time"


{-| The `contains` token.
-}
contains : Value { a | contains : Supported }
contains =
    Markup.Token.Core.Internal.token "contains"


{-| The `ends-with` token.
-}
endsWith : Value { a | endsWith : Supported }
endsWith =
    Markup.Token.Core.Internal.token "ends-with"


{-| The `starts-with` token.
-}
startsWith : Value { a | startsWith : Supported }
startsWith =
    Markup.Token.Core.Internal.token "starts-with"


{-| The `always` token.
-}
always : Value { a | always : Supported }
always =
    Markup.Token.Core.Internal.token "always"


{-| The `never` token.
-}
never : Value { a | never : Supported }
never =
    Markup.Token.Core.Internal.token "never"


{-| The `loading` token.
-}
loading : Value { a | loading : Supported }
loading =
    Markup.Token.Core.Internal.token "loading"


{-| The `no-data` token.
-}
noData : Value { a | noData : Supported }
noData =
    Markup.Token.Core.Internal.token "no-data"


{-| The `hide` token.
-}
hide : Value { a | hide : Supported }
hide =
    Markup.Token.Core.Internal.token "hide"


{-| The `reposition` token.
-}
reposition : Value { a | reposition : Supported }
reposition =
    Markup.Token.Core.Internal.token "reposition"


{-| The `above-below` token.
-}
aboveBelow : Value { a | aboveBelow : Supported }
aboveBelow =
    Markup.Token.Core.Internal.token "above-below"
