module Cem.M3e.Common exposing
    ( targetValue, Value, Supported, toString, value12SidedCookie, value4LeafClover
    , value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, file
    , formdata, above, aboveAfter, aboveBefore, aboveBelow, after
    , always, arch, arrow, auto, before, below
    , belowAfter, belowBefore, boom, both, buffer, bun
    , burst, button, circle, circular, compact, connected
    , contained, contains, content, dark, date, default
    , determinate, diamond, display, docked, elevated, end
    , endsWith, expanded, expressive, extraLarge, extraSmall, fan
    , fidelity, filled, flat, flower, fruitSalad, fullscreen
    , gem, ghostIsh, headline, heart, hexagon, hide
    , high, horizontal, indeterminate, label, large, light
    , loading, location, low, medium, modal, monochrome
    , month, multiYear, narrow, neutral, never, noData
    , none, off, on, outlined, oval, over
    , page, pentagon, pill, pixelCircle, pixelTriangle, primary
    , primaryContainer, puffy, puffyDiamond, pulse, push, query
    , rainbow, reposition, reset, rounded, secondary, secondaryContainer
    , segmented, selected, semicircle, sharp, side, slanted
    , small, softBoom, softBurst, square, standard, startsWith
    , step, submit, sunny, surface, tertiary, tertiaryContainer
    , text, time, title, tonal, tonalSpot, triangle
    , true, uncontained, vertical, verySunny, vibrant, wave
    , wavy, wide, year, animation, animationNone, animationPulse
    , animationWave, contrast, contrastHigh, contrastMedium, contrastStandard, current
    , currentDate, currentLocation, currentPage, currentStep, currentTime, currentTrue
    , dividers, dividersAbove, dividersAboveBelow, dividersBelow, dividersNone, endMode
    , endModeAuto, endModeOver, endModePush, endModeSide, filter, filterContains
    , filterEndsWith, filterNone, filterStartsWith, floatLabel, floatLabelAlways, floatLabelAuto
    , grade, gradeHigh, gradeLow, gradeMedium, headerPosition, headerPositionAbove
    , headerPositionAfter, headerPositionBefore, headerPositionBelow, hideSubscript, hideSubscriptAlways, hideSubscriptAuto
    , hideSubscriptNever, highlightMode, highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, icons
    , iconsBoth, iconsNone, iconsSelected, labelPosition, labelPositionBelow, labelPositionEnd
    , mode, modeAuto, modeBuffer, modeCompact, modeContains, modeDeterminate
    , modeDocked, modeEndsWith, modeExpanded, modeFullscreen, modeIndeterminate, modeQuery
    , modeStartsWith, motion, motionExpressive, motionStandard, name, nameV12SidedCookie
    , nameV4LeafClover, nameV4SidedCookie, nameV6SidedCookie, nameV7SidedCookie, nameV8LeafClover, nameV9SidedCookie
    , nameArch, nameArrow, nameBoom, nameBun, nameBurst, nameCircle
    , nameDiamond, nameFan, nameFlower, nameGem, nameGhostIsh, nameHeart
    , nameHexagon, nameOval, namePentagon, namePill, namePixelCircle, namePixelTriangle
    , namePuffy, namePuffyDiamond, nameSemicircle, nameSlanted, nameSoftBoom, nameSoftBurst
    , nameSquare, nameSunny, nameTriangle, nameVerySunny, orientation, orientationAuto
    , orientationHorizontal, orientationVertical, pageSizeVariant, pageSizeVariantFilled, pageSizeVariantOutlined, position
    , positionAbove, positionAboveAfter, positionAboveBefore, positionAfter, positionBefore, positionBelow
    , positionBelowAfter, positionBelowBefore, positionX, positionXAfter, positionXBefore, positionY
    , positionYAbove, positionYBelow, scheme, schemeAuto, schemeDark, schemeLight
    , scrollStrategy, scrollStrategyHide, scrollStrategyReposition, shape, shapeAuto, shapeCircular
    , shapeRounded, shapeSquare, size, sizeExtraLarge, sizeExtraSmall, sizeLarge
    , sizeMedium, sizeSmall, startMode, startModeAuto, startModeOver, startModePush
    , startModeSide, startView, startViewMonth, startViewMultiYear, startViewYear, state
    , stateContent, stateLoading, stateNoData, toggleDirection, toggleDirectionHorizontal, toggleDirectionVertical
    , togglePosition, togglePositionAfter, togglePositionBefore, touchGestures, touchGesturesAuto, touchGesturesOff
    , touchGesturesOn, type_, typeButton, typeReset, typeSubmit, variant
    , variantAuto, variantConnected, variantContained, variantContent, variantDisplay, variantDocked
    , variantElevated, variantExpressive, variantFidelity, variantFilled, variantFlat, variantFruitSalad
    , variantHeadline, variantLabel, variantModal, variantMonochrome, variantNeutral, variantOutlined
    , variantPrimary, variantPrimaryContainer, variantRainbow, variantRounded, variantSecondary, variantSecondaryContainer
    , variantSegmented, variantSharp, variantStandard, variantSurface, variantTertiary, variantTertiaryContainer
    , variantText, variantTitle, variantTonal, variantTonalSpot, variantUncontained, variantVibrant
    , variantWavy, width, widthDefault, widthNarrow, widthWide, activeDate
    , anchorOffset, caseSensitive, centered, checked, clearLabel, clearable
    , closeLabel, color, dateAttr, detent, dirty, disabled
    , disabledInteractive, dismissible, download, fitAnchorWidth, for, haschilditems
    , hideDelay, hideSelectionIndicator, hideToggle, href, indeterminateAttr, isdark
    , isopen, labelAttr, maxAttr, maxDate, minAttr, minDate
    , multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, overshootLimit
    , panelClass, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, pristine
    , rangeEnd, rangeStart, rel, selectedAttr, selectedindex, shouldlabelfloat
    , showDelay, startAt, stepAttr, target, term, today
    , toggle, touched, untouched, validationmessage, verticalAttr, visible
    , willvalidate
    )

