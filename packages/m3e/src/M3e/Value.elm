module M3e.Value exposing
    ( Value, Supported, toString, number, rounded, square
    , standard, vibrant, auto, dark, light, content, expressive
    , fidelity, fruitSalad, monochrome, neutral, rainbow, tonalSpot, high
    , medium, after, before, primary, secondary, both, none
    , selected, above, below, end, horizontal, vertical, elevated
    , filled, outlined, tonal, extraLarge, extraSmall, large, small
    , pulse, wave, circular, value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie
    , value7SidedCookie, value8LeafClover, value9SidedCookie, arch, arrow, boom, bun
    , burst, circle, diamond, fan, flower, gem, ghostIsh
    , heart, hexagon, oval, pentagon, pill, pixelCircle, pixelTriangle
    , puffy, puffyDiamond, semicircle, slanted, softBoom, softBurst, sunny
    , triangle, verySunny, docked, fullscreen, buffer, determinate, indeterminate
    , query, flat, wavy, all, compact, expanded, contained
    , uncontained, segmented, low, sharp, display, headline, label
    , title, tertiary, button, reset, submit, primaryContainer, secondaryContainer
    , surface, tertiaryContainer, over, push, side, modal, month
    , multiYear, year, off, on, aboveAfter, aboveBefore, belowAfter
    , belowBefore, connected, default, narrow, wide, text, date
    , location, page, step, time, true, contains, endsWith
    , startsWith, always, never, loading, noData, hide, reposition
    , aboveBelow
    )

{-|
Token values for the typed enum attributes. A `Value tags` is a phantom-tagged string; each exposed token (e.g. `filled`, `outlined`) is admitted only where its tag is accepted, so a component can only be given values it actually supports. These are passed to the generated attribute setters.

@docs Value, Supported, toString, number, rounded, square
@docs standard, vibrant, auto, dark, light, content
@docs expressive, fidelity, fruitSalad, monochrome, neutral, rainbow
@docs tonalSpot, high, medium, after, before, primary
@docs secondary, both, none, selected, above, below
@docs end, horizontal, vertical, elevated, filled, outlined
@docs tonal, extraLarge, extraSmall, large, small, pulse
@docs wave, circular, value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie
@docs value7SidedCookie, value8LeafClover, value9SidedCookie, arch, arrow, boom
@docs bun, burst, circle, diamond, fan, flower
@docs gem, ghostIsh, heart, hexagon, oval, pentagon
@docs pill, pixelCircle, pixelTriangle, puffy, puffyDiamond, semicircle
@docs slanted, softBoom, softBurst, sunny, triangle, verySunny
@docs docked, fullscreen, buffer, determinate, indeterminate, query
@docs flat, wavy, all, compact, expanded, contained
@docs uncontained, segmented, low, sharp, display, headline
@docs label, title, tertiary, button, reset, submit
@docs primaryContainer, secondaryContainer, surface, tertiaryContainer, over, push
@docs side, modal, month, multiYear, year, off
@docs on, aboveAfter, aboveBefore, belowAfter, belowBefore, connected
@docs default, narrow, wide, text, date, location
@docs page, step, time, true, contains, endsWith
@docs startsWith, always, never, loading, noData, hide
@docs reposition, aboveBelow
-}


import M3e.Value.Core


type alias Value tags =
    M3e.Value.Core.Value tags


type alias Supported =
    M3e.Value.Core.Supported


toString : Value tags -> String
toString =
    M3e.Value.Core.toString


{-| A numeric value, for attributes that accept a number alongside literal tokens (e.g. a page size of `50` or `all`). -}
number : Float -> Value { a | number : Supported }
number n_ =
    M3e.Value.Core.token (String.fromFloat n_)


{-| The `rounded` token. -}
rounded : Value { a | rounded : Supported }
rounded =
    M3e.Value.Core.token "rounded"


{-| The `square` token. -}
square : Value { a | square : Supported }
square =
    M3e.Value.Core.token "square"


{-| The `standard` token. -}
standard : Value { a | standard : Supported }
standard =
    M3e.Value.Core.token "standard"


{-| The `vibrant` token. -}
vibrant : Value { a | vibrant : Supported }
vibrant =
    M3e.Value.Core.token "vibrant"


{-| The `auto` token. -}
auto : Value { a | auto : Supported }
auto =
    M3e.Value.Core.token "auto"


{-| The `dark` token. -}
dark : Value { a | dark : Supported }
dark =
    M3e.Value.Core.token "dark"


