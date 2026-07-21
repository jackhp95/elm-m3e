module M3e.Values exposing
    ( Animation, Contrast, Current, Dividers, EndMode, Filter, FloatLabel, Grade, HeaderPosition, HideSubscript, HighlightMode, Icons, LabelPosition, Mode, Motion, Name, Orientation, PageSizeVariant, Position, PositionX, PositionY, Scheme, ScrollStrategy, Shape, Size, StartMode, StartView, State, ToggleDirection, TogglePosition, TouchGestures, Type, Variant, Width
    , value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, above, aboveAfter, aboveBefore, aboveBelow, after, always, arch, arrow, auto, before, below, belowAfter, belowBefore, boom, both, buffer, bun, burst, button, circle, circular, compact, connected, contained, contains, content, dark, date, default, determinate, diamond, display, docked, elevated, end, endsWith, expanded, expressive, extraLarge, extraSmall, fan, fidelity, filled, flat, flower, fruitSalad, fullscreen, gem, ghostIsh, headline, heart, hexagon, hide, high, horizontal, indeterminate, label, large, light, loading, location, low, medium, modal, monochrome, month, multiYear, narrow, neutral, never, noData, none, off, on, outlined, oval, over, page, pentagon, pill, pixelCircle, pixelTriangle, primary, primaryContainer, puffy, puffyDiamond, pulse, push, query, rainbow, reposition, reset, rounded, secondary, secondaryContainer, segmented, selected, semicircle, sharp, side, slanted, small, softBoom, softBurst, square, standard, startsWith, step, submit, sunny, surface, tertiary, tertiaryContainer, text, time, title, tonal, tonalSpot, triangle, true, uncontained, vertical, verySunny, vibrant, wave, wavy, wide, year
    )

{-| The enum-value vocabulary: every token minted once (open row), plus the
library-wide union row per enum attribute. General setters close over the
union; per-component setters narrow — both are fed by these same tokens.

@docs Animation, Contrast, Current, Dividers, EndMode, Filter, FloatLabel, Grade, HeaderPosition, HideSubscript, HighlightMode, Icons, LabelPosition, Mode, Motion, Name, Orientation, PageSizeVariant, Position, PositionX, PositionY, Scheme, ScrollStrategy, Shape, Size, StartMode, StartView, State, ToggleDirection, TogglePosition, TouchGestures, Type, Variant, Width
@docs value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, above, aboveAfter, aboveBefore, aboveBelow, after, always, arch, arrow, auto, before, below, belowAfter, belowBefore, boom, both, buffer, bun, burst, button, circle, circular, compact, connected, contained, contains, content, dark, date, default, determinate, diamond, display, docked, elevated, end, endsWith, expanded, expressive, extraLarge, extraSmall, fan, fidelity, filled, flat, flower, fruitSalad, fullscreen, gem, ghostIsh, headline, heart, hexagon, hide, high, horizontal, indeterminate, label, large, light, loading, location, low, medium, modal, monochrome, month, multiYear, narrow, neutral, never, noData, none, off, on, outlined, oval, over, page, pentagon, pill, pixelCircle, pixelTriangle, primary, primaryContainer, puffy, puffyDiamond, pulse, push, query, rainbow, reposition, reset, rounded, secondary, secondaryContainer, segmented, selected, semicircle, sharp, side, slanted, small, softBoom, softBurst, square, standard, startsWith, step, submit, sunny, surface, tertiary, tertiaryContainer, text, time, title, tonal, tonalSpot, triangle, true, uncontained, vertical, verySunny, vibrant, wave, wavy, wide, year

-}

import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value exposing (Value)


{-| The union row for `animation` (from `SkeletonAnimation`).
-}
type alias Animation =
    { none : Supported
    , pulse : Supported
    , wave : Supported
    }


{-| The union row for `contrast` (from `ContrastLevel`).
-}
type alias Contrast =
    { high : Supported
    , medium : Supported
    , standard : Supported
    }


{-| The union row for `current` (from `BreadcrumbItemCurrent`).
-}
type alias Current =
    { date : Supported
    , location : Supported
    , page : Supported
    , step : Supported
    , time : Supported
    , true : Supported
    }