{-|

@docs targetValue, Value, Supported, toString, value12SidedCookie, value4LeafClover
@docs value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, file
@docs formdata, above, aboveAfter, aboveBefore, aboveBelow, after
@docs always, arch, arrow, auto, before, below
@docs belowAfter, belowBefore, boom, both, buffer, bun
@docs burst, button, circle, circular, compact, connected
@docs contained, contains, content, dark, date, default
@docs determinate, diamond, display, docked, elevated, end
@docs endsWith, expanded, expressive, extraLarge, extraSmall, fan
@docs fidelity, filled, flat, flower, fruitSalad, fullscreen
@docs gem, ghostIsh, headline, heart, hexagon, hide
@docs high, horizontal, indeterminate, label, large, light
@docs loading, location, low, medium, modal, monochrome
@docs month, multiYear, narrow, neutral, never, noData
@docs none, off, on, outlined, oval, over
@docs page, pentagon, pill, pixelCircle, pixelTriangle, primary
@docs primaryContainer, puffy, puffyDiamond, pulse, push, query
@docs rainbow, reposition, reset, rounded, secondary, secondaryContainer
@docs segmented, selected, semicircle, sharp, side, slanted
@docs small, softBoom, softBurst, square, standard, startsWith
@docs step, submit, sunny, surface, tertiary, tertiaryContainer
@docs text, time, title, tonal, tonalSpot, triangle
@docs true, uncontained, vertical, verySunny, vibrant, wave
@docs wavy, wide, year, animation, animationNone, animationPulse
@docs animationWave, contrast, contrastHigh, contrastMedium, contrastStandard, current
@docs currentDate, currentLocation, currentPage, currentStep, currentTime, currentTrue
@docs dividers, dividersAbove, dividersAboveBelow, dividersBelow, dividersNone, endMode
@docs endModeAuto, endModeOver, endModePush, endModeSide, filter, filterContains
@docs filterEndsWith, filterNone, filterStartsWith, floatLabel, floatLabelAlways, floatLabelAuto
@docs grade, gradeHigh, gradeLow, gradeMedium, headerPosition, headerPositionAbove
@docs headerPositionAfter, headerPositionBefore, headerPositionBelow, hideSubscript, hideSubscriptAlways, hideSubscriptAuto
@docs hideSubscriptNever, highlightMode, highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, icons
@docs iconsBoth, iconsNone, iconsSelected, labelPosition, labelPositionBelow, labelPositionEnd
@docs mode, modeAuto, modeBuffer, modeCompact, modeContains, modeDeterminate
@docs modeDocked, modeEndsWith, modeExpanded, modeFullscreen, modeIndeterminate, modeQuery
@docs modeStartsWith, motion, motionExpressive, motionStandard, name, nameV12SidedCookie
@docs nameV4LeafClover, nameV4SidedCookie, nameV6SidedCookie, nameV7SidedCookie, nameV8LeafClover, nameV9SidedCookie
@docs nameArch, nameArrow, nameBoom, nameBun, nameBurst, nameCircle
@docs nameDiamond, nameFan, nameFlower, nameGem, nameGhostIsh, nameHeart
@docs nameHexagon, nameOval, namePentagon, namePill, namePixelCircle, namePixelTriangle
@docs namePuffy, namePuffyDiamond, nameSemicircle, nameSlanted, nameSoftBoom, nameSoftBurst
@docs nameSquare, nameSunny, nameTriangle, nameVerySunny, orientation, orientationAuto
@docs orientationHorizontal, orientationVertical, pageSizeVariant, pageSizeVariantFilled, pageSizeVariantOutlined, position
@docs positionAbove, positionAboveAfter, positionAboveBefore, positionAfter, positionBefore, positionBelow
@docs positionBelowAfter, positionBelowBefore, positionX, positionXAfter, positionXBefore, positionY
@docs positionYAbove, positionYBelow, scheme, schemeAuto, schemeDark, schemeLight
@docs scrollStrategy, scrollStrategyHide, scrollStrategyReposition, shape, shapeAuto, shapeCircular
@docs shapeRounded, shapeSquare, size, sizeExtraLarge, sizeExtraSmall, sizeLarge
@docs sizeMedium, sizeSmall, startMode, startModeAuto, startModeOver, startModePush
@docs startModeSide, startView, startViewMonth, startViewMultiYear, startViewYear, state
@docs stateContent, stateLoading, stateNoData, toggleDirection, toggleDirectionHorizontal, toggleDirectionVertical
@docs togglePosition, togglePositionAfter, togglePositionBefore, touchGestures, touchGesturesAuto, touchGesturesOff
@docs touchGesturesOn, type_, typeButton, typeReset, typeSubmit, variant
@docs variantAuto, variantConnected, variantContained, variantContent, variantDisplay, variantDocked
@docs variantElevated, variantExpressive, variantFidelity, variantFilled, variantFlat, variantFruitSalad
@docs variantHeadline, variantLabel, variantModal, variantMonochrome, variantNeutral, variantOutlined
@docs variantPrimary, variantPrimaryContainer, variantRainbow, variantRounded, variantSecondary, variantSecondaryContainer
@docs variantSegmented, variantSharp, variantStandard, variantSurface, variantTertiary, variantTertiaryContainer
@docs variantText, variantTitle, variantTonal, variantTonalSpot, variantUncontained, variantVibrant
@docs variantWavy, width, widthDefault, widthNarrow, widthWide, activeDate
@docs anchorOffset, caseSensitive, centered, checked, clearLabel, clearable
@docs closeLabel, color, dateAttr, detent, dirty, disabled
@docs disabledInteractive, dismissible, download, fitAnchorWidth, for, haschilditems
@docs hideDelay, hideSelectionIndicator, hideToggle, href, indeterminateAttr, isdark
@docs isopen, labelAttr, maxAttr, maxDate, minAttr, minDate
@docs multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, overshootLimit
@docs panelClass, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, pristine
@docs rangeEnd, rangeStart, rel, selectedAttr, selectedindex, shouldlabelfloat
@docs showDelay, startAt, stepAttr, target, term, today
@docs toggle, touched, untouched, validationmessage, verticalAttr, visible
@docs willvalidate

-}

import Html
import Html.Attributes
import Json.Decode
import Json.Encode


{-| Decode the current value of a value-bearing event off its target (`event.target.value`).

Handy for `change` / `input` style events:

    onChange (Json.Decode.map ValueChanged targetValue)

-}
targetValue : Json.Decode.Decoder String
targetValue =
    Json.Decode.at [ "target", "value" ] Json.Decode.string


{-| An opaque, shared design-token value. Its phantom row records which axes accept it, so a single token (e.g. `medium`) is reusable across every component that supports it while impossible values stay unrepresentable.
-}
type Value values
    = Value String


{-| Phantom row marker: a `Value`'s row lists, as `Supported` fields, the axes that accept it.
-}
type Supported
    = Supported


{-| Unwrap a token to the string it emits.
-}
toString : Value values -> String
toString val_ =
    case val_ of
        Value raw_ ->
            raw_


{-| The shared `12-sided-cookie` value token.
-}
value12SidedCookie : Value { a | value12SidedCookie : Supported }
value12SidedCookie =
    Value "12-sided-cookie"


{-| The shared `4-leaf-clover` value token.
-}
value4LeafClover : Value { a | value4LeafClover : Supported }
value4LeafClover =
    Value "4-leaf-clover"


{-| The shared `4-sided-cookie` value token.
-}
value4SidedCookie : Value { a | value4SidedCookie : Supported }
value4SidedCookie =
    Value "4-sided-cookie"


{-| The shared `6-sided-cookie` value token.
-}
value6SidedCookie : Value { a | value6SidedCookie : Supported }
value6SidedCookie =
    Value "6-sided-cookie"


{-| The shared `7-sided-cookie` value token.
-}
value7SidedCookie : Value { a | value7SidedCookie : Supported }
value7SidedCookie =
    Value "7-sided-cookie"


{-| The shared `8-leaf-clover` value token.
-}
value8LeafClover : Value { a | value8LeafClover : Supported }
value8LeafClover =
    Value "8-leaf-clover"


{-| The shared `9-sided-cookie` value token.
-}
value9SidedCookie : Value { a | value9SidedCookie : Supported }
value9SidedCookie =
    Value "9-sided-cookie"


{-| The shared `File` value token.
-}
file : Value { a | file : Supported }
file =
    Value "File"


{-| The shared `FormData` value token.
-}
formdata : Value { a | formdata : Supported }
formdata =
    Value "FormData"


{-| The shared `above` value token.
-}
above : Value { a | above : Supported }
above =
    Value "above"


{-| The shared `above-after` value token.
-}
aboveAfter : Value { a | aboveAfter : Supported }
aboveAfter =
    Value "above-after"


{-| The shared `above-before` value token.
-}
aboveBefore : Value { a | aboveBefore : Supported }
aboveBefore =
    Value "above-before"


{-| The shared `above-below` value token.
-}
aboveBelow : Value { a | aboveBelow : Supported }
aboveBelow =
    Value "above-below"


{-| The shared `after` value token.
-}
after : Value { a | after : Supported }
after =
    Value "after"


{-| The shared `always` value token.
-}
always : Value { a | always : Supported }
always =
    Value "always"


{-| The shared `arch` value token.
-}
arch : Value { a | arch : Supported }
arch =
    Value "arch"


{-| The shared `arrow` value token.
-}
arrow : Value { a | arrow : Supported }
arrow =
    Value "arrow"


{-| The shared `auto` value token.
-}
auto : Value { a | auto : Supported }
auto =
    Value "auto"


{-| The shared `before` value token.
-}
before : Value { a | before : Supported }
before =
    Value "before"


{-| The shared `below` value token.
-}
below : Value { a | below : Supported }
below =
    Value "below"


{-| The shared `below-after` value token.
-}
belowAfter : Value { a | belowAfter : Supported }
belowAfter =
    Value "below-after"


{-| The shared `below-before` value token.
-}
belowBefore : Value { a | belowBefore : Supported }
belowBefore =
    Value "below-before"


{-| The shared `boom` value token.
-}
boom : Value { a | boom : Supported }
boom =
    Value "boom"


{-| The shared `both` value token.
-}
both : Value { a | both : Supported }
both =
    Value "both"


{-| The shared `buffer` value token.
-}
buffer : Value { a | buffer : Supported }
buffer =
    Value "buffer"


{-| The shared `bun` value token.
-}
bun : Value { a | bun : Supported }
bun =
    Value "bun"