{-| The `light` token. -}
light : Value { a | light : Supported }
light =
    M3e.Value.Core.token "light"


{-| The `content` token. -}
content : Value { a | content : Supported }
content =
    M3e.Value.Core.token "content"


{-| The `expressive` token. -}
expressive : Value { a | expressive : Supported }
expressive =
    M3e.Value.Core.token "expressive"


{-| The `fidelity` token. -}
fidelity : Value { a | fidelity : Supported }
fidelity =
    M3e.Value.Core.token "fidelity"


{-| The `fruit-salad` token. -}
fruitSalad : Value { a | fruitSalad : Supported }
fruitSalad =
    M3e.Value.Core.token "fruit-salad"


{-| The `monochrome` token. -}
monochrome : Value { a | monochrome : Supported }
monochrome =
    M3e.Value.Core.token "monochrome"


{-| The `neutral` token. -}
neutral : Value { a | neutral : Supported }
neutral =
    M3e.Value.Core.token "neutral"


{-| The `rainbow` token. -}
rainbow : Value { a | rainbow : Supported }
rainbow =
    M3e.Value.Core.token "rainbow"


{-| The `tonal-spot` token. -}
tonalSpot : Value { a | tonalSpot : Supported }
tonalSpot =
    M3e.Value.Core.token "tonal-spot"


{-| The `high` token. -}
high : Value { a | high : Supported }
high =
    M3e.Value.Core.token "high"


{-| The `medium` token. -}
medium : Value { a | medium : Supported }
medium =
    M3e.Value.Core.token "medium"


{-| The `after` token. -}
after : Value { a | after : Supported }
after =
    M3e.Value.Core.token "after"


{-| The `before` token. -}
before : Value { a | before : Supported }
before =
    M3e.Value.Core.token "before"


{-| The `primary` token. -}
primary : Value { a | primary : Supported }
primary =
    M3e.Value.Core.token "primary"


{-| The `secondary` token. -}
secondary : Value { a | secondary : Supported }
secondary =
    M3e.Value.Core.token "secondary"


{-| The `both` token. -}
both : Value { a | both : Supported }
both =
    M3e.Value.Core.token "both"


{-| The `none` token. -}
none : Value { a | none : Supported }
none =
    M3e.Value.Core.token "none"


{-| The `selected` token. -}
selected : Value { a | selected : Supported }
selected =
    M3e.Value.Core.token "selected"


{-| The `above` token. -}
above : Value { a | above : Supported }
above =
    M3e.Value.Core.token "above"


{-| The `below` token. -}
below : Value { a | below : Supported }
below =
    M3e.Value.Core.token "below"


{-| The `end` token. -}
end : Value { a | end : Supported }
end =
    M3e.Value.Core.token "end"


{-| The `horizontal` token. -}
horizontal : Value { a | horizontal : Supported }
horizontal =
    M3e.Value.Core.token "horizontal"


{-| The `vertical` token. -}
vertical : Value { a | vertical : Supported }
vertical =
    M3e.Value.Core.token "vertical"


{-| The `elevated` token. -}
elevated : Value { a | elevated : Supported }
elevated =
    M3e.Value.Core.token "elevated"


{-| The `filled` token. -}
filled : Value { a | filled : Supported }
filled =
    M3e.Value.Core.token "filled"


{-| The `outlined` token. -}
outlined : Value { a | outlined : Supported }
outlined =
    M3e.Value.Core.token "outlined"


{-| The `tonal` token. -}
tonal : Value { a | tonal : Supported }
tonal =
    M3e.Value.Core.token "tonal"


{-| The `extra-large` token. -}
extraLarge : Value { a | extraLarge : Supported }
extraLarge =
    M3e.Value.Core.token "extra-large"


{-| The `extra-small` token. -}
extraSmall : Value { a | extraSmall : Supported }
extraSmall =
    M3e.Value.Core.token "extra-small"


{-| The `large` token. -}
large : Value { a | large : Supported }
large =
    M3e.Value.Core.token "large"


{-| The `small` token. -}
small : Value { a | small : Supported }
small =
    M3e.Value.Core.token "small"


{-| The `pulse` token. -}
pulse : Value { a | pulse : Supported }
pulse =
    M3e.Value.Core.token "pulse"


{-| The `wave` token. -}
wave : Value { a | wave : Supported }
wave =
    M3e.Value.Core.token "wave"


{-| The `circular` token. -}
circular : Value { a | circular : Supported }
circular =
    M3e.Value.Core.token "circular"