{-| The union row for `dividers` (from `ScrollDividers`).
-}
type alias Dividers =
    { above : Supported
    , aboveBelow : Supported
    , below : Supported
    , none : Supported
    }


{-| The union row for `endMode` (from `DrawerMode`).
-}
type alias EndMode =
    { auto : Supported
    , over : Supported
    , push : Supported
    , side : Supported
    }


{-| The union row for `filter` (from `AutocompleteFilterMode`).
-}
type alias Filter =
    { contains : Supported
    , endsWith : Supported
    , none : Supported
    , startsWith : Supported
    }


{-| The union row for `floatLabel` (from `FloatLabelType`).
-}
type alias FloatLabel =
    { always : Supported
    , auto : Supported
    }


{-| The union row for `grade` (from `IconGrade`).
-}
type alias Grade =
    { high : Supported
    , low : Supported
    , medium : Supported
    }


{-| The union row for `headerPosition` (from `StepHeaderPosition`).
-}
type alias HeaderPosition =
    { above : Supported
    , after : Supported
    , before : Supported
    , below : Supported
    }


{-| The union row for `hideSubscript` (from `HideSubscriptType`).
-}
type alias HideSubscript =
    { always : Supported
    , auto : Supported
    , never : Supported
    }


{-| The union row for `highlightMode` (from `TextHighlightMode`).
-}
type alias HighlightMode =
    { contains : Supported
    , endsWith : Supported
    , startsWith : Supported
    }


{-| The union row for `icons` (from `SwitchIcons`).
-}
type alias Icons =
    { both : Supported
    , none : Supported
    , selected : Supported
    }


{-| The union row for `labelPosition` (from `StepLabelPosition`).
-}
type alias LabelPosition =
    { below : Supported
    , end : Supported
    }


{-| The union row for `mode` (from `LinearProgressMode`).
-}
type alias Mode =
    { auto : Supported
    , buffer : Supported
    , compact : Supported
    , contains : Supported
    , determinate : Supported
    , docked : Supported
    , endsWith : Supported
    , expanded : Supported
    , fullscreen : Supported
    , indeterminate : Supported
    , query : Supported
    , startsWith : Supported
    }


{-| The union row for `motion` (from `MotionScheme`).
-}
type alias Motion =
    { expressive : Supported
    , standard : Supported
    }


{-| The union row for `name` (from `ShapeName`).
-}
type alias Name =
    { value12SidedCookie : Supported
    , value4LeafClover : Supported
    , value4SidedCookie : Supported
    , value6SidedCookie : Supported
    , value7SidedCookie : Supported
    , value8LeafClover : Supported
    , value9SidedCookie : Supported
    , arch : Supported
    , arrow : Supported
    , boom : Supported
    , bun : Supported
    , burst : Supported
    , circle : Supported
    , diamond : Supported
    , fan : Supported
    , flower : Supported
    , gem : Supported
    , ghostIsh : Supported
    , heart : Supported
    , hexagon : Supported
    , oval : Supported
    , pentagon : Supported
    , pill : Supported
    , pixelCircle : Supported
    , pixelTriangle : Supported
    , puffy : Supported
    , puffyDiamond : Supported
    , semicircle : Supported
    , slanted : Supported
    , softBoom : Supported
    , softBurst : Supported
    , square : Supported
    , sunny : Supported
    , triangle : Supported
    , verySunny : Supported
    }


{-| The union row for `orientation` (from `CardOrientation`).
-}
type alias Orientation =
    { auto : Supported
    , horizontal : Supported
    , vertical : Supported
    }


{-| The union row for `pageSizeVariant` (from `FormFieldVariant`).
-}
type alias PageSizeVariant =
    { filled : Supported
    , outlined : Supported
    }


{-| The union row for `position` (from `BadgePosition`).
-}
type alias Position =
    { above : Supported
    , aboveAfter : Supported
    , aboveBefore : Supported
    , after : Supported
    , before : Supported
    , below : Supported
    , belowAfter : Supported
    , belowBefore : Supported
    }