{-| The shared `burst` value token.
-}
burst : Value { a | burst : Supported }
burst =
    Value "burst"


{-| The shared `button` value token.
-}
button : Value { a | button : Supported }
button =
    Value "button"


{-| The shared `circle` value token.
-}
circle : Value { a | circle : Supported }
circle =
    Value "circle"


{-| The shared `circular` value token.
-}
circular : Value { a | circular : Supported }
circular =
    Value "circular"


{-| The shared `compact` value token.
-}
compact : Value { a | compact : Supported }
compact =
    Value "compact"


{-| The shared `connected` value token.
-}
connected : Value { a | connected : Supported }
connected =
    Value "connected"


{-| The shared `contained` value token.
-}
contained : Value { a | contained : Supported }
contained =
    Value "contained"


{-| The shared `contains` value token.
-}
contains : Value { a | contains : Supported }
contains =
    Value "contains"


{-| The shared `content` value token.
-}
content : Value { a | content : Supported }
content =
    Value "content"


{-| The shared `dark` value token.
-}
dark : Value { a | dark : Supported }
dark =
    Value "dark"


{-| The shared `date` value token.
-}
date : Value { a | date : Supported }
date =
    Value "date"


{-| The shared `default` value token.
-}
default : Value { a | default : Supported }
default =
    Value "default"


{-| The shared `determinate` value token.
-}
determinate : Value { a | determinate : Supported }
determinate =
    Value "determinate"


{-| The shared `diamond` value token.
-}
diamond : Value { a | diamond : Supported }
diamond =
    Value "diamond"


{-| The shared `display` value token.
-}
display : Value { a | display : Supported }
display =
    Value "display"


{-| The shared `docked` value token.
-}
docked : Value { a | docked : Supported }
docked =
    Value "docked"


{-| The shared `elevated` value token.
-}
elevated : Value { a | elevated : Supported }
elevated =
    Value "elevated"


{-| The shared `end` value token.
-}
end : Value { a | end : Supported }
end =
    Value "end"


{-| The shared `ends-with` value token.
-}
endsWith : Value { a | endsWith : Supported }
endsWith =
    Value "ends-with"


{-| The shared `expanded` value token.
-}
expanded : Value { a | expanded : Supported }
expanded =
    Value "expanded"


{-| The shared `expressive` value token.
-}
expressive : Value { a | expressive : Supported }
expressive =
    Value "expressive"


{-| The shared `extra-large` value token.
-}
extraLarge : Value { a | extraLarge : Supported }
extraLarge =
    Value "extra-large"


{-| The shared `extra-small` value token.
-}
extraSmall : Value { a | extraSmall : Supported }
extraSmall =
    Value "extra-small"


{-| The shared `fan` value token.
-}
fan : Value { a | fan : Supported }
fan =
    Value "fan"


{-| The shared `fidelity` value token.
-}
fidelity : Value { a | fidelity : Supported }
fidelity =
    Value "fidelity"


{-| The shared `filled` value token.
-}
filled : Value { a | filled : Supported }
filled =
    Value "filled"


{-| The shared `flat` value token.
-}
flat : Value { a | flat : Supported }
flat =
    Value "flat"


{-| The shared `flower` value token.
-}
flower : Value { a | flower : Supported }
flower =
    Value "flower"


{-| The shared `fruit-salad` value token.
-}
fruitSalad : Value { a | fruitSalad : Supported }
fruitSalad =
    Value "fruit-salad"


{-| The shared `fullscreen` value token.
-}
fullscreen : Value { a | fullscreen : Supported }
fullscreen =
    Value "fullscreen"


{-| The shared `gem` value token.
-}
gem : Value { a | gem : Supported }
gem =
    Value "gem"


{-| The shared `ghost-ish` value token.
-}
ghostIsh : Value { a | ghostIsh : Supported }
ghostIsh =
    Value "ghost-ish"


{-| The shared `headline` value token.
-}
headline : Value { a | headline : Supported }
headline =
    Value "headline"


{-| The shared `heart` value token.
-}
heart : Value { a | heart : Supported }
heart =
    Value "heart"


{-| The shared `hexagon` value token.
-}
hexagon : Value { a | hexagon : Supported }
hexagon =
    Value "hexagon"


{-| The shared `hide` value token.
-}
hide : Value { a | hide : Supported }
hide =
    Value "hide"


{-| The shared `high` value token.
-}
high : Value { a | high : Supported }
high =
    Value "high"


{-| The shared `horizontal` value token.
-}
horizontal : Value { a | horizontal : Supported }
horizontal =
    Value "horizontal"


{-| The shared `indeterminate` value token.
-}
indeterminate : Value { a | indeterminate : Supported }
indeterminate =
    Value "indeterminate"


{-| The shared `label` value token.
-}
label : Value { a | label : Supported }
label =
    Value "label"


{-| The shared `large` value token.
-}
large : Value { a | large : Supported }
large =
    Value "large"


{-| The shared `light` value token.
-}
light : Value { a | light : Supported }
light =
    Value "light"


{-| The shared `loading` value token.
-}
loading : Value { a | loading : Supported }
loading =
    Value "loading"


{-| The shared `location` value token.
-}
location : Value { a | location : Supported }
location =
    Value "location"


{-| The shared `low` value token.
-}
low : Value { a | low : Supported }
low =
    Value "low"


{-| The shared `medium` value token.
-}
medium : Value { a | medium : Supported }
medium =
    Value "medium"


{-| The shared `modal` value token.
-}
modal : Value { a | modal : Supported }
modal =
    Value "modal"


{-| The shared `monochrome` value token.
-}
monochrome : Value { a | monochrome : Supported }
monochrome =
    Value "monochrome"


{-| The shared `month` value token.
-}
month : Value { a | month : Supported }
month =
    Value "month"


{-| The shared `multi-year` value token.
-}
multiYear : Value { a | multiYear : Supported }
multiYear =
    Value "multi-year"


{-| The shared `narrow` value token.
-}
narrow : Value { a | narrow : Supported }
narrow =
    Value "narrow"


{-| The shared `neutral` value token.
-}
neutral : Value { a | neutral : Supported }
neutral =
    Value "neutral"


{-| The shared `never` value token.
-}
never : Value { a | never : Supported }
never =
    Value "never"


{-| The shared `no-data` value token.
-}
noData : Value { a | noData : Supported }
noData =
    Value "no-data"


{-| The shared `none` value token.
-}
none : Value { a | none : Supported }
none =
    Value "none"


{-| The shared `off` value token.
-}
off : Value { a | off : Supported }
off =
    Value "off"


{-| The shared `on` value token.
-}
on : Value { a | on : Supported }
on =
    Value "on"


{-| The shared `outlined` value token.
-}
outlined : Value { a | outlined : Supported }
outlined =
    Value "outlined"


{-| The shared `oval` value token.
-}
oval : Value { a | oval : Supported }
oval =
    Value "oval"


{-| The shared `over` value token.
-}
over : Value { a | over : Supported }
over =
    Value "over"


{-| The shared `page` value token.
-}
page : Value { a | page : Supported }
page =
    Value "page"


{-| The shared `pentagon` value token.
-}
pentagon : Value { a | pentagon : Supported }
pentagon =
    Value "pentagon"


{-| The shared `pill` value token.
-}
pill : Value { a | pill : Supported }
pill =
    Value "pill"


{-| The shared `pixel-circle` value token.
-}
pixelCircle : Value { a | pixelCircle : Supported }
pixelCircle =
    Value "pixel-circle"


{-| The shared `pixel-triangle` value token.
-}
pixelTriangle : Value { a | pixelTriangle : Supported }
pixelTriangle =
    Value "pixel-triangle"


{-| The shared `primary` value token.
-}
primary : Value { a | primary : Supported }
primary =
    Value "primary"


{-| The shared `primary-container` value token.
-}
primaryContainer : Value { a | primaryContainer : Supported }
primaryContainer =
    Value "primary-container"


{-| The shared `puffy` value token.
-}
puffy : Value { a | puffy : Supported }
puffy =
    Value "puffy"


{-| The shared `puffy-diamond` value token.
-}
puffyDiamond : Value { a | puffyDiamond : Supported }
puffyDiamond =
    Value "puffy-diamond"


{-| The shared `pulse` value token.
-}
pulse : Value { a | pulse : Supported }
pulse =
    Value "pulse"