{-| The `12-sided-cookie` token. -}
value12SidedCookie : Value { a | value12SidedCookie : Supported }
value12SidedCookie =
    M3e.Value.Core.token "12-sided-cookie"


{-| The `4-leaf-clover` token. -}
value4LeafClover : Value { a | value4LeafClover : Supported }
value4LeafClover =
    M3e.Value.Core.token "4-leaf-clover"


{-| The `4-sided-cookie` token. -}
value4SidedCookie : Value { a | value4SidedCookie : Supported }
value4SidedCookie =
    M3e.Value.Core.token "4-sided-cookie"


{-| The `6-sided-cookie` token. -}
value6SidedCookie : Value { a | value6SidedCookie : Supported }
value6SidedCookie =
    M3e.Value.Core.token "6-sided-cookie"


{-| The `7-sided-cookie` token. -}
value7SidedCookie : Value { a | value7SidedCookie : Supported }
value7SidedCookie =
    M3e.Value.Core.token "7-sided-cookie"


{-| The `8-leaf-clover` token. -}
value8LeafClover : Value { a | value8LeafClover : Supported }
value8LeafClover =
    M3e.Value.Core.token "8-leaf-clover"


{-| The `9-sided-cookie` token. -}
value9SidedCookie : Value { a | value9SidedCookie : Supported }
value9SidedCookie =
    M3e.Value.Core.token "9-sided-cookie"


{-| The `arch` token. -}
arch : Value { a | arch : Supported }
arch =
    M3e.Value.Core.token "arch"


{-| The `arrow` token. -}
arrow : Value { a | arrow : Supported }
arrow =
    M3e.Value.Core.token "arrow"


{-| The `boom` token. -}
boom : Value { a | boom : Supported }
boom =
    M3e.Value.Core.token "boom"


{-| The `bun` token. -}
bun : Value { a | bun : Supported }
bun =
    M3e.Value.Core.token "bun"


{-| The `burst` token. -}
burst : Value { a | burst : Supported }
burst =
    M3e.Value.Core.token "burst"


{-| The `circle` token. -}
circle : Value { a | circle : Supported }
circle =
    M3e.Value.Core.token "circle"


{-| The `diamond` token. -}
diamond : Value { a | diamond : Supported }
diamond =
    M3e.Value.Core.token "diamond"


{-| The `fan` token. -}
fan : Value { a | fan : Supported }
fan =
    M3e.Value.Core.token "fan"


{-| The `flower` token. -}
flower : Value { a | flower : Supported }
flower =
    M3e.Value.Core.token "flower"


{-| The `gem` token. -}
gem : Value { a | gem : Supported }
gem =
    M3e.Value.Core.token "gem"


{-| The `ghost-ish` token. -}
ghostIsh : Value { a | ghostIsh : Supported }
ghostIsh =
    M3e.Value.Core.token "ghost-ish"


{-| The `heart` token. -}
heart : Value { a | heart : Supported }
heart =
    M3e.Value.Core.token "heart"


{-| The `hexagon` token. -}
hexagon : Value { a | hexagon : Supported }
hexagon =
    M3e.Value.Core.token "hexagon"


{-| The `oval` token. -}
oval : Value { a | oval : Supported }
oval =
    M3e.Value.Core.token "oval"


{-| The `pentagon` token. -}
pentagon : Value { a | pentagon : Supported }
pentagon =
    M3e.Value.Core.token "pentagon"


{-| The `pill` token. -}
pill : Value { a | pill : Supported }
pill =
    M3e.Value.Core.token "pill"


{-| The `pixel-circle` token. -}
pixelCircle : Value { a | pixelCircle : Supported }
pixelCircle =
    M3e.Value.Core.token "pixel-circle"


{-| The `pixel-triangle` token. -}
pixelTriangle : Value { a | pixelTriangle : Supported }
pixelTriangle =
    M3e.Value.Core.token "pixel-triangle"


{-| The `puffy` token. -}
puffy : Value { a | puffy : Supported }
puffy =
    M3e.Value.Core.token "puffy"


{-| The `puffy-diamond` token. -}
puffyDiamond : Value { a | puffyDiamond : Supported }
puffyDiamond =
    M3e.Value.Core.token "puffy-diamond"


{-| The `semicircle` token. -}
semicircle : Value { a | semicircle : Supported }
semicircle =
    M3e.Value.Core.token "semicircle"