{-| The union row for `positionX` (from `MenuPositionX`).
-}
type alias PositionX =
    { after : Supported
    , before : Supported
    }


{-| The union row for `positionY` (from `MenuPositionY`).
-}
type alias PositionY =
    { above : Supported
    , below : Supported
    }


{-| The union row for `scheme` (from `ColorScheme`).
-}
type alias Scheme =
    { auto : Supported
    , dark : Supported
    , light : Supported
    }


{-| The union row for `scrollStrategy` (from `FloatingPanelScrollStrategy`).
-}
type alias ScrollStrategy =
    { hide : Supported
    , reposition : Supported
    }


{-| The union row for `shape` (from `ButtonShape`).
-}
type alias Shape =
    { auto : Supported
    , circular : Supported
    , rounded : Supported
    , square : Supported
    }


{-| The union row for `size` (from `AppBarSize`).
-}
type alias Size =
    { extraLarge : Supported
    , extraSmall : Supported
    , large : Supported
    , medium : Supported
    , small : Supported
    }


{-| The union row for `startMode` (from `DrawerMode`).
-}
type alias StartMode =
    { auto : Supported
    , over : Supported
    , push : Supported
    , side : Supported
    }


{-| The union row for `startView` (from `CalendarView`).
-}
type alias StartView =
    { month : Supported
    , multiYear : Supported
    , year : Supported
    }


{-| The union row for `state` (from `OptionPanelState`).
-}
type alias State =
    { content : Supported
    , loading : Supported
    , noData : Supported
    }


{-| The union row for `toggleDirection` (from `ExpansionToggleDirection`).
-}
type alias ToggleDirection =
    { horizontal : Supported
    , vertical : Supported
    }


{-| The union row for `togglePosition` (from `ExpansionTogglePosition`).
-}
type alias TogglePosition =
    { after : Supported
    , before : Supported
    }


{-| The union row for `touchGestures` (from `TooltipTouchGestures`).
-}
type alias TouchGestures =
    { auto : Supported
    , off : Supported
    , on : Supported
    }


{-| The union row for `type_`.
-}
type alias Type =
    { button : Supported
    , reset : Supported
    , submit : Supported
    }


{-| The union row for `variant` (from `ListVariant`).
-}
type alias Variant =
    { auto : Supported
    , connected : Supported
    , contained : Supported
    , content : Supported
    , display : Supported
    , docked : Supported
    , elevated : Supported
    , expressive : Supported
    , fidelity : Supported
    , filled : Supported
    , flat : Supported
    , fruitSalad : Supported
    , headline : Supported
    , label : Supported
    , modal : Supported
    , monochrome : Supported
    , neutral : Supported
    , outlined : Supported
    , primary : Supported
    , primaryContainer : Supported
    , rainbow : Supported
    , rounded : Supported
    , secondary : Supported
    , secondaryContainer : Supported
    , segmented : Supported
    , sharp : Supported
    , standard : Supported
    , surface : Supported
    , tertiary : Supported
    , tertiaryContainer : Supported
    , text : Supported
    , title : Supported
    , tonal : Supported
    , tonalSpot : Supported
    , uncontained : Supported
    , vibrant : Supported
    , wavy : Supported
    }


{-| The union row for `width` (from `IconButtonWidth`).
-}
type alias Width =
    { default : Supported
    , narrow : Supported
    , wide : Supported
    }


{-| The `12-sided-cookie` token.
-}
value12SidedCookie : Value { v | value12SidedCookie : Supported }
value12SidedCookie =
    Ir.token "12-sided-cookie"


{-| The `4-leaf-clover` token.
-}
value4LeafClover : Value { v | value4LeafClover : Supported }
value4LeafClover =
    Ir.token "4-leaf-clover"


{-| The `4-sided-cookie` token.
-}
value4SidedCookie : Value { v | value4SidedCookie : Supported }
value4SidedCookie =
    Ir.token "4-sided-cookie"