{-| The shared `push` value token.
-}
push : Value { a | push : Supported }
push =
    Value "push"


{-| The shared `query` value token.
-}
query : Value { a | query : Supported }
query =
    Value "query"


{-| The shared `rainbow` value token.
-}
rainbow : Value { a | rainbow : Supported }
rainbow =
    Value "rainbow"


{-| The shared `reposition` value token.
-}
reposition : Value { a | reposition : Supported }
reposition =
    Value "reposition"


{-| The shared `reset` value token.
-}
reset : Value { a | reset : Supported }
reset =
    Value "reset"


{-| The shared `rounded` value token.
-}
rounded : Value { a | rounded : Supported }
rounded =
    Value "rounded"


{-| The shared `secondary` value token.
-}
secondary : Value { a | secondary : Supported }
secondary =
    Value "secondary"


{-| The shared `secondary-container` value token.
-}
secondaryContainer : Value { a | secondaryContainer : Supported }
secondaryContainer =
    Value "secondary-container"


{-| The shared `segmented` value token.
-}
segmented : Value { a | segmented : Supported }
segmented =
    Value "segmented"


{-| The shared `selected` value token.
-}
selected : Value { a | selected : Supported }
selected =
    Value "selected"


{-| The shared `semicircle` value token.
-}
semicircle : Value { a | semicircle : Supported }
semicircle =
    Value "semicircle"


{-| The shared `sharp` value token.
-}
sharp : Value { a | sharp : Supported }
sharp =
    Value "sharp"


{-| The shared `side` value token.
-}
side : Value { a | side : Supported }
side =
    Value "side"


{-| The shared `slanted` value token.
-}
slanted : Value { a | slanted : Supported }
slanted =
    Value "slanted"


{-| The shared `small` value token.
-}
small : Value { a | small : Supported }
small =
    Value "small"


{-| The shared `soft-boom` value token.
-}
softBoom : Value { a | softBoom : Supported }
softBoom =
    Value "soft-boom"


{-| The shared `soft-burst` value token.
-}
softBurst : Value { a | softBurst : Supported }
softBurst =
    Value "soft-burst"


{-| The shared `square` value token.
-}
square : Value { a | square : Supported }
square =
    Value "square"


{-| The shared `standard` value token.
-}
standard : Value { a | standard : Supported }
standard =
    Value "standard"


{-| The shared `starts-with` value token.
-}
startsWith : Value { a | startsWith : Supported }
startsWith =
    Value "starts-with"


{-| The shared `step` value token.
-}
step : Value { a | step : Supported }
step =
    Value "step"


{-| The shared `submit` value token.
-}
submit : Value { a | submit : Supported }
submit =
    Value "submit"


{-| The shared `sunny` value token.
-}
sunny : Value { a | sunny : Supported }
sunny =
    Value "sunny"


{-| The shared `surface` value token.
-}
surface : Value { a | surface : Supported }
surface =
    Value "surface"


{-| The shared `tertiary` value token.
-}
tertiary : Value { a | tertiary : Supported }
tertiary =
    Value "tertiary"


{-| The shared `tertiary-container` value token.
-}
tertiaryContainer : Value { a | tertiaryContainer : Supported }
tertiaryContainer =
    Value "tertiary-container"


{-| The shared `text` value token.
-}
text : Value { a | text : Supported }
text =
    Value "text"


{-| The shared `time` value token.
-}
time : Value { a | time : Supported }
time =
    Value "time"


{-| The shared `title` value token.
-}
title : Value { a | title : Supported }
title =
    Value "title"


{-| The shared `tonal` value token.
-}
tonal : Value { a | tonal : Supported }
tonal =
    Value "tonal"


{-| The shared `tonal-spot` value token.
-}
tonalSpot : Value { a | tonalSpot : Supported }
tonalSpot =
    Value "tonal-spot"


{-| The shared `triangle` value token.
-}
triangle : Value { a | triangle : Supported }
triangle =
    Value "triangle"


{-| The shared `true` value token.
-}
true : Value { a | true : Supported }
true =
    Value "true"


{-| The shared `uncontained` value token.
-}
uncontained : Value { a | uncontained : Supported }
uncontained =
    Value "uncontained"


{-| The shared `vertical` value token.
-}
vertical : Value { a | vertical : Supported }
vertical =
    Value "vertical"


{-| The shared `very-sunny` value token.
-}
verySunny : Value { a | verySunny : Supported }
verySunny =
    Value "very-sunny"


{-| The shared `vibrant` value token.
-}
vibrant : Value { a | vibrant : Supported }
vibrant =
    Value "vibrant"


{-| The shared `wave` value token.
-}
wave : Value { a | wave : Supported }
wave =
    Value "wave"


{-| The shared `wavy` value token.
-}
wavy : Value { a | wavy : Supported }
wavy =
    Value "wavy"


{-| The shared `wide` value token.
-}
wide : Value { a | wide : Supported }
wide =
    Value "wide"


{-| The shared `year` value token.
-}
year : Value { a | year : Supported }
year =
    Value "year"


{-| Set the `animation` attribute to any supported value token.
-}
animation : Value values -> Html.Attribute msg
animation val_ =
    Html.Attributes.attribute "animation" (toString val_)


{-| `animation none` — shorthand.
-}
animationNone : Html.Attribute msg
animationNone =
    animation none


{-| `animation pulse` — shorthand.
-}
animationPulse : Html.Attribute msg
animationPulse =
    animation pulse


{-| `animation wave` — shorthand.
-}
animationWave : Html.Attribute msg
animationWave =
    animation wave


{-| Set the `contrast` attribute to any supported value token.
-}
contrast : Value values -> Html.Attribute msg
contrast val_ =
    Html.Attributes.attribute "contrast" (toString val_)


{-| `contrast high` — shorthand.
-}
contrastHigh : Html.Attribute msg
contrastHigh =
    contrast high


{-| `contrast medium` — shorthand.
-}
contrastMedium : Html.Attribute msg
contrastMedium =
    contrast medium


{-| `contrast standard` — shorthand.
-}
contrastStandard : Html.Attribute msg
contrastStandard =
    contrast standard


{-| Set the `current` attribute to any supported value token.
-}
current : Value values -> Html.Attribute msg
current val_ =
    Html.Attributes.attribute "current" (toString val_)


{-| `current date` — shorthand.
-}
currentDate : Html.Attribute msg
currentDate =
    current date


{-| `current location` — shorthand.
-}
currentLocation : Html.Attribute msg
currentLocation =
    current location


{-| `current page` — shorthand.
-}
currentPage : Html.Attribute msg
currentPage =
    current page


{-| `current step` — shorthand.
-}
currentStep : Html.Attribute msg
currentStep =
    current step


{-| `current time` — shorthand.
-}
currentTime : Html.Attribute msg
currentTime =
    current time


{-| `current true` — shorthand.
-}
currentTrue : Html.Attribute msg
currentTrue =
    current true


{-| Set the `dividers` attribute to any supported value token.
-}
dividers : Value values -> Html.Attribute msg
dividers val_ =
    Html.Attributes.attribute "dividers" (toString val_)


{-| `dividers above` — shorthand.
-}
dividersAbove : Html.Attribute msg
dividersAbove =
    dividers above


{-| `dividers aboveBelow` — shorthand.
-}
dividersAboveBelow : Html.Attribute msg
dividersAboveBelow =
    dividers aboveBelow


{-| `dividers below` — shorthand.
-}
dividersBelow : Html.Attribute msg
dividersBelow =
    dividers below


{-| `dividers none` — shorthand.
-}
dividersNone : Html.Attribute msg
dividersNone =
    dividers none


{-| Set the `end-mode` attribute to any supported value token.
-}
endMode : Value values -> Html.Attribute msg
endMode val_ =
    Html.Attributes.attribute "end-mode" (toString val_)


{-| `endMode auto` — shorthand.
-}
endModeAuto : Html.Attribute msg
endModeAuto =
    endMode auto


{-| `endMode over` — shorthand.
-}
endModeOver : Html.Attribute msg
endModeOver =
    endMode over


{-| `endMode push` — shorthand.
-}
endModePush : Html.Attribute msg
endModePush =
    endMode push