{-| The `slanted` token. -}
slanted : Value { a | slanted : Supported }
slanted =
    M3e.Value.Core.token "slanted"


{-| The `soft-boom` token. -}
softBoom : Value { a | softBoom : Supported }
softBoom =
    M3e.Value.Core.token "soft-boom"


{-| The `soft-burst` token. -}
softBurst : Value { a | softBurst : Supported }
softBurst =
    M3e.Value.Core.token "soft-burst"


{-| The `sunny` token. -}
sunny : Value { a | sunny : Supported }
sunny =
    M3e.Value.Core.token "sunny"


{-| The `triangle` token. -}
triangle : Value { a | triangle : Supported }
triangle =
    M3e.Value.Core.token "triangle"


{-| The `very-sunny` token. -}
verySunny : Value { a | verySunny : Supported }
verySunny =
    M3e.Value.Core.token "very-sunny"


{-| The `docked` token. -}
docked : Value { a | docked : Supported }
docked =
    M3e.Value.Core.token "docked"


{-| The `fullscreen` token. -}
fullscreen : Value { a | fullscreen : Supported }
fullscreen =
    M3e.Value.Core.token "fullscreen"


{-| The `buffer` token. -}
buffer : Value { a | buffer : Supported }
buffer =
    M3e.Value.Core.token "buffer"


{-| The `determinate` token. -}
determinate : Value { a | determinate : Supported }
determinate =
    M3e.Value.Core.token "determinate"


{-| The `indeterminate` token. -}
indeterminate : Value { a | indeterminate : Supported }
indeterminate =
    M3e.Value.Core.token "indeterminate"


{-| The `query` token. -}
query : Value { a | query : Supported }
query =
    M3e.Value.Core.token "query"


{-| The `flat` token. -}
flat : Value { a | flat : Supported }
flat =
    M3e.Value.Core.token "flat"


{-| The `wavy` token. -}
wavy : Value { a | wavy : Supported }
wavy =
    M3e.Value.Core.token "wavy"


{-| The `all` token. -}
all : Value { a | all : Supported }
all =
    M3e.Value.Core.token "all"


{-| The `compact` token. -}
compact : Value { a | compact : Supported }
compact =
    M3e.Value.Core.token "compact"


{-| The `expanded` token. -}
expanded : Value { a | expanded : Supported }
expanded =
    M3e.Value.Core.token "expanded"


{-| The `contained` token. -}
contained : Value { a | contained : Supported }
contained =
    M3e.Value.Core.token "contained"


{-| The `uncontained` token. -}
uncontained : Value { a | uncontained : Supported }
uncontained =
    M3e.Value.Core.token "uncontained"


{-| The `segmented` token. -}
segmented : Value { a | segmented : Supported }
segmented =
    M3e.Value.Core.token "segmented"


{-| The `low` token. -}
low : Value { a | low : Supported }
low =
    M3e.Value.Core.token "low"


{-| The `sharp` token. -}
sharp : Value { a | sharp : Supported }
sharp =
    M3e.Value.Core.token "sharp"


{-| The `display` token. -}
display : Value { a | display : Supported }
display =
    M3e.Value.Core.token "display"


{-| The `headline` token. -}
headline : Value { a | headline : Supported }
headline =
    M3e.Value.Core.token "headline"


{-| The `label` token. -}
label : Value { a | label : Supported }
label =
    M3e.Value.Core.token "label"


{-| The `title` token. -}
title : Value { a | title : Supported }
title =
    M3e.Value.Core.token "title"


{-| The `tertiary` token. -}
tertiary : Value { a | tertiary : Supported }
tertiary =
    M3e.Value.Core.token "tertiary"


{-| The `button` token. -}
button : Value { a | button : Supported }
button =
    M3e.Value.Core.token "button"


{-| The `reset` token. -}
reset : Value { a | reset : Supported }
reset =
    M3e.Value.Core.token "reset"


{-| The `submit` token. -}
submit : Value { a | submit : Supported }
submit =
    M3e.Value.Core.token "submit"


{-| The `primary-container` token. -}
primaryContainer : Value { a | primaryContainer : Supported }
primaryContainer =
    M3e.Value.Core.token "primary-container"


{-| The `secondary-container` token. -}
secondaryContainer : Value { a | secondaryContainer : Supported }
secondaryContainer =
    M3e.Value.Core.token "secondary-container"


{-| The `surface` token. -}
surface : Value { a | surface : Supported }
surface =
    M3e.Value.Core.token "surface"