{-| The `6-sided-cookie` token.
-}
value6SidedCookie : Value { v | value6SidedCookie : Supported }
value6SidedCookie =
    Ir.token "6-sided-cookie"


{-| The `7-sided-cookie` token.
-}
value7SidedCookie : Value { v | value7SidedCookie : Supported }
value7SidedCookie =
    Ir.token "7-sided-cookie"


{-| The `8-leaf-clover` token.
-}
value8LeafClover : Value { v | value8LeafClover : Supported }
value8LeafClover =
    Ir.token "8-leaf-clover"


{-| The `9-sided-cookie` token.
-}
value9SidedCookie : Value { v | value9SidedCookie : Supported }
value9SidedCookie =
    Ir.token "9-sided-cookie"


{-| The `above` token.
-}
above : Value { v | above : Supported }
above =
    Ir.token "above"


{-| The `above-after` token.
-}
aboveAfter : Value { v | aboveAfter : Supported }
aboveAfter =
    Ir.token "above-after"


{-| The `above-before` token.
-}
aboveBefore : Value { v | aboveBefore : Supported }
aboveBefore =
    Ir.token "above-before"


{-| The `above-below` token.
-}
aboveBelow : Value { v | aboveBelow : Supported }
aboveBelow =
    Ir.token "above-below"


{-| The `after` token.
-}
after : Value { v | after : Supported }
after =
    Ir.token "after"


{-| The `always` token.
-}
always : Value { v | always : Supported }
always =
    Ir.token "always"


{-| The `arch` token.
-}
arch : Value { v | arch : Supported }
arch =
    Ir.token "arch"


{-| The `arrow` token.
-}
arrow : Value { v | arrow : Supported }
arrow =
    Ir.token "arrow"


{-| The `auto` token.
-}
auto : Value { v | auto : Supported }
auto =
    Ir.token "auto"


{-| The `before` token.
-}
before : Value { v | before : Supported }
before =
    Ir.token "before"


{-| The `below` token.
-}
below : Value { v | below : Supported }
below =
    Ir.token "below"


{-| The `below-after` token.
-}
belowAfter : Value { v | belowAfter : Supported }
belowAfter =
    Ir.token "below-after"


{-| The `below-before` token.
-}
belowBefore : Value { v | belowBefore : Supported }
belowBefore =
    Ir.token "below-before"


{-| The `boom` token.
-}
boom : Value { v | boom : Supported }
boom =
    Ir.token "boom"


{-| The `both` token.
-}
both : Value { v | both : Supported }
both =
    Ir.token "both"


{-| The `buffer` token.
-}
buffer : Value { v | buffer : Supported }
buffer =
    Ir.token "buffer"


{-| The `bun` token.
-}
bun : Value { v | bun : Supported }
bun =
    Ir.token "bun"


{-| The `burst` token.
-}
burst : Value { v | burst : Supported }
burst =
    Ir.token "burst"


{-| The `button` token.
-}
button : Value { v | button : Supported }
button =
    Ir.token "button"


{-| The `circle` token.
-}
circle : Value { v | circle : Supported }
circle =
    Ir.token "circle"


{-| The `circular` token.
-}
circular : Value { v | circular : Supported }
circular =
    Ir.token "circular"


{-| The `compact` token.
-}
compact : Value { v | compact : Supported }
compact =
    Ir.token "compact"


{-| The `connected` token.
-}
connected : Value { v | connected : Supported }
connected =
    Ir.token "connected"


{-| The `contained` token.
-}
contained : Value { v | contained : Supported }
contained =
    Ir.token "contained"


{-| The `contains` token.
-}
contains : Value { v | contains : Supported }
contains =
    Ir.token "contains"


{-| The `content` token.
-}
content : Value { v | content : Supported }
content =
    Ir.token "content"


{-| The `dark` token.
-}
dark : Value { v | dark : Supported }
dark =
    Ir.token "dark"


{-| The `date` token.
-}
date : Value { v | date : Supported }
date =
    Ir.token "date"


{-| The `default` token.
-}
default : Value { v | default : Supported }
default =
    Ir.token "default"


{-| The `determinate` token.
-}
determinate : Value { v | determinate : Supported }
determinate =
    Ir.token "determinate"


{-| The `diamond` token.
-}
diamond : Value { v | diamond : Supported }
diamond =
    Ir.token "diamond"


{-| The `display` token.
-}
display : Value { v | display : Supported }
display =
    Ir.token "display"


{-| The `docked` token.
-}
docked : Value { v | docked : Supported }
docked =
    Ir.token "docked"


{-| The `elevated` token.
-}
elevated : Value { v | elevated : Supported }
elevated =
    Ir.token "elevated"


{-| The `end` token.
-}
end : Value { v | end : Supported }
end =
    Ir.token "end"


{-| The `ends-with` token.
-}
endsWith : Value { v | endsWith : Supported }
endsWith =
    Ir.token "ends-with"


{-| The `expanded` token.
-}
expanded : Value { v | expanded : Supported }
expanded =
    Ir.token "expanded"


{-| The `expressive` token.
-}
expressive : Value { v | expressive : Supported }
expressive =
    Ir.token "expressive"


{-| The `extra-large` token.
-}
extraLarge : Value { v | extraLarge : Supported }
extraLarge =
    Ir.token "extra-large"


{-| The `extra-small` token.
-}
extraSmall : Value { v | extraSmall : Supported }
extraSmall =
    Ir.token "extra-small"


{-| The `fan` token.
-}
fan : Value { v | fan : Supported }
fan =
    Ir.token "fan"


{-| The `fidelity` token.
-}
fidelity : Value { v | fidelity : Supported }
fidelity =
    Ir.token "fidelity"


{-| The `filled` token.
-}
filled : Value { v | filled : Supported }
filled =
    Ir.token "filled"


{-| The `flat` token.
-}
flat : Value { v | flat : Supported }
flat =
    Ir.token "flat"


{-| The `flower` token.
-}
flower : Value { v | flower : Supported }
flower =
    Ir.token "flower"


{-| The `fruit-salad` token.
-}
fruitSalad : Value { v | fruitSalad : Supported }
fruitSalad =
    Ir.token "fruit-salad"


{-| The `fullscreen` token.
-}
fullscreen : Value { v | fullscreen : Supported }
fullscreen =
    Ir.token "fullscreen"


{-| The `gem` token.
-}
gem : Value { v | gem : Supported }
gem =
    Ir.token "gem"


{-| The `ghost-ish` token.
-}
ghostIsh : Value { v | ghostIsh : Supported }
ghostIsh =
    Ir.token "ghost-ish"


{-| The `headline` token.
-}
headline : Value { v | headline : Supported }
headline =
    Ir.token "headline"


{-| The `heart` token.
-}
heart : Value { v | heart : Supported }
heart =
    Ir.token "heart"


{-| The `hexagon` token.
-}
hexagon : Value { v | hexagon : Supported }
hexagon =
    Ir.token "hexagon"


{-| The `hide` token.
-}
hide : Value { v | hide : Supported }
hide =
    Ir.token "hide"


{-| The `high` token.
-}
high : Value { v | high : Supported }
high =
    Ir.token "high"


{-| The `horizontal` token.
-}
horizontal : Value { v | horizontal : Supported }
horizontal =
    Ir.token "horizontal"


{-| The `indeterminate` token.
-}
indeterminate : Value { v | indeterminate : Supported }
indeterminate =
    Ir.token "indeterminate"


{-| The `label` token.
-}
label : Value { v | label : Supported }
label =
    Ir.token "label"


{-| The `large` token.
-}
large : Value { v | large : Supported }
large =
    Ir.token "large"


{-| The `light` token.
-}
light : Value { v | light : Supported }
light =
    Ir.token "light"


{-| The `loading` token.
-}
loading : Value { v | loading : Supported }
loading =
    Ir.token "loading"


{-| The `location` token.
-}
location : Value { v | location : Supported }
location =
    Ir.token "location"


{-| The `low` token.
-}
low : Value { v | low : Supported }
low =
    Ir.token "low"


{-| The `medium` token.
-}
medium : Value { v | medium : Supported }
medium =
    Ir.token "medium"


{-| The `modal` token.
-}
modal : Value { v | modal : Supported }
modal =
    Ir.token "modal"


{-| The `monochrome` token.
-}
monochrome : Value { v | monochrome : Supported }
monochrome =
    Ir.token "monochrome"


{-| The `month` token.
-}
month : Value { v | month : Supported }
month =
    Ir.token "month"


{-| The `multi-year` token.
-}
multiYear : Value { v | multiYear : Supported }
multiYear =
    Ir.token "multi-year"


{-| The `narrow` token.
-}
narrow : Value { v | narrow : Supported }
narrow =
    Ir.token "narrow"


{-| The `neutral` token.
-}
neutral : Value { v | neutral : Supported }
neutral =
    Ir.token "neutral"


{-| The `never` token.
-}
never : Value { v | never : Supported }
never =
    Ir.token "never"


{-| The `no-data` token.
-}
noData : Value { v | noData : Supported }
noData =
    Ir.token "no-data"


{-| The `none` token.
-}
none : Value { v | none : Supported }
none =
    Ir.token "none"


{-| The `off` token.
-}
off : Value { v | off : Supported }
off =
    Ir.token "off"


{-| The `on` token.
-}
on : Value { v | on : Supported }
on =
    Ir.token "on"


{-| The `outlined` token.
-}
outlined : Value { v | outlined : Supported }
outlined =
    Ir.token "outlined"


{-| The `oval` token.
-}
oval : Value { v | oval : Supported }
oval =
    Ir.token "oval"


{-| The `over` token.
-}
over : Value { v | over : Supported }
over =
    Ir.token "over"


{-| The `page` token.
-}
page : Value { v | page : Supported }
page =
    Ir.token "page"


{-| The `pentagon` token.
-}
pentagon : Value { v | pentagon : Supported }
pentagon =
    Ir.token "pentagon"


{-| The `pill` token.
-}
pill : Value { v | pill : Supported }
pill =
    Ir.token "pill"


{-| The `pixel-circle` token.
-}
pixelCircle : Value { v | pixelCircle : Supported }
pixelCircle =
    Ir.token "pixel-circle"


{-| The `pixel-triangle` token.
-}
pixelTriangle : Value { v | pixelTriangle : Supported }
pixelTriangle =
    Ir.token "pixel-triangle"


{-| The `primary` token.
-}
primary : Value { v | primary : Supported }
primary =
    Ir.token "primary"


{-| The `primary-container` token.
-}
primaryContainer : Value { v | primaryContainer : Supported }
primaryContainer =
    Ir.token "primary-container"


{-| The `puffy` token.
-}
puffy : Value { v | puffy : Supported }
puffy =
    Ir.token "puffy"


{-| The `puffy-diamond` token.
-}
puffyDiamond : Value { v | puffyDiamond : Supported }
puffyDiamond =
    Ir.token "puffy-diamond"


{-| The `pulse` token.
-}
pulse : Value { v | pulse : Supported }
pulse =
    Ir.token "pulse"


{-| The `push` token.
-}
push : Value { v | push : Supported }
push =
    Ir.token "push"


{-| The `query` token.
-}
query : Value { v | query : Supported }
query =
    Ir.token "query"


{-| The `rainbow` token.
-}
rainbow : Value { v | rainbow : Supported }
rainbow =
    Ir.token "rainbow"


{-| The `reposition` token.
-}
reposition : Value { v | reposition : Supported }
reposition =
    Ir.token "reposition"


{-| The `reset` token.
-}
reset : Value { v | reset : Supported }
reset =
    Ir.token "reset"


{-| The `rounded` token.
-}
rounded : Value { v | rounded : Supported }
rounded =
    Ir.token "rounded"


{-| The `secondary` token.
-}
secondary : Value { v | secondary : Supported }
secondary =
    Ir.token "secondary"


{-| The `secondary-container` token.
-}
secondaryContainer : Value { v | secondaryContainer : Supported }
secondaryContainer =
    Ir.token "secondary-container"


{-| The `segmented` token.
-}
segmented : Value { v | segmented : Supported }
segmented =
    Ir.token "segmented"


{-| The `selected` token.
-}
selected : Value { v | selected : Supported }
selected =
    Ir.token "selected"


{-| The `semicircle` token.
-}
semicircle : Value { v | semicircle : Supported }
semicircle =
    Ir.token "semicircle"


{-| The `sharp` token.
-}
sharp : Value { v | sharp : Supported }
sharp =
    Ir.token "sharp"


{-| The `side` token.
-}
side : Value { v | side : Supported }
side =
    Ir.token "side"


{-| The `slanted` token.
-}
slanted : Value { v | slanted : Supported }
slanted =
    Ir.token "slanted"


{-| The `small` token.
-}
small : Value { v | small : Supported }
small =
    Ir.token "small"


{-| The `soft-boom` token.
-}
softBoom : Value { v | softBoom : Supported }
softBoom =
    Ir.token "soft-boom"


{-| The `soft-burst` token.
-}
softBurst : Value { v | softBurst : Supported }
softBurst =
    Ir.token "soft-burst"


{-| The `square` token.
-}
square : Value { v | square : Supported }
square =
    Ir.token "square"


{-| The `standard` token.
-}
standard : Value { v | standard : Supported }
standard =
    Ir.token "standard"


{-| The `starts-with` token.
-}
startsWith : Value { v | startsWith : Supported }
startsWith =
    Ir.token "starts-with"


{-| The `step` token.
-}
step : Value { v | step : Supported }
step =
    Ir.token "step"


{-| The `submit` token.
-}
submit : Value { v | submit : Supported }
submit =
    Ir.token "submit"


{-| The `sunny` token.
-}
sunny : Value { v | sunny : Supported }
sunny =
    Ir.token "sunny"


{-| The `surface` token.
-}
surface : Value { v | surface : Supported }
surface =
    Ir.token "surface"


{-| The `tertiary` token.
-}
tertiary : Value { v | tertiary : Supported }
tertiary =
    Ir.token "tertiary"


{-| The `tertiary-container` token.
-}
tertiaryContainer : Value { v | tertiaryContainer : Supported }
tertiaryContainer =
    Ir.token "tertiary-container"


{-| The `text` token.
-}
text : Value { v | text : Supported }
text =
    Ir.token "text"


{-| The `time` token.
-}
time : Value { v | time : Supported }
time =
    Ir.token "time"


{-| The `title` token.
-}
title : Value { v | title : Supported }
title =
    Ir.token "title"


{-| The `tonal` token.
-}
tonal : Value { v | tonal : Supported }
tonal =
    Ir.token "tonal"


{-| The `tonal-spot` token.
-}
tonalSpot : Value { v | tonalSpot : Supported }
tonalSpot =
    Ir.token "tonal-spot"


{-| The `triangle` token.
-}
triangle : Value { v | triangle : Supported }
triangle =
    Ir.token "triangle"


{-| The `true` token.
-}
true : Value { v | true : Supported }
true =
    Ir.token "true"


{-| The `uncontained` token.
-}
uncontained : Value { v | uncontained : Supported }
uncontained =
    Ir.token "uncontained"


{-| The `vertical` token.
-}
vertical : Value { v | vertical : Supported }
vertical =
    Ir.token "vertical"


{-| The `very-sunny` token.
-}
verySunny : Value { v | verySunny : Supported }
verySunny =
    Ir.token "very-sunny"


{-| The `vibrant` token.
-}
vibrant : Value { v | vibrant : Supported }
vibrant =
    Ir.token "vibrant"


{-| The `wave` token.
-}
wave : Value { v | wave : Supported }
wave =
    Ir.token "wave"


{-| The `wavy` token.
-}
wavy : Value { v | wavy : Supported }
wavy =
    Ir.token "wavy"


{-| The `wide` token.
-}
wide : Value { v | wide : Supported }
wide =
    Ir.token "wide"


{-| The `year` token.
-}
year : Value { v | year : Supported }
year =
    Ir.token "year"