{-| `endMode side` — shorthand.
-}
endModeSide : Html.Attribute msg
endModeSide =
    endMode side


{-| Set the `filter` attribute to any supported value token.
-}
filter : Value values -> Html.Attribute msg
filter val_ =
    Html.Attributes.attribute "filter" (toString val_)


{-| `filter contains` — shorthand.
-}
filterContains : Html.Attribute msg
filterContains =
    filter contains


{-| `filter endsWith` — shorthand.
-}
filterEndsWith : Html.Attribute msg
filterEndsWith =
    filter endsWith


{-| `filter none` — shorthand.
-}
filterNone : Html.Attribute msg
filterNone =
    filter none


{-| `filter startsWith` — shorthand.
-}
filterStartsWith : Html.Attribute msg
filterStartsWith =
    filter startsWith


{-| Set the `float-label` attribute to any supported value token.
-}
floatLabel : Value values -> Html.Attribute msg
floatLabel val_ =
    Html.Attributes.attribute "float-label" (toString val_)


{-| `floatLabel always` — shorthand.
-}
floatLabelAlways : Html.Attribute msg
floatLabelAlways =
    floatLabel always


{-| `floatLabel auto` — shorthand.
-}
floatLabelAuto : Html.Attribute msg
floatLabelAuto =
    floatLabel auto


{-| Set the `grade` attribute to any supported value token.
-}
grade : Value values -> Html.Attribute msg
grade val_ =
    Html.Attributes.attribute "grade" (toString val_)


{-| `grade high` — shorthand.
-}
gradeHigh : Html.Attribute msg
gradeHigh =
    grade high


{-| `grade low` — shorthand.
-}
gradeLow : Html.Attribute msg
gradeLow =
    grade low


{-| `grade medium` — shorthand.
-}
gradeMedium : Html.Attribute msg
gradeMedium =
    grade medium


{-| Set the `header-position` attribute to any supported value token.
-}
headerPosition : Value values -> Html.Attribute msg
headerPosition val_ =
    Html.Attributes.attribute "header-position" (toString val_)


{-| `headerPosition above` — shorthand.
-}
headerPositionAbove : Html.Attribute msg
headerPositionAbove =
    headerPosition above


{-| `headerPosition after` — shorthand.
-}
headerPositionAfter : Html.Attribute msg
headerPositionAfter =
    headerPosition after


{-| `headerPosition before` — shorthand.
-}
headerPositionBefore : Html.Attribute msg
headerPositionBefore =
    headerPosition before


{-| `headerPosition below` — shorthand.
-}
headerPositionBelow : Html.Attribute msg
headerPositionBelow =
    headerPosition below


{-| Set the `hide-subscript` attribute to any supported value token.
-}
hideSubscript : Value values -> Html.Attribute msg
hideSubscript val_ =
    Html.Attributes.attribute "hide-subscript" (toString val_)


{-| `hideSubscript always` — shorthand.
-}
hideSubscriptAlways : Html.Attribute msg
hideSubscriptAlways =
    hideSubscript always


{-| `hideSubscript auto` — shorthand.
-}
hideSubscriptAuto : Html.Attribute msg
hideSubscriptAuto =
    hideSubscript auto


{-| `hideSubscript never` — shorthand.
-}
hideSubscriptNever : Html.Attribute msg
hideSubscriptNever =
    hideSubscript never


{-| Set the `highlight-mode` attribute to any supported value token.
-}
highlightMode : Value values -> Html.Attribute msg
highlightMode val_ =
    Html.Attributes.attribute "highlight-mode" (toString val_)


{-| `highlightMode contains` — shorthand.
-}
highlightModeContains : Html.Attribute msg
highlightModeContains =
    highlightMode contains


{-| `highlightMode endsWith` — shorthand.
-}
highlightModeEndsWith : Html.Attribute msg
highlightModeEndsWith =
    highlightMode endsWith


{-| `highlightMode startsWith` — shorthand.
-}
highlightModeStartsWith : Html.Attribute msg
highlightModeStartsWith =
    highlightMode startsWith


{-| Set the `icons` attribute to any supported value token.
-}
icons : Value values -> Html.Attribute msg
icons val_ =
    Html.Attributes.attribute "icons" (toString val_)


{-| `icons both` — shorthand.
-}
iconsBoth : Html.Attribute msg
iconsBoth =
    icons both


{-| `icons none` — shorthand.
-}
iconsNone : Html.Attribute msg
iconsNone =
    icons none


{-| `icons selected` — shorthand.
-}
iconsSelected : Html.Attribute msg
iconsSelected =
    icons selected


{-| Set the `label-position` attribute to any supported value token.
-}
labelPosition : Value values -> Html.Attribute msg
labelPosition val_ =
    Html.Attributes.attribute "label-position" (toString val_)


{-| `labelPosition below` — shorthand.
-}
labelPositionBelow : Html.Attribute msg
labelPositionBelow =
    labelPosition below


{-| `labelPosition end` — shorthand.
-}
labelPositionEnd : Html.Attribute msg
labelPositionEnd =
    labelPosition end


{-| Set the `mode` attribute to any supported value token.
-}
mode : Value values -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" (toString val_)


{-| `mode auto` — shorthand.
-}
modeAuto : Html.Attribute msg
modeAuto =
    mode auto


{-| `mode buffer` — shorthand.
-}
modeBuffer : Html.Attribute msg
modeBuffer =
    mode buffer


{-| `mode compact` — shorthand.
-}
modeCompact : Html.Attribute msg
modeCompact =
    mode compact


{-| `mode contains` — shorthand.
-}
modeContains : Html.Attribute msg
modeContains =
    mode contains


{-| `mode determinate` — shorthand.
-}
modeDeterminate : Html.Attribute msg
modeDeterminate =
    mode determinate


{-| `mode docked` — shorthand.
-}
modeDocked : Html.Attribute msg
modeDocked =
    mode docked


{-| `mode endsWith` — shorthand.
-}
modeEndsWith : Html.Attribute msg
modeEndsWith =
    mode endsWith


{-| `mode expanded` — shorthand.
-}
modeExpanded : Html.Attribute msg
modeExpanded =
    mode expanded


{-| `mode fullscreen` — shorthand.
-}
modeFullscreen : Html.Attribute msg
modeFullscreen =
    mode fullscreen


{-| `mode indeterminate` — shorthand.
-}
modeIndeterminate : Html.Attribute msg
modeIndeterminate =
    mode indeterminate


{-| `mode query` — shorthand.
-}
modeQuery : Html.Attribute msg
modeQuery =
    mode query


{-| `mode startsWith` — shorthand.
-}
modeStartsWith : Html.Attribute msg
modeStartsWith =
    mode startsWith


{-| Set the `motion` attribute to any supported value token.
-}
motion : Value values -> Html.Attribute msg
motion val_ =
    Html.Attributes.attribute "motion" (toString val_)


{-| `motion expressive` — shorthand.
-}
motionExpressive : Html.Attribute msg
motionExpressive =
    motion expressive


{-| `motion standard` — shorthand.
-}
motionStandard : Html.Attribute msg
motionStandard =
    motion standard


{-| Set the `name` attribute to any supported value token.
-}
name : Value values -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" (toString val_)


{-| `name value12SidedCookie` — shorthand.
-}
nameV12SidedCookie : Html.Attribute msg
nameV12SidedCookie =
    name value12SidedCookie


{-| `name value4LeafClover` — shorthand.
-}
nameV4LeafClover : Html.Attribute msg
nameV4LeafClover =
    name value4LeafClover


{-| `name value4SidedCookie` — shorthand.
-}
nameV4SidedCookie : Html.Attribute msg
nameV4SidedCookie =
    name value4SidedCookie


{-| `name value6SidedCookie` — shorthand.
-}
nameV6SidedCookie : Html.Attribute msg
nameV6SidedCookie =
    name value6SidedCookie


{-| `name value7SidedCookie` — shorthand.
-}
nameV7SidedCookie : Html.Attribute msg
nameV7SidedCookie =
    name value7SidedCookie


{-| `name value8LeafClover` — shorthand.
-}
nameV8LeafClover : Html.Attribute msg
nameV8LeafClover =
    name value8LeafClover


{-| `name value9SidedCookie` — shorthand.
-}
nameV9SidedCookie : Html.Attribute msg
nameV9SidedCookie =
    name value9SidedCookie


{-| `name arch` — shorthand.
-}
nameArch : Html.Attribute msg
nameArch =
    name arch


{-| `name arrow` — shorthand.
-}
nameArrow : Html.Attribute msg
nameArrow =
    name arrow


{-| `name boom` — shorthand.
-}
nameBoom : Html.Attribute msg
nameBoom =
    name boom


{-| `name bun` — shorthand.
-}
nameBun : Html.Attribute msg
nameBun =
    name bun


{-| `name burst` — shorthand.
-}
nameBurst : Html.Attribute msg
nameBurst =
    name burst


{-| `name circle` — shorthand.
-}
nameCircle : Html.Attribute msg
nameCircle =
    name circle


{-| `name diamond` — shorthand.
-}
nameDiamond : Html.Attribute msg
nameDiamond =
    name diamond


{-| `name fan` — shorthand.
-}
nameFan : Html.Attribute msg
nameFan =
    name fan


{-| `name flower` — shorthand.
-}
nameFlower : Html.Attribute msg
nameFlower =
    name flower


{-| `name gem` — shorthand.
-}
nameGem : Html.Attribute msg
nameGem =
    name gem


{-| `name ghostIsh` — shorthand.
-}
nameGhostIsh : Html.Attribute msg
nameGhostIsh =
    name ghostIsh


{-| `name heart` — shorthand.
-}
nameHeart : Html.Attribute msg
nameHeart =
    name heart


{-| `name hexagon` — shorthand.
-}
nameHexagon : Html.Attribute msg
nameHexagon =
    name hexagon


{-| `name oval` — shorthand.
-}
nameOval : Html.Attribute msg
nameOval =
    name oval


{-| `name pentagon` — shorthand.
-}
namePentagon : Html.Attribute msg
namePentagon =
    name pentagon


{-| `name pill` — shorthand.
-}
namePill : Html.Attribute msg
namePill =
    name pill


{-| `name pixelCircle` — shorthand.
-}
namePixelCircle : Html.Attribute msg
namePixelCircle =
    name pixelCircle


{-| `name pixelTriangle` — shorthand.
-}
namePixelTriangle : Html.Attribute msg
namePixelTriangle =
    name pixelTriangle


{-| `name puffy` — shorthand.
-}
namePuffy : Html.Attribute msg
namePuffy =
    name puffy


{-| `name puffyDiamond` — shorthand.
-}
namePuffyDiamond : Html.Attribute msg
namePuffyDiamond =
    name puffyDiamond


{-| `name semicircle` — shorthand.
-}
nameSemicircle : Html.Attribute msg
nameSemicircle =
    name semicircle


{-| `name slanted` — shorthand.
-}
nameSlanted : Html.Attribute msg
nameSlanted =
    name slanted


{-| `name softBoom` — shorthand.
-}
nameSoftBoom : Html.Attribute msg
nameSoftBoom =
    name softBoom


{-| `name softBurst` — shorthand.
-}
nameSoftBurst : Html.Attribute msg
nameSoftBurst =
    name softBurst


{-| `name square` — shorthand.
-}
nameSquare : Html.Attribute msg
nameSquare =
    name square


{-| `name sunny` — shorthand.
-}
nameSunny : Html.Attribute msg
nameSunny =
    name sunny


{-| `name triangle` — shorthand.
-}
nameTriangle : Html.Attribute msg
nameTriangle =
    name triangle


{-| `name verySunny` — shorthand.
-}
nameVerySunny : Html.Attribute msg
nameVerySunny =
    name verySunny


{-| Set the `orientation` attribute to any supported value token.
-}
orientation : Value values -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" (toString val_)


{-| `orientation auto` — shorthand.
-}
orientationAuto : Html.Attribute msg
orientationAuto =
    orientation auto


{-| `orientation horizontal` — shorthand.
-}
orientationHorizontal : Html.Attribute msg
orientationHorizontal =
    orientation horizontal


{-| `orientation vertical` — shorthand.
-}
orientationVertical : Html.Attribute msg
orientationVertical =
    orientation vertical


{-| Set the `page-size-variant` attribute to any supported value token.
-}
pageSizeVariant : Value values -> Html.Attribute msg
pageSizeVariant val_ =
    Html.Attributes.attribute "page-size-variant" (toString val_)


{-| `pageSizeVariant filled` — shorthand.
-}
pageSizeVariantFilled : Html.Attribute msg
pageSizeVariantFilled =
    pageSizeVariant filled


{-| `pageSizeVariant outlined` — shorthand.
-}
pageSizeVariantOutlined : Html.Attribute msg
pageSizeVariantOutlined =
    pageSizeVariant outlined


{-| Set the `position` attribute to any supported value token.
-}
position : Value values -> Html.Attribute msg
position val_ =
    Html.Attributes.attribute "position" (toString val_)


{-| `position above` — shorthand.
-}
positionAbove : Html.Attribute msg
positionAbove =
    position above


{-| `position aboveAfter` — shorthand.
-}
positionAboveAfter : Html.Attribute msg
positionAboveAfter =
    position aboveAfter


{-| `position aboveBefore` — shorthand.
-}
positionAboveBefore : Html.Attribute msg
positionAboveBefore =
    position aboveBefore


{-| `position after` — shorthand.
-}
positionAfter : Html.Attribute msg
positionAfter =
    position after


{-| `position before` — shorthand.
-}
positionBefore : Html.Attribute msg
positionBefore =
    position before


{-| `position below` — shorthand.
-}
positionBelow : Html.Attribute msg
positionBelow =
    position below


{-| `position belowAfter` — shorthand.
-}
positionBelowAfter : Html.Attribute msg
positionBelowAfter =
    position belowAfter


{-| `position belowBefore` — shorthand.
-}
positionBelowBefore : Html.Attribute msg
positionBelowBefore =
    position belowBefore


{-| Set the `position-x` attribute to any supported value token.
-}
positionX : Value values -> Html.Attribute msg
positionX val_ =
    Html.Attributes.attribute "position-x" (toString val_)


{-| `positionX after` — shorthand.
-}
positionXAfter : Html.Attribute msg
positionXAfter =
    positionX after


{-| `positionX before` — shorthand.
-}
positionXBefore : Html.Attribute msg
positionXBefore =
    positionX before


{-| Set the `position-y` attribute to any supported value token.
-}
positionY : Value values -> Html.Attribute msg
positionY val_ =
    Html.Attributes.attribute "position-y" (toString val_)


{-| `positionY above` — shorthand.
-}
positionYAbove : Html.Attribute msg
positionYAbove =
    positionY above


{-| `positionY below` — shorthand.
-}
positionYBelow : Html.Attribute msg
positionYBelow =
    positionY below


{-| Set the `scheme` attribute to any supported value token.
-}
scheme : Value values -> Html.Attribute msg
scheme val_ =
    Html.Attributes.attribute "scheme" (toString val_)


{-| `scheme auto` — shorthand.
-}
schemeAuto : Html.Attribute msg
schemeAuto =
    scheme auto


{-| `scheme dark` — shorthand.
-}
schemeDark : Html.Attribute msg
schemeDark =
    scheme dark


{-| `scheme light` — shorthand.
-}
schemeLight : Html.Attribute msg
schemeLight =
    scheme light


{-| Set the `scroll-strategy` attribute to any supported value token.
-}
scrollStrategy : Value values -> Html.Attribute msg
scrollStrategy val_ =
    Html.Attributes.attribute "scroll-strategy" (toString val_)


{-| `scrollStrategy hide` — shorthand.
-}
scrollStrategyHide : Html.Attribute msg
scrollStrategyHide =
    scrollStrategy hide


{-| `scrollStrategy reposition` — shorthand.
-}
scrollStrategyReposition : Html.Attribute msg
scrollStrategyReposition =
    scrollStrategy reposition


{-| Set the `shape` attribute to any supported value token.
-}
shape : Value values -> Html.Attribute msg
shape val_ =
    Html.Attributes.attribute "shape" (toString val_)


{-| `shape auto` — shorthand.
-}
shapeAuto : Html.Attribute msg
shapeAuto =
    shape auto


{-| `shape circular` — shorthand.
-}
shapeCircular : Html.Attribute msg
shapeCircular =
    shape circular


{-| `shape rounded` — shorthand.
-}
shapeRounded : Html.Attribute msg
shapeRounded =
    shape rounded


{-| `shape square` — shorthand.
-}
shapeSquare : Html.Attribute msg
shapeSquare =
    shape square


{-| Set the `size` attribute to any supported value token.
-}
size : Value values -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (toString val_)


{-| `size extraLarge` — shorthand.
-}
sizeExtraLarge : Html.Attribute msg
sizeExtraLarge =
    size extraLarge


{-| `size extraSmall` — shorthand.
-}
sizeExtraSmall : Html.Attribute msg
sizeExtraSmall =
    size extraSmall


{-| `size large` — shorthand.
-}
sizeLarge : Html.Attribute msg
sizeLarge =
    size large


{-| `size medium` — shorthand.
-}
sizeMedium : Html.Attribute msg
sizeMedium =
    size medium


{-| `size small` — shorthand.
-}
sizeSmall : Html.Attribute msg
sizeSmall =
    size small


{-| Set the `start-mode` attribute to any supported value token.
-}
startMode : Value values -> Html.Attribute msg
startMode val_ =
    Html.Attributes.attribute "start-mode" (toString val_)


{-| `startMode auto` — shorthand.
-}
startModeAuto : Html.Attribute msg
startModeAuto =
    startMode auto


{-| `startMode over` — shorthand.
-}
startModeOver : Html.Attribute msg
startModeOver =
    startMode over


{-| `startMode push` — shorthand.
-}
startModePush : Html.Attribute msg
startModePush =
    startMode push


{-| `startMode side` — shorthand.
-}
startModeSide : Html.Attribute msg
startModeSide =
    startMode side


{-| Set the `start-view` attribute to any supported value token.
-}
startView : Value values -> Html.Attribute msg
startView val_ =
    Html.Attributes.attribute "start-view" (toString val_)


{-| `startView month` — shorthand.
-}
startViewMonth : Html.Attribute msg
startViewMonth =
    startView month


{-| `startView multiYear` — shorthand.
-}
startViewMultiYear : Html.Attribute msg
startViewMultiYear =
    startView multiYear


{-| `startView year` — shorthand.
-}
startViewYear : Html.Attribute msg
startViewYear =
    startView year


{-| Set the `state` attribute to any supported value token.
-}
state : Value values -> Html.Attribute msg
state val_ =
    Html.Attributes.attribute "state" (toString val_)


{-| `state content` — shorthand.
-}
stateContent : Html.Attribute msg
stateContent =
    state content


{-| `state loading` — shorthand.
-}
stateLoading : Html.Attribute msg
stateLoading =
    state loading


{-| `state noData` — shorthand.
-}
stateNoData : Html.Attribute msg
stateNoData =
    state noData


{-| Set the `toggle-direction` attribute to any supported value token.
-}
toggleDirection : Value values -> Html.Attribute msg
toggleDirection val_ =
    Html.Attributes.attribute "toggle-direction" (toString val_)


{-| `toggleDirection horizontal` — shorthand.
-}
toggleDirectionHorizontal : Html.Attribute msg
toggleDirectionHorizontal =
    toggleDirection horizontal


{-| `toggleDirection vertical` — shorthand.
-}
toggleDirectionVertical : Html.Attribute msg
toggleDirectionVertical =
    toggleDirection vertical


{-| Set the `toggle-position` attribute to any supported value token.
-}
togglePosition : Value values -> Html.Attribute msg
togglePosition val_ =
    Html.Attributes.attribute "toggle-position" (toString val_)


{-| `togglePosition after` — shorthand.
-}
togglePositionAfter : Html.Attribute msg
togglePositionAfter =
    togglePosition after


{-| `togglePosition before` — shorthand.
-}
togglePositionBefore : Html.Attribute msg
togglePositionBefore =
    togglePosition before


{-| Set the `touch-gestures` attribute to any supported value token.
-}
touchGestures : Value values -> Html.Attribute msg
touchGestures val_ =
    Html.Attributes.attribute "touch-gestures" (toString val_)


{-| `touchGestures auto` — shorthand.
-}
touchGesturesAuto : Html.Attribute msg
touchGesturesAuto =
    touchGestures auto


{-| `touchGestures off` — shorthand.
-}
touchGesturesOff : Html.Attribute msg
touchGesturesOff =
    touchGestures off


{-| `touchGestures on` — shorthand.
-}
touchGesturesOn : Html.Attribute msg
touchGesturesOn =
    touchGestures on


{-| Set the `type` attribute to any supported value token.
-}
type_ : Value values -> Html.Attribute msg
type_ val_ =
    Html.Attributes.attribute "type" (toString val_)


{-| `type button` — shorthand.
-}
typeButton : Html.Attribute msg
typeButton =
    type_ button


{-| `type reset` — shorthand.
-}
typeReset : Html.Attribute msg
typeReset =
    type_ reset


{-| `type submit` — shorthand.
-}
typeSubmit : Html.Attribute msg
typeSubmit =
    type_ submit


{-| Set the `variant` attribute to any supported value token.
-}
variant : Value values -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (toString val_)


{-| `variant auto` — shorthand.
-}
variantAuto : Html.Attribute msg
variantAuto =
    variant auto


{-| `variant connected` — shorthand.
-}
variantConnected : Html.Attribute msg
variantConnected =
    variant connected


{-| `variant contained` — shorthand.
-}
variantContained : Html.Attribute msg
variantContained =
    variant contained


{-| `variant content` — shorthand.
-}
variantContent : Html.Attribute msg
variantContent =
    variant content


{-| `variant display` — shorthand.
-}
variantDisplay : Html.Attribute msg
variantDisplay =
    variant display


{-| `variant docked` — shorthand.
-}
variantDocked : Html.Attribute msg
variantDocked =
    variant docked


{-| `variant elevated` — shorthand.
-}
variantElevated : Html.Attribute msg
variantElevated =
    variant elevated


{-| `variant expressive` — shorthand.
-}
variantExpressive : Html.Attribute msg
variantExpressive =
    variant expressive


{-| `variant fidelity` — shorthand.
-}
variantFidelity : Html.Attribute msg
variantFidelity =
    variant fidelity


{-| `variant filled` — shorthand.
-}
variantFilled : Html.Attribute msg
variantFilled =
    variant filled


{-| `variant flat` — shorthand.
-}
variantFlat : Html.Attribute msg
variantFlat =
    variant flat


{-| `variant fruitSalad` — shorthand.
-}
variantFruitSalad : Html.Attribute msg
variantFruitSalad =
    variant fruitSalad


{-| `variant headline` — shorthand.
-}
variantHeadline : Html.Attribute msg
variantHeadline =
    variant headline


{-| `variant label` — shorthand.
-}
variantLabel : Html.Attribute msg
variantLabel =
    variant label


{-| `variant modal` — shorthand.
-}
variantModal : Html.Attribute msg
variantModal =
    variant modal


{-| `variant monochrome` — shorthand.
-}
variantMonochrome : Html.Attribute msg
variantMonochrome =
    variant monochrome


{-| `variant neutral` — shorthand.
-}
variantNeutral : Html.Attribute msg
variantNeutral =
    variant neutral


{-| `variant outlined` — shorthand.
-}
variantOutlined : Html.Attribute msg
variantOutlined =
    variant outlined


{-| `variant primary` — shorthand.
-}
variantPrimary : Html.Attribute msg
variantPrimary =
    variant primary


{-| `variant primaryContainer` — shorthand.
-}
variantPrimaryContainer : Html.Attribute msg
variantPrimaryContainer =
    variant primaryContainer


{-| `variant rainbow` — shorthand.
-}
variantRainbow : Html.Attribute msg
variantRainbow =
    variant rainbow


{-| `variant rounded` — shorthand.
-}
variantRounded : Html.Attribute msg
variantRounded =
    variant rounded


{-| `variant secondary` — shorthand.
-}
variantSecondary : Html.Attribute msg
variantSecondary =
    variant secondary


{-| `variant secondaryContainer` — shorthand.
-}
variantSecondaryContainer : Html.Attribute msg
variantSecondaryContainer =
    variant secondaryContainer


{-| `variant segmented` — shorthand.
-}
variantSegmented : Html.Attribute msg
variantSegmented =
    variant segmented


{-| `variant sharp` — shorthand.
-}
variantSharp : Html.Attribute msg
variantSharp =
    variant sharp


{-| `variant standard` — shorthand.
-}
variantStandard : Html.Attribute msg
variantStandard =
    variant standard


{-| `variant surface` — shorthand.
-}
variantSurface : Html.Attribute msg
variantSurface =
    variant surface


{-| `variant tertiary` — shorthand.
-}
variantTertiary : Html.Attribute msg
variantTertiary =
    variant tertiary


{-| `variant tertiaryContainer` — shorthand.
-}
variantTertiaryContainer : Html.Attribute msg
variantTertiaryContainer =
    variant tertiaryContainer


{-| `variant text` — shorthand.
-}
variantText : Html.Attribute msg
variantText =
    variant text


{-| `variant title` — shorthand.
-}
variantTitle : Html.Attribute msg
variantTitle =
    variant title


{-| `variant tonal` — shorthand.
-}
variantTonal : Html.Attribute msg
variantTonal =
    variant tonal


{-| `variant tonalSpot` — shorthand.
-}
variantTonalSpot : Html.Attribute msg
variantTonalSpot =
    variant tonalSpot


{-| `variant uncontained` — shorthand.
-}
variantUncontained : Html.Attribute msg
variantUncontained =
    variant uncontained


{-| `variant vibrant` — shorthand.
-}
variantVibrant : Html.Attribute msg
variantVibrant =
    variant vibrant


{-| `variant wavy` — shorthand.
-}
variantWavy : Html.Attribute msg
variantWavy =
    variant wavy


{-| Set the `width` attribute to any supported value token.
-}
width : Value values -> Html.Attribute msg
width val_ =
    Html.Attributes.attribute "width" (toString val_)


{-| `width default` — shorthand.
-}
widthDefault : Html.Attribute msg
widthDefault =
    width default


{-| `width narrow` — shorthand.
-}
widthNarrow : Html.Attribute msg
widthNarrow =
    width narrow


{-| `width wide` — shorthand.
-}
widthWide : Html.Attribute msg
widthWide =
    width wide


{-| The active date. (default: `new Date()`)
-}
activeDate : String -> Html.Attribute msg
activeDate val_ =
    Html.Attributes.attribute "active-date" val_


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset : Float -> Html.Attribute msg
anchorOffset val_ =
    Html.Attributes.property "anchor-offset" (Json.Encode.float val_)


{-| Whether filtering is case sensitive. (default: `false`)
-}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "case-sensitive" (Json.Encode.bool val_)


{-| Whether the title and subtitle are centered. (default: `false`)
-}
centered : Bool -> Html.Attribute msg
centered val_ =
    Html.Attributes.property "centered" (Json.Encode.bool val_)


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Html.Attribute msg
clearLabel val_ =
    Html.Attributes.attribute "clear-label" val_


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    Html.Attributes.property "clearable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel : String -> Html.Attribute msg
closeLabel val_ =
    Html.Attributes.attribute "close-label" val_


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
color : String -> Html.Attribute msg
color val_ =
    Html.Attributes.attribute "color" val_


{-| The selected date. (default: `null`)
-}
dateAttr : String -> Html.Attribute msg
dateAttr val_ =
    Html.Attributes.attribute "date" val_


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Whether the user has modified the value of the element.
-}
dirty : Bool -> Html.Attribute msg
dirty val_ =
    Html.Attributes.property "dirty" (Json.Encode.bool val_)


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabled-interactive" (Json.Encode.bool val_)


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    Html.Attributes.property "dismissible" (Json.Encode.bool val_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth : Bool -> Html.Attribute msg
fitAnchorWidth val_ =
    Html.Attributes.property "fit-anchor-width" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| Whether the item has child items.
-}
haschilditems : Bool -> Html.Attribute msg
haschilditems val_ =
    Html.Attributes.property "hasChildItems" (Json.Encode.bool val_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hide-delay" (Json.Encode.float val_)


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hide-selection-indicator" (Json.Encode.bool val_)


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hide-toggle" (Json.Encode.bool val_)


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminateAttr : Bool -> Html.Attribute msg
indeterminateAttr val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| Whether a dark theme is applied.
-}
isdark : Bool -> Html.Attribute msg
isdark val_ =
    Html.Attributes.property "isDark" (Json.Encode.bool val_)


{-| Whether the tooltip is currently open.
-}
isopen : Bool -> Html.Attribute msg
isopen val_ =
    Html.Attributes.property "isOpen" (Json.Encode.bool val_)


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
labelAttr : String -> Html.Attribute msg
labelAttr val_ =
    Html.Attributes.attribute "label" val_


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
minAttr : Float -> Html.Attribute msg
minAttr val_ =
    Html.Attributes.property "min" (Json.Encode.float val_)


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel val_ =
    Html.Attributes.attribute "next-month-label" val_


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel val_ =
    Html.Attributes.attribute "next-multi-year-label" val_


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel val_ =
    Html.Attributes.attribute "next-page-label" val_


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel val_ =
    Html.Attributes.attribute "next-year-label" val_


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.property "overshoot-limit" (Json.Encode.float val_)


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
panelClass : String -> Html.Attribute msg
panelClass val_ =
    Html.Attributes.attribute "panel-class" val_


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel val_ =
    Html.Attributes.attribute "previous-month-label" val_


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel val_ =
    Html.Attributes.attribute "previous-multi-year-label" val_


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel val_ =
    Html.Attributes.attribute "previous-page-label" val_


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel val_ =
    Html.Attributes.attribute "previous-year-label" val_


{-| Whether the user has not modified the value of the element.
-}
pristine : Bool -> Html.Attribute msg
pristine val_ =
    Html.Attributes.property "pristine" (Json.Encode.bool val_)


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Html.Attribute msg
rangeEnd val_ =
    Html.Attributes.attribute "range-end" val_


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Html.Attribute msg
rangeStart val_ =
    Html.Attributes.attribute "range-start" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| Whether the item is selected. (default: `false`)
-}
selectedAttr : Bool -> Html.Attribute msg
selectedAttr =
    Html.Attributes.selected


{-| The zero-based index of the selected tab.
-}
selectedindex : Float -> Html.Attribute msg
selectedindex val_ =
    Html.Attributes.property "selectedIndex" (Json.Encode.float val_)


{-| Set the `shouldLabelFloat` property.
-}
shouldlabelfloat : Bool -> Html.Attribute msg
shouldlabelfloat val_ =
    Html.Attributes.property "shouldLabelFloat" (Json.Encode.bool val_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "show-delay" (Json.Encode.float val_)


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
stepAttr : Float -> Html.Attribute msg
stepAttr val_ =
    Html.Attributes.property "step" (Json.Encode.float val_)


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| The search term to highlight. (default: `""`)
-}
term : String -> Html.Attribute msg
term val_ =
    Html.Attributes.attribute "term" val_


{-| Today's date. (default: `new Date()`)
-}
today : String -> Html.Attribute msg
today val_ =
    Html.Attributes.attribute "today" val_


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
toggle : Bool -> Html.Attribute msg
toggle val_ =
    Html.Attributes.property "toggle" (Json.Encode.bool val_)


{-| Whether the user has interacted when the element.
-}
touched : Bool -> Html.Attribute msg
touched val_ =
    Html.Attributes.property "touched" (Json.Encode.bool val_)


{-| Whether the user has not interacted when the element.
-}
untouched : Bool -> Html.Attribute msg
untouched val_ =
    Html.Attributes.property "untouched" (Json.Encode.bool val_)


{-| The error message that would be displayed if the user submits the form, or an empty string if no error message.
-}
validationmessage : String -> Html.Attribute msg
validationmessage val_ =
    Html.Attributes.property "validationMessage" (Json.Encode.string val_)


{-| Whether the element is oriented vertically. (default: `false`)
-}
verticalAttr : Bool -> Html.Attribute msg
verticalAttr val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)


{-| Whether the item is visible.
-}
visible : Bool -> Html.Attribute msg
visible val_ =
    Html.Attributes.property "visible" (Json.Encode.bool val_)


{-| Whether the element is a submittable element that is a candidate for constraint validation.
-}
willvalidate : Bool -> Html.Attribute msg
willvalidate val_ =
    Html.Attributes.property "willValidate" (Json.Encode.bool val_)