{-| The `tertiary-container` token. -}
tertiaryContainer : Value { a | tertiaryContainer : Supported }
tertiaryContainer =
    M3e.Value.Core.token "tertiary-container"


{-| The `over` token. -}
over : Value { a | over : Supported }
over =
    M3e.Value.Core.token "over"


{-| The `push` token. -}
push : Value { a | push : Supported }
push =
    M3e.Value.Core.token "push"


{-| The `side` token. -}
side : Value { a | side : Supported }
side =
    M3e.Value.Core.token "side"


{-| The `modal` token. -}
modal : Value { a | modal : Supported }
modal =
    M3e.Value.Core.token "modal"


{-| The `month` token. -}
month : Value { a | month : Supported }
month =
    M3e.Value.Core.token "month"


{-| The `multi-year` token. -}
multiYear : Value { a | multiYear : Supported }
multiYear =
    M3e.Value.Core.token "multi-year"


{-| The `year` token. -}
year : Value { a | year : Supported }
year =
    M3e.Value.Core.token "year"


{-| The `off` token. -}
off : Value { a | off : Supported }
off =
    M3e.Value.Core.token "off"


{-| The `on` token. -}
on : Value { a | on : Supported }
on =
    M3e.Value.Core.token "on"


{-| The `above-after` token. -}
aboveAfter : Value { a | aboveAfter : Supported }
aboveAfter =
    M3e.Value.Core.token "above-after"


{-| The `above-before` token. -}
aboveBefore : Value { a | aboveBefore : Supported }
aboveBefore =
    M3e.Value.Core.token "above-before"


{-| The `below-after` token. -}
belowAfter : Value { a | belowAfter : Supported }
belowAfter =
    M3e.Value.Core.token "below-after"


{-| The `below-before` token. -}
belowBefore : Value { a | belowBefore : Supported }
belowBefore =
    M3e.Value.Core.token "below-before"


{-| The `connected` token. -}
connected : Value { a | connected : Supported }
connected =
    M3e.Value.Core.token "connected"


{-| The `default` token. -}
default : Value { a | default : Supported }
default =
    M3e.Value.Core.token "default"


{-| The `narrow` token. -}
narrow : Value { a | narrow : Supported }
narrow =
    M3e.Value.Core.token "narrow"


{-| The `wide` token. -}
wide : Value { a | wide : Supported }
wide =
    M3e.Value.Core.token "wide"


{-| The `text` token. -}
text : Value { a | text : Supported }
text =
    M3e.Value.Core.token "text"


{-| The `date` token. -}
date : Value { a | date : Supported }
date =
    M3e.Value.Core.token "date"


{-| The `location` token. -}
location : Value { a | location : Supported }
location =
    M3e.Value.Core.token "location"


{-| The `page` token. -}
page : Value { a | page : Supported }
page =
    M3e.Value.Core.token "page"


{-| The `step` token. -}
step : Value { a | step : Supported }
step =
    M3e.Value.Core.token "step"


{-| The `time` token. -}
time : Value { a | time : Supported }
time =
    M3e.Value.Core.token "time"


{-| The `true` token. -}
true : Value { a | true : Supported }
true =
    M3e.Value.Core.token "true"


{-| The `contains` token. -}
contains : Value { a | contains : Supported }
contains =
    M3e.Value.Core.token "contains"


{-| The `ends-with` token. -}
endsWith : Value { a | endsWith : Supported }
endsWith =
    M3e.Value.Core.token "ends-with"


{-| The `starts-with` token. -}
startsWith : Value { a | startsWith : Supported }
startsWith =
    M3e.Value.Core.token "starts-with"


{-| The `always` token. -}
always : Value { a | always : Supported }
always =
    M3e.Value.Core.token "always"


{-| The `never` token. -}
never : Value { a | never : Supported }
never =
    M3e.Value.Core.token "never"


{-| The `loading` token. -}
loading : Value { a | loading : Supported }
loading =
    M3e.Value.Core.token "loading"


{-| The `no-data` token. -}
noData : Value { a | noData : Supported }
noData =
    M3e.Value.Core.token "no-data"


{-| The `hide` token. -}
hide : Value { a | hide : Supported }
hide =
    M3e.Value.Core.token "hide"


{-| The `reposition` token. -}
reposition : Value { a | reposition : Supported }
reposition =
    M3e.Value.Core.token "reposition"


{-| The `above-below` token. -}
aboveBelow : Value { a | aboveBelow : Supported }
aboveBelow =
    M3e.Value.Core.token "above-below"