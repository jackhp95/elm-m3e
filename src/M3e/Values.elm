module M3e.Values exposing
    ( Animation, Contrast, Current, Dividers, EndMode, Filter, FloatLabel, Grade, HeaderPosition, HideSubscript, HighlightMode, Icons, LabelPosition, Mode, Motion, Name, Orientation, PageSizeVariant, Position, PositionX, PositionY, Scheme, ScrollStrategy, Shape, Size, StartMode, StartView, State, ToggleDirection, TogglePosition, TouchGestures, Type, Variant, Width
    , value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, above, aboveAfter, aboveBefore, aboveBelow, after, always, arch, arrow, auto, before, below, belowAfter, belowBefore, boom, both, buffer, bun, burst, button, circle, circular, compact, connected, contained, contains, content, dark, date, default, determinate, diamond, display, docked, elevated, end, endsWith, expanded, expressive, extraLarge, extraSmall, fan, fidelity, filled, flat, flower, fruitSalad, fullscreen, gem, ghostIsh, headline, heart, hexagon, hide, high, horizontal, indeterminate, label, large, light, loading, location, low, medium, modal, monochrome, month, multiYear, narrow, neutral, never, noData, none, off, on, outlined, oval, over, page, pentagon, pill, pixelCircle, pixelTriangle, primary, primaryContainer, puffy, puffyDiamond, pulse, push, query, rainbow, reposition, reset, rounded, secondary, secondaryContainer, segmented, selected, semicircle, sharp, side, slanted, small, softBoom, softBurst, square, standard, startsWith, step, submit, sunny, surface, tertiary, tertiaryContainer, text, time, title, tonal, tonalSpot, triangle, true, uncontained, vertical, verySunny, vibrant, wave, wavy, wide, year
    , animationNone, animationPulse, animationWave, contrastHigh, contrastMedium, contrastStandard, currentDate, currentLocation, currentPage, currentStep, currentTime, currentTrue, dividersAbove, dividersAboveBelow, dividersBelow, dividersNone, endModeAuto, endModeOver, endModePush, endModeSide, filterContains, filterEndsWith, filterNone, filterStartsWith, floatLabelAlways, floatLabelAuto, gradeHigh, gradeLow, gradeMedium, headerPositionAbove, headerPositionAfter, headerPositionBefore, headerPositionBelow, hideSubscriptAlways, hideSubscriptAuto, hideSubscriptNever, highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, iconsBoth, iconsNone, iconsSelected, labelPositionBelow, labelPositionEnd, modeAuto, modeBuffer, modeCompact, modeContains, modeDeterminate, modeDocked, modeEndsWith, modeExpanded, modeFullscreen, modeIndeterminate, modeQuery, modeStartsWith, motionExpressive, motionStandard, nameValue12SidedCookie, nameValue4LeafClover, nameValue4SidedCookie, nameValue6SidedCookie, nameValue7SidedCookie, nameValue8LeafClover, nameValue9SidedCookie, nameArch, nameArrow, nameBoom, nameBun, nameBurst, nameCircle, nameDiamond, nameFan, nameFlower, nameGem, nameGhostIsh, nameHeart, nameHexagon, nameOval, namePentagon, namePill, namePixelCircle, namePixelTriangle, namePuffy, namePuffyDiamond, nameSemicircle, nameSlanted, nameSoftBoom, nameSoftBurst, nameSquare, nameSunny, nameTriangle, nameVerySunny, orientationAuto, orientationHorizontal, orientationVertical, pageSizeVariantFilled, pageSizeVariantOutlined, positionAbove, positionAboveAfter, positionAboveBefore, positionAfter, positionBefore, positionBelow, positionBelowAfter, positionBelowBefore, positionXAfter, positionXBefore, positionYAbove, positionYBelow, schemeAuto, schemeDark, schemeLight, scrollStrategyHide, scrollStrategyReposition, shapeAuto, shapeCircular, shapeRounded, shapeSquare, sizeExtraLarge, sizeExtraSmall, sizeLarge, sizeMedium, sizeSmall, startModeAuto, startModeOver, startModePush, startModeSide, startViewMonth, startViewMultiYear, startViewYear, stateContent, stateLoading, stateNoData, toggleDirectionHorizontal, toggleDirectionVertical, togglePositionAfter, togglePositionBefore, touchGesturesAuto, touchGesturesOff, touchGesturesOn, type_Button, type_Reset, type_Submit, variantAuto, variantConnected, variantContained, variantContent, variantDisplay, variantDocked, variantElevated, variantExpressive, variantFidelity, variantFilled, variantFlat, variantFruitSalad, variantHeadline, variantLabel, variantModal, variantMonochrome, variantNeutral, variantOutlined, variantPrimary, variantPrimaryContainer, variantRainbow, variantRounded, variantSecondary, variantSecondaryContainer, variantSegmented, variantSharp, variantStandard, variantSurface, variantTertiary, variantTertiaryContainer, variantText, variantTitle, variantTonal, variantTonalSpot, variantUncontained, variantVibrant, variantWavy, widthDefault, widthNarrow, widthWide
    )

{-| The enum-value vocabulary: every token minted once (open row), plus the
library-wide union row per enum attribute, plus attribute-prefixed
portmanteaus (`variantFilled`, `shapeRounded`, …) for IDE discovery.
General setters close over the union; per-component setters narrow — both
are fed by these same tokens.

@docs Animation, Contrast, Current, Dividers, EndMode, Filter, FloatLabel, Grade, HeaderPosition, HideSubscript, HighlightMode, Icons, LabelPosition, Mode, Motion, Name, Orientation, PageSizeVariant, Position, PositionX, PositionY, Scheme, ScrollStrategy, Shape, Size, StartMode, StartView, State, ToggleDirection, TogglePosition, TouchGestures, Type, Variant, Width
@docs value12SidedCookie, value4LeafClover, value4SidedCookie, value6SidedCookie, value7SidedCookie, value8LeafClover, value9SidedCookie, above, aboveAfter, aboveBefore, aboveBelow, after, always, arch, arrow, auto, before, below, belowAfter, belowBefore, boom, both, buffer, bun, burst, button, circle, circular, compact, connected, contained, contains, content, dark, date, default, determinate, diamond, display, docked, elevated, end, endsWith, expanded, expressive, extraLarge, extraSmall, fan, fidelity, filled, flat, flower, fruitSalad, fullscreen, gem, ghostIsh, headline, heart, hexagon, hide, high, horizontal, indeterminate, label, large, light, loading, location, low, medium, modal, monochrome, month, multiYear, narrow, neutral, never, noData, none, off, on, outlined, oval, over, page, pentagon, pill, pixelCircle, pixelTriangle, primary, primaryContainer, puffy, puffyDiamond, pulse, push, query, rainbow, reposition, reset, rounded, secondary, secondaryContainer, segmented, selected, semicircle, sharp, side, slanted, small, softBoom, softBurst, square, standard, startsWith, step, submit, sunny, surface, tertiary, tertiaryContainer, text, time, title, tonal, tonalSpot, triangle, true, uncontained, vertical, verySunny, vibrant, wave, wavy, wide, year
@docs animationNone, animationPulse, animationWave, contrastHigh, contrastMedium, contrastStandard, currentDate, currentLocation, currentPage, currentStep, currentTime, currentTrue, dividersAbove, dividersAboveBelow, dividersBelow, dividersNone, endModeAuto, endModeOver, endModePush, endModeSide, filterContains, filterEndsWith, filterNone, filterStartsWith, floatLabelAlways, floatLabelAuto, gradeHigh, gradeLow, gradeMedium, headerPositionAbove, headerPositionAfter, headerPositionBefore, headerPositionBelow, hideSubscriptAlways, hideSubscriptAuto, hideSubscriptNever, highlightModeContains, highlightModeEndsWith, highlightModeStartsWith, iconsBoth, iconsNone, iconsSelected, labelPositionBelow, labelPositionEnd, modeAuto, modeBuffer, modeCompact, modeContains, modeDeterminate, modeDocked, modeEndsWith, modeExpanded, modeFullscreen, modeIndeterminate, modeQuery, modeStartsWith, motionExpressive, motionStandard, nameValue12SidedCookie, nameValue4LeafClover, nameValue4SidedCookie, nameValue6SidedCookie, nameValue7SidedCookie, nameValue8LeafClover, nameValue9SidedCookie, nameArch, nameArrow, nameBoom, nameBun, nameBurst, nameCircle, nameDiamond, nameFan, nameFlower, nameGem, nameGhostIsh, nameHeart, nameHexagon, nameOval, namePentagon, namePill, namePixelCircle, namePixelTriangle, namePuffy, namePuffyDiamond, nameSemicircle, nameSlanted, nameSoftBoom, nameSoftBurst, nameSquare, nameSunny, nameTriangle, nameVerySunny, orientationAuto, orientationHorizontal, orientationVertical, pageSizeVariantFilled, pageSizeVariantOutlined, positionAbove, positionAboveAfter, positionAboveBefore, positionAfter, positionBefore, positionBelow, positionBelowAfter, positionBelowBefore, positionXAfter, positionXBefore, positionYAbove, positionYBelow, schemeAuto, schemeDark, schemeLight, scrollStrategyHide, scrollStrategyReposition, shapeAuto, shapeCircular, shapeRounded, shapeSquare, sizeExtraLarge, sizeExtraSmall, sizeLarge, sizeMedium, sizeSmall, startModeAuto, startModeOver, startModePush, startModeSide, startViewMonth, startViewMultiYear, startViewYear, stateContent, stateLoading, stateNoData, toggleDirectionHorizontal, toggleDirectionVertical, togglePositionAfter, togglePositionBefore, touchGesturesAuto, touchGesturesOff, touchGesturesOn, type_Button, type_Reset, type_Submit, variantAuto, variantConnected, variantContained, variantContent, variantDisplay, variantDocked, variantElevated, variantExpressive, variantFidelity, variantFilled, variantFlat, variantFruitSalad, variantHeadline, variantLabel, variantModal, variantMonochrome, variantNeutral, variantOutlined, variantPrimary, variantPrimaryContainer, variantRainbow, variantRounded, variantSecondary, variantSecondaryContainer, variantSegmented, variantSharp, variantStandard, variantSurface, variantTertiary, variantTertiaryContainer, variantText, variantTitle, variantTonal, variantTonalSpot, variantUncontained, variantVibrant, variantWavy, widthDefault, widthNarrow, widthWide

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


{-| The `none` value of the `animation` enum — same open row as `none`, prefixed for discovery.
-}
animationNone : Value { v | none : Supported }
animationNone =
    Ir.token "none"


{-| The `pulse` value of the `animation` enum — same open row as `pulse`, prefixed for discovery.
-}
animationPulse : Value { v | pulse : Supported }
animationPulse =
    Ir.token "pulse"


{-| The `wave` value of the `animation` enum — same open row as `wave`, prefixed for discovery.
-}
animationWave : Value { v | wave : Supported }
animationWave =
    Ir.token "wave"


{-| The `high` value of the `contrast` enum — same open row as `high`, prefixed for discovery.
-}
contrastHigh : Value { v | high : Supported }
contrastHigh =
    Ir.token "high"


{-| The `medium` value of the `contrast` enum — same open row as `medium`, prefixed for discovery.
-}
contrastMedium : Value { v | medium : Supported }
contrastMedium =
    Ir.token "medium"


{-| The `standard` value of the `contrast` enum — same open row as `standard`, prefixed for discovery.
-}
contrastStandard : Value { v | standard : Supported }
contrastStandard =
    Ir.token "standard"


{-| The `date` value of the `current` enum — same open row as `date`, prefixed for discovery.
-}
currentDate : Value { v | date : Supported }
currentDate =
    Ir.token "date"


{-| The `location` value of the `current` enum — same open row as `location`, prefixed for discovery.
-}
currentLocation : Value { v | location : Supported }
currentLocation =
    Ir.token "location"


{-| The `page` value of the `current` enum — same open row as `page`, prefixed for discovery.
-}
currentPage : Value { v | page : Supported }
currentPage =
    Ir.token "page"


{-| The `step` value of the `current` enum — same open row as `step`, prefixed for discovery.
-}
currentStep : Value { v | step : Supported }
currentStep =
    Ir.token "step"


{-| The `time` value of the `current` enum — same open row as `time`, prefixed for discovery.
-}
currentTime : Value { v | time : Supported }
currentTime =
    Ir.token "time"


{-| The `true` value of the `current` enum — same open row as `true`, prefixed for discovery.
-}
currentTrue : Value { v | true : Supported }
currentTrue =
    Ir.token "true"


{-| The `above` value of the `dividers` enum — same open row as `above`, prefixed for discovery.
-}
dividersAbove : Value { v | above : Supported }
dividersAbove =
    Ir.token "above"


{-| The `above-below` value of the `dividers` enum — same open row as `aboveBelow`, prefixed for discovery.
-}
dividersAboveBelow : Value { v | aboveBelow : Supported }
dividersAboveBelow =
    Ir.token "above-below"


{-| The `below` value of the `dividers` enum — same open row as `below`, prefixed for discovery.
-}
dividersBelow : Value { v | below : Supported }
dividersBelow =
    Ir.token "below"


{-| The `none` value of the `dividers` enum — same open row as `none`, prefixed for discovery.
-}
dividersNone : Value { v | none : Supported }
dividersNone =
    Ir.token "none"


{-| The `auto` value of the `endMode` enum — same open row as `auto`, prefixed for discovery.
-}
endModeAuto : Value { v | auto : Supported }
endModeAuto =
    Ir.token "auto"


{-| The `over` value of the `endMode` enum — same open row as `over`, prefixed for discovery.
-}
endModeOver : Value { v | over : Supported }
endModeOver =
    Ir.token "over"


{-| The `push` value of the `endMode` enum — same open row as `push`, prefixed for discovery.
-}
endModePush : Value { v | push : Supported }
endModePush =
    Ir.token "push"


{-| The `side` value of the `endMode` enum — same open row as `side`, prefixed for discovery.
-}
endModeSide : Value { v | side : Supported }
endModeSide =
    Ir.token "side"


{-| The `contains` value of the `filter` enum — same open row as `contains`, prefixed for discovery.
-}
filterContains : Value { v | contains : Supported }
filterContains =
    Ir.token "contains"


{-| The `ends-with` value of the `filter` enum — same open row as `endsWith`, prefixed for discovery.
-}
filterEndsWith : Value { v | endsWith : Supported }
filterEndsWith =
    Ir.token "ends-with"


{-| The `none` value of the `filter` enum — same open row as `none`, prefixed for discovery.
-}
filterNone : Value { v | none : Supported }
filterNone =
    Ir.token "none"


{-| The `starts-with` value of the `filter` enum — same open row as `startsWith`, prefixed for discovery.
-}
filterStartsWith : Value { v | startsWith : Supported }
filterStartsWith =
    Ir.token "starts-with"


{-| The `always` value of the `floatLabel` enum — same open row as `always`, prefixed for discovery.
-}
floatLabelAlways : Value { v | always : Supported }
floatLabelAlways =
    Ir.token "always"


{-| The `auto` value of the `floatLabel` enum — same open row as `auto`, prefixed for discovery.
-}
floatLabelAuto : Value { v | auto : Supported }
floatLabelAuto =
    Ir.token "auto"


{-| The `high` value of the `grade` enum — same open row as `high`, prefixed for discovery.
-}
gradeHigh : Value { v | high : Supported }
gradeHigh =
    Ir.token "high"


{-| The `low` value of the `grade` enum — same open row as `low`, prefixed for discovery.
-}
gradeLow : Value { v | low : Supported }
gradeLow =
    Ir.token "low"


{-| The `medium` value of the `grade` enum — same open row as `medium`, prefixed for discovery.
-}
gradeMedium : Value { v | medium : Supported }
gradeMedium =
    Ir.token "medium"


{-| The `above` value of the `headerPosition` enum — same open row as `above`, prefixed for discovery.
-}
headerPositionAbove : Value { v | above : Supported }
headerPositionAbove =
    Ir.token "above"


{-| The `after` value of the `headerPosition` enum — same open row as `after`, prefixed for discovery.
-}
headerPositionAfter : Value { v | after : Supported }
headerPositionAfter =
    Ir.token "after"


{-| The `before` value of the `headerPosition` enum — same open row as `before`, prefixed for discovery.
-}
headerPositionBefore : Value { v | before : Supported }
headerPositionBefore =
    Ir.token "before"


{-| The `below` value of the `headerPosition` enum — same open row as `below`, prefixed for discovery.
-}
headerPositionBelow : Value { v | below : Supported }
headerPositionBelow =
    Ir.token "below"


{-| The `always` value of the `hideSubscript` enum — same open row as `always`, prefixed for discovery.
-}
hideSubscriptAlways : Value { v | always : Supported }
hideSubscriptAlways =
    Ir.token "always"


{-| The `auto` value of the `hideSubscript` enum — same open row as `auto`, prefixed for discovery.
-}
hideSubscriptAuto : Value { v | auto : Supported }
hideSubscriptAuto =
    Ir.token "auto"


{-| The `never` value of the `hideSubscript` enum — same open row as `never`, prefixed for discovery.
-}
hideSubscriptNever : Value { v | never : Supported }
hideSubscriptNever =
    Ir.token "never"


{-| The `contains` value of the `highlightMode` enum — same open row as `contains`, prefixed for discovery.
-}
highlightModeContains : Value { v | contains : Supported }
highlightModeContains =
    Ir.token "contains"


{-| The `ends-with` value of the `highlightMode` enum — same open row as `endsWith`, prefixed for discovery.
-}
highlightModeEndsWith : Value { v | endsWith : Supported }
highlightModeEndsWith =
    Ir.token "ends-with"


{-| The `starts-with` value of the `highlightMode` enum — same open row as `startsWith`, prefixed for discovery.
-}
highlightModeStartsWith : Value { v | startsWith : Supported }
highlightModeStartsWith =
    Ir.token "starts-with"


{-| The `both` value of the `icons` enum — same open row as `both`, prefixed for discovery.
-}
iconsBoth : Value { v | both : Supported }
iconsBoth =
    Ir.token "both"


{-| The `none` value of the `icons` enum — same open row as `none`, prefixed for discovery.
-}
iconsNone : Value { v | none : Supported }
iconsNone =
    Ir.token "none"


{-| The `selected` value of the `icons` enum — same open row as `selected`, prefixed for discovery.
-}
iconsSelected : Value { v | selected : Supported }
iconsSelected =
    Ir.token "selected"


{-| The `below` value of the `labelPosition` enum — same open row as `below`, prefixed for discovery.
-}
labelPositionBelow : Value { v | below : Supported }
labelPositionBelow =
    Ir.token "below"


{-| The `end` value of the `labelPosition` enum — same open row as `end`, prefixed for discovery.
-}
labelPositionEnd : Value { v | end : Supported }
labelPositionEnd =
    Ir.token "end"


{-| The `auto` value of the `mode` enum — same open row as `auto`, prefixed for discovery.
-}
modeAuto : Value { v | auto : Supported }
modeAuto =
    Ir.token "auto"


{-| The `buffer` value of the `mode` enum — same open row as `buffer`, prefixed for discovery.
-}
modeBuffer : Value { v | buffer : Supported }
modeBuffer =
    Ir.token "buffer"


{-| The `compact` value of the `mode` enum — same open row as `compact`, prefixed for discovery.
-}
modeCompact : Value { v | compact : Supported }
modeCompact =
    Ir.token "compact"


{-| The `contains` value of the `mode` enum — same open row as `contains`, prefixed for discovery.
-}
modeContains : Value { v | contains : Supported }
modeContains =
    Ir.token "contains"


{-| The `determinate` value of the `mode` enum — same open row as `determinate`, prefixed for discovery.
-}
modeDeterminate : Value { v | determinate : Supported }
modeDeterminate =
    Ir.token "determinate"


{-| The `docked` value of the `mode` enum — same open row as `docked`, prefixed for discovery.
-}
modeDocked : Value { v | docked : Supported }
modeDocked =
    Ir.token "docked"


{-| The `ends-with` value of the `mode` enum — same open row as `endsWith`, prefixed for discovery.
-}
modeEndsWith : Value { v | endsWith : Supported }
modeEndsWith =
    Ir.token "ends-with"


{-| The `expanded` value of the `mode` enum — same open row as `expanded`, prefixed for discovery.
-}
modeExpanded : Value { v | expanded : Supported }
modeExpanded =
    Ir.token "expanded"


{-| The `fullscreen` value of the `mode` enum — same open row as `fullscreen`, prefixed for discovery.
-}
modeFullscreen : Value { v | fullscreen : Supported }
modeFullscreen =
    Ir.token "fullscreen"


{-| The `indeterminate` value of the `mode` enum — same open row as `indeterminate`, prefixed for discovery.
-}
modeIndeterminate : Value { v | indeterminate : Supported }
modeIndeterminate =
    Ir.token "indeterminate"


{-| The `query` value of the `mode` enum — same open row as `query`, prefixed for discovery.
-}
modeQuery : Value { v | query : Supported }
modeQuery =
    Ir.token "query"


{-| The `starts-with` value of the `mode` enum — same open row as `startsWith`, prefixed for discovery.
-}
modeStartsWith : Value { v | startsWith : Supported }
modeStartsWith =
    Ir.token "starts-with"


{-| The `expressive` value of the `motion` enum — same open row as `expressive`, prefixed for discovery.
-}
motionExpressive : Value { v | expressive : Supported }
motionExpressive =
    Ir.token "expressive"


{-| The `standard` value of the `motion` enum — same open row as `standard`, prefixed for discovery.
-}
motionStandard : Value { v | standard : Supported }
motionStandard =
    Ir.token "standard"


{-| The `12-sided-cookie` value of the `name` enum — same open row as `value12SidedCookie`, prefixed for discovery.
-}
nameValue12SidedCookie : Value { v | value12SidedCookie : Supported }
nameValue12SidedCookie =
    Ir.token "12-sided-cookie"


{-| The `4-leaf-clover` value of the `name` enum — same open row as `value4LeafClover`, prefixed for discovery.
-}
nameValue4LeafClover : Value { v | value4LeafClover : Supported }
nameValue4LeafClover =
    Ir.token "4-leaf-clover"


{-| The `4-sided-cookie` value of the `name` enum — same open row as `value4SidedCookie`, prefixed for discovery.
-}
nameValue4SidedCookie : Value { v | value4SidedCookie : Supported }
nameValue4SidedCookie =
    Ir.token "4-sided-cookie"


{-| The `6-sided-cookie` value of the `name` enum — same open row as `value6SidedCookie`, prefixed for discovery.
-}
nameValue6SidedCookie : Value { v | value6SidedCookie : Supported }
nameValue6SidedCookie =
    Ir.token "6-sided-cookie"


{-| The `7-sided-cookie` value of the `name` enum — same open row as `value7SidedCookie`, prefixed for discovery.
-}
nameValue7SidedCookie : Value { v | value7SidedCookie : Supported }
nameValue7SidedCookie =
    Ir.token "7-sided-cookie"


{-| The `8-leaf-clover` value of the `name` enum — same open row as `value8LeafClover`, prefixed for discovery.
-}
nameValue8LeafClover : Value { v | value8LeafClover : Supported }
nameValue8LeafClover =
    Ir.token "8-leaf-clover"


{-| The `9-sided-cookie` value of the `name` enum — same open row as `value9SidedCookie`, prefixed for discovery.
-}
nameValue9SidedCookie : Value { v | value9SidedCookie : Supported }
nameValue9SidedCookie =
    Ir.token "9-sided-cookie"


{-| The `arch` value of the `name` enum — same open row as `arch`, prefixed for discovery.
-}
nameArch : Value { v | arch : Supported }
nameArch =
    Ir.token "arch"


{-| The `arrow` value of the `name` enum — same open row as `arrow`, prefixed for discovery.
-}
nameArrow : Value { v | arrow : Supported }
nameArrow =
    Ir.token "arrow"


{-| The `boom` value of the `name` enum — same open row as `boom`, prefixed for discovery.
-}
nameBoom : Value { v | boom : Supported }
nameBoom =
    Ir.token "boom"


{-| The `bun` value of the `name` enum — same open row as `bun`, prefixed for discovery.
-}
nameBun : Value { v | bun : Supported }
nameBun =
    Ir.token "bun"


{-| The `burst` value of the `name` enum — same open row as `burst`, prefixed for discovery.
-}
nameBurst : Value { v | burst : Supported }
nameBurst =
    Ir.token "burst"


{-| The `circle` value of the `name` enum — same open row as `circle`, prefixed for discovery.
-}
nameCircle : Value { v | circle : Supported }
nameCircle =
    Ir.token "circle"


{-| The `diamond` value of the `name` enum — same open row as `diamond`, prefixed for discovery.
-}
nameDiamond : Value { v | diamond : Supported }
nameDiamond =
    Ir.token "diamond"


{-| The `fan` value of the `name` enum — same open row as `fan`, prefixed for discovery.
-}
nameFan : Value { v | fan : Supported }
nameFan =
    Ir.token "fan"


{-| The `flower` value of the `name` enum — same open row as `flower`, prefixed for discovery.
-}
nameFlower : Value { v | flower : Supported }
nameFlower =
    Ir.token "flower"


{-| The `gem` value of the `name` enum — same open row as `gem`, prefixed for discovery.
-}
nameGem : Value { v | gem : Supported }
nameGem =
    Ir.token "gem"


{-| The `ghost-ish` value of the `name` enum — same open row as `ghostIsh`, prefixed for discovery.
-}
nameGhostIsh : Value { v | ghostIsh : Supported }
nameGhostIsh =
    Ir.token "ghost-ish"


{-| The `heart` value of the `name` enum — same open row as `heart`, prefixed for discovery.
-}
nameHeart : Value { v | heart : Supported }
nameHeart =
    Ir.token "heart"


{-| The `hexagon` value of the `name` enum — same open row as `hexagon`, prefixed for discovery.
-}
nameHexagon : Value { v | hexagon : Supported }
nameHexagon =
    Ir.token "hexagon"


{-| The `oval` value of the `name` enum — same open row as `oval`, prefixed for discovery.
-}
nameOval : Value { v | oval : Supported }
nameOval =
    Ir.token "oval"


{-| The `pentagon` value of the `name` enum — same open row as `pentagon`, prefixed for discovery.
-}
namePentagon : Value { v | pentagon : Supported }
namePentagon =
    Ir.token "pentagon"


{-| The `pill` value of the `name` enum — same open row as `pill`, prefixed for discovery.
-}
namePill : Value { v | pill : Supported }
namePill =
    Ir.token "pill"


{-| The `pixel-circle` value of the `name` enum — same open row as `pixelCircle`, prefixed for discovery.
-}
namePixelCircle : Value { v | pixelCircle : Supported }
namePixelCircle =
    Ir.token "pixel-circle"


{-| The `pixel-triangle` value of the `name` enum — same open row as `pixelTriangle`, prefixed for discovery.
-}
namePixelTriangle : Value { v | pixelTriangle : Supported }
namePixelTriangle =
    Ir.token "pixel-triangle"


{-| The `puffy` value of the `name` enum — same open row as `puffy`, prefixed for discovery.
-}
namePuffy : Value { v | puffy : Supported }
namePuffy =
    Ir.token "puffy"


{-| The `puffy-diamond` value of the `name` enum — same open row as `puffyDiamond`, prefixed for discovery.
-}
namePuffyDiamond : Value { v | puffyDiamond : Supported }
namePuffyDiamond =
    Ir.token "puffy-diamond"


{-| The `semicircle` value of the `name` enum — same open row as `semicircle`, prefixed for discovery.
-}
nameSemicircle : Value { v | semicircle : Supported }
nameSemicircle =
    Ir.token "semicircle"


{-| The `slanted` value of the `name` enum — same open row as `slanted`, prefixed for discovery.
-}
nameSlanted : Value { v | slanted : Supported }
nameSlanted =
    Ir.token "slanted"


{-| The `soft-boom` value of the `name` enum — same open row as `softBoom`, prefixed for discovery.
-}
nameSoftBoom : Value { v | softBoom : Supported }
nameSoftBoom =
    Ir.token "soft-boom"


{-| The `soft-burst` value of the `name` enum — same open row as `softBurst`, prefixed for discovery.
-}
nameSoftBurst : Value { v | softBurst : Supported }
nameSoftBurst =
    Ir.token "soft-burst"


{-| The `square` value of the `name` enum — same open row as `square`, prefixed for discovery.
-}
nameSquare : Value { v | square : Supported }
nameSquare =
    Ir.token "square"


{-| The `sunny` value of the `name` enum — same open row as `sunny`, prefixed for discovery.
-}
nameSunny : Value { v | sunny : Supported }
nameSunny =
    Ir.token "sunny"


{-| The `triangle` value of the `name` enum — same open row as `triangle`, prefixed for discovery.
-}
nameTriangle : Value { v | triangle : Supported }
nameTriangle =
    Ir.token "triangle"


{-| The `very-sunny` value of the `name` enum — same open row as `verySunny`, prefixed for discovery.
-}
nameVerySunny : Value { v | verySunny : Supported }
nameVerySunny =
    Ir.token "very-sunny"


{-| The `auto` value of the `orientation` enum — same open row as `auto`, prefixed for discovery.
-}
orientationAuto : Value { v | auto : Supported }
orientationAuto =
    Ir.token "auto"


{-| The `horizontal` value of the `orientation` enum — same open row as `horizontal`, prefixed for discovery.
-}
orientationHorizontal : Value { v | horizontal : Supported }
orientationHorizontal =
    Ir.token "horizontal"


{-| The `vertical` value of the `orientation` enum — same open row as `vertical`, prefixed for discovery.
-}
orientationVertical : Value { v | vertical : Supported }
orientationVertical =
    Ir.token "vertical"


{-| The `filled` value of the `pageSizeVariant` enum — same open row as `filled`, prefixed for discovery.
-}
pageSizeVariantFilled : Value { v | filled : Supported }
pageSizeVariantFilled =
    Ir.token "filled"


{-| The `outlined` value of the `pageSizeVariant` enum — same open row as `outlined`, prefixed for discovery.
-}
pageSizeVariantOutlined : Value { v | outlined : Supported }
pageSizeVariantOutlined =
    Ir.token "outlined"


{-| The `above` value of the `position` enum — same open row as `above`, prefixed for discovery.
-}
positionAbove : Value { v | above : Supported }
positionAbove =
    Ir.token "above"


{-| The `above-after` value of the `position` enum — same open row as `aboveAfter`, prefixed for discovery.
-}
positionAboveAfter : Value { v | aboveAfter : Supported }
positionAboveAfter =
    Ir.token "above-after"


{-| The `above-before` value of the `position` enum — same open row as `aboveBefore`, prefixed for discovery.
-}
positionAboveBefore : Value { v | aboveBefore : Supported }
positionAboveBefore =
    Ir.token "above-before"


{-| The `after` value of the `position` enum — same open row as `after`, prefixed for discovery.
-}
positionAfter : Value { v | after : Supported }
positionAfter =
    Ir.token "after"


{-| The `before` value of the `position` enum — same open row as `before`, prefixed for discovery.
-}
positionBefore : Value { v | before : Supported }
positionBefore =
    Ir.token "before"


{-| The `below` value of the `position` enum — same open row as `below`, prefixed for discovery.
-}
positionBelow : Value { v | below : Supported }
positionBelow =
    Ir.token "below"


{-| The `below-after` value of the `position` enum — same open row as `belowAfter`, prefixed for discovery.
-}
positionBelowAfter : Value { v | belowAfter : Supported }
positionBelowAfter =
    Ir.token "below-after"


{-| The `below-before` value of the `position` enum — same open row as `belowBefore`, prefixed for discovery.
-}
positionBelowBefore : Value { v | belowBefore : Supported }
positionBelowBefore =
    Ir.token "below-before"


{-| The `after` value of the `positionX` enum — same open row as `after`, prefixed for discovery.
-}
positionXAfter : Value { v | after : Supported }
positionXAfter =
    Ir.token "after"


{-| The `before` value of the `positionX` enum — same open row as `before`, prefixed for discovery.
-}
positionXBefore : Value { v | before : Supported }
positionXBefore =
    Ir.token "before"


{-| The `above` value of the `positionY` enum — same open row as `above`, prefixed for discovery.
-}
positionYAbove : Value { v | above : Supported }
positionYAbove =
    Ir.token "above"


{-| The `below` value of the `positionY` enum — same open row as `below`, prefixed for discovery.
-}
positionYBelow : Value { v | below : Supported }
positionYBelow =
    Ir.token "below"


{-| The `auto` value of the `scheme` enum — same open row as `auto`, prefixed for discovery.
-}
schemeAuto : Value { v | auto : Supported }
schemeAuto =
    Ir.token "auto"


{-| The `dark` value of the `scheme` enum — same open row as `dark`, prefixed for discovery.
-}
schemeDark : Value { v | dark : Supported }
schemeDark =
    Ir.token "dark"


{-| The `light` value of the `scheme` enum — same open row as `light`, prefixed for discovery.
-}
schemeLight : Value { v | light : Supported }
schemeLight =
    Ir.token "light"


{-| The `hide` value of the `scrollStrategy` enum — same open row as `hide`, prefixed for discovery.
-}
scrollStrategyHide : Value { v | hide : Supported }
scrollStrategyHide =
    Ir.token "hide"


{-| The `reposition` value of the `scrollStrategy` enum — same open row as `reposition`, prefixed for discovery.
-}
scrollStrategyReposition : Value { v | reposition : Supported }
scrollStrategyReposition =
    Ir.token "reposition"


{-| The `auto` value of the `shape` enum — same open row as `auto`, prefixed for discovery.
-}
shapeAuto : Value { v | auto : Supported }
shapeAuto =
    Ir.token "auto"


{-| The `circular` value of the `shape` enum — same open row as `circular`, prefixed for discovery.
-}
shapeCircular : Value { v | circular : Supported }
shapeCircular =
    Ir.token "circular"


{-| The `rounded` value of the `shape` enum — same open row as `rounded`, prefixed for discovery.
-}
shapeRounded : Value { v | rounded : Supported }
shapeRounded =
    Ir.token "rounded"


{-| The `square` value of the `shape` enum — same open row as `square`, prefixed for discovery.
-}
shapeSquare : Value { v | square : Supported }
shapeSquare =
    Ir.token "square"


{-| The `extra-large` value of the `size` enum — same open row as `extraLarge`, prefixed for discovery.
-}
sizeExtraLarge : Value { v | extraLarge : Supported }
sizeExtraLarge =
    Ir.token "extra-large"


{-| The `extra-small` value of the `size` enum — same open row as `extraSmall`, prefixed for discovery.
-}
sizeExtraSmall : Value { v | extraSmall : Supported }
sizeExtraSmall =
    Ir.token "extra-small"


{-| The `large` value of the `size` enum — same open row as `large`, prefixed for discovery.
-}
sizeLarge : Value { v | large : Supported }
sizeLarge =
    Ir.token "large"


{-| The `medium` value of the `size` enum — same open row as `medium`, prefixed for discovery.
-}
sizeMedium : Value { v | medium : Supported }
sizeMedium =
    Ir.token "medium"


{-| The `small` value of the `size` enum — same open row as `small`, prefixed for discovery.
-}
sizeSmall : Value { v | small : Supported }
sizeSmall =
    Ir.token "small"


{-| The `auto` value of the `startMode` enum — same open row as `auto`, prefixed for discovery.
-}
startModeAuto : Value { v | auto : Supported }
startModeAuto =
    Ir.token "auto"


{-| The `over` value of the `startMode` enum — same open row as `over`, prefixed for discovery.
-}
startModeOver : Value { v | over : Supported }
startModeOver =
    Ir.token "over"


{-| The `push` value of the `startMode` enum — same open row as `push`, prefixed for discovery.
-}
startModePush : Value { v | push : Supported }
startModePush =
    Ir.token "push"


{-| The `side` value of the `startMode` enum — same open row as `side`, prefixed for discovery.
-}
startModeSide : Value { v | side : Supported }
startModeSide =
    Ir.token "side"


{-| The `month` value of the `startView` enum — same open row as `month`, prefixed for discovery.
-}
startViewMonth : Value { v | month : Supported }
startViewMonth =
    Ir.token "month"


{-| The `multi-year` value of the `startView` enum — same open row as `multiYear`, prefixed for discovery.
-}
startViewMultiYear : Value { v | multiYear : Supported }
startViewMultiYear =
    Ir.token "multi-year"


{-| The `year` value of the `startView` enum — same open row as `year`, prefixed for discovery.
-}
startViewYear : Value { v | year : Supported }
startViewYear =
    Ir.token "year"


{-| The `content` value of the `state` enum — same open row as `content`, prefixed for discovery.
-}
stateContent : Value { v | content : Supported }
stateContent =
    Ir.token "content"


{-| The `loading` value of the `state` enum — same open row as `loading`, prefixed for discovery.
-}
stateLoading : Value { v | loading : Supported }
stateLoading =
    Ir.token "loading"


{-| The `no-data` value of the `state` enum — same open row as `noData`, prefixed for discovery.
-}
stateNoData : Value { v | noData : Supported }
stateNoData =
    Ir.token "no-data"


{-| The `horizontal` value of the `toggleDirection` enum — same open row as `horizontal`, prefixed for discovery.
-}
toggleDirectionHorizontal : Value { v | horizontal : Supported }
toggleDirectionHorizontal =
    Ir.token "horizontal"


{-| The `vertical` value of the `toggleDirection` enum — same open row as `vertical`, prefixed for discovery.
-}
toggleDirectionVertical : Value { v | vertical : Supported }
toggleDirectionVertical =
    Ir.token "vertical"


{-| The `after` value of the `togglePosition` enum — same open row as `after`, prefixed for discovery.
-}
togglePositionAfter : Value { v | after : Supported }
togglePositionAfter =
    Ir.token "after"


{-| The `before` value of the `togglePosition` enum — same open row as `before`, prefixed for discovery.
-}
togglePositionBefore : Value { v | before : Supported }
togglePositionBefore =
    Ir.token "before"


{-| The `auto` value of the `touchGestures` enum — same open row as `auto`, prefixed for discovery.
-}
touchGesturesAuto : Value { v | auto : Supported }
touchGesturesAuto =
    Ir.token "auto"


{-| The `off` value of the `touchGestures` enum — same open row as `off`, prefixed for discovery.
-}
touchGesturesOff : Value { v | off : Supported }
touchGesturesOff =
    Ir.token "off"


{-| The `on` value of the `touchGestures` enum — same open row as `on`, prefixed for discovery.
-}
touchGesturesOn : Value { v | on : Supported }
touchGesturesOn =
    Ir.token "on"


{-| The `button` value of the `type_` enum — same open row as `button`, prefixed for discovery.
-}
type_Button : Value { v | button : Supported }
type_Button =
    Ir.token "button"


{-| The `reset` value of the `type_` enum — same open row as `reset`, prefixed for discovery.
-}
type_Reset : Value { v | reset : Supported }
type_Reset =
    Ir.token "reset"


{-| The `submit` value of the `type_` enum — same open row as `submit`, prefixed for discovery.
-}
type_Submit : Value { v | submit : Supported }
type_Submit =
    Ir.token "submit"


{-| The `auto` value of the `variant` enum — same open row as `auto`, prefixed for discovery.
-}
variantAuto : Value { v | auto : Supported }
variantAuto =
    Ir.token "auto"


{-| The `connected` value of the `variant` enum — same open row as `connected`, prefixed for discovery.
-}
variantConnected : Value { v | connected : Supported }
variantConnected =
    Ir.token "connected"


{-| The `contained` value of the `variant` enum — same open row as `contained`, prefixed for discovery.
-}
variantContained : Value { v | contained : Supported }
variantContained =
    Ir.token "contained"


{-| The `content` value of the `variant` enum — same open row as `content`, prefixed for discovery.
-}
variantContent : Value { v | content : Supported }
variantContent =
    Ir.token "content"


{-| The `display` value of the `variant` enum — same open row as `display`, prefixed for discovery.
-}
variantDisplay : Value { v | display : Supported }
variantDisplay =
    Ir.token "display"


{-| The `docked` value of the `variant` enum — same open row as `docked`, prefixed for discovery.
-}
variantDocked : Value { v | docked : Supported }
variantDocked =
    Ir.token "docked"


{-| The `elevated` value of the `variant` enum — same open row as `elevated`, prefixed for discovery.
-}
variantElevated : Value { v | elevated : Supported }
variantElevated =
    Ir.token "elevated"


{-| The `expressive` value of the `variant` enum — same open row as `expressive`, prefixed for discovery.
-}
variantExpressive : Value { v | expressive : Supported }
variantExpressive =
    Ir.token "expressive"


{-| The `fidelity` value of the `variant` enum — same open row as `fidelity`, prefixed for discovery.
-}
variantFidelity : Value { v | fidelity : Supported }
variantFidelity =
    Ir.token "fidelity"


{-| The `filled` value of the `variant` enum — same open row as `filled`, prefixed for discovery.
-}
variantFilled : Value { v | filled : Supported }
variantFilled =
    Ir.token "filled"


{-| The `flat` value of the `variant` enum — same open row as `flat`, prefixed for discovery.
-}
variantFlat : Value { v | flat : Supported }
variantFlat =
    Ir.token "flat"


{-| The `fruit-salad` value of the `variant` enum — same open row as `fruitSalad`, prefixed for discovery.
-}
variantFruitSalad : Value { v | fruitSalad : Supported }
variantFruitSalad =
    Ir.token "fruit-salad"


{-| The `headline` value of the `variant` enum — same open row as `headline`, prefixed for discovery.
-}
variantHeadline : Value { v | headline : Supported }
variantHeadline =
    Ir.token "headline"


{-| The `label` value of the `variant` enum — same open row as `label`, prefixed for discovery.
-}
variantLabel : Value { v | label : Supported }
variantLabel =
    Ir.token "label"


{-| The `modal` value of the `variant` enum — same open row as `modal`, prefixed for discovery.
-}
variantModal : Value { v | modal : Supported }
variantModal =
    Ir.token "modal"


{-| The `monochrome` value of the `variant` enum — same open row as `monochrome`, prefixed for discovery.
-}
variantMonochrome : Value { v | monochrome : Supported }
variantMonochrome =
    Ir.token "monochrome"


{-| The `neutral` value of the `variant` enum — same open row as `neutral`, prefixed for discovery.
-}
variantNeutral : Value { v | neutral : Supported }
variantNeutral =
    Ir.token "neutral"


{-| The `outlined` value of the `variant` enum — same open row as `outlined`, prefixed for discovery.
-}
variantOutlined : Value { v | outlined : Supported }
variantOutlined =
    Ir.token "outlined"


{-| The `primary` value of the `variant` enum — same open row as `primary`, prefixed for discovery.
-}
variantPrimary : Value { v | primary : Supported }
variantPrimary =
    Ir.token "primary"


{-| The `primary-container` value of the `variant` enum — same open row as `primaryContainer`, prefixed for discovery.
-}
variantPrimaryContainer : Value { v | primaryContainer : Supported }
variantPrimaryContainer =
    Ir.token "primary-container"


{-| The `rainbow` value of the `variant` enum — same open row as `rainbow`, prefixed for discovery.
-}
variantRainbow : Value { v | rainbow : Supported }
variantRainbow =
    Ir.token "rainbow"


{-| The `rounded` value of the `variant` enum — same open row as `rounded`, prefixed for discovery.
-}
variantRounded : Value { v | rounded : Supported }
variantRounded =
    Ir.token "rounded"


{-| The `secondary` value of the `variant` enum — same open row as `secondary`, prefixed for discovery.
-}
variantSecondary : Value { v | secondary : Supported }
variantSecondary =
    Ir.token "secondary"


{-| The `secondary-container` value of the `variant` enum — same open row as `secondaryContainer`, prefixed for discovery.
-}
variantSecondaryContainer : Value { v | secondaryContainer : Supported }
variantSecondaryContainer =
    Ir.token "secondary-container"


{-| The `segmented` value of the `variant` enum — same open row as `segmented`, prefixed for discovery.
-}
variantSegmented : Value { v | segmented : Supported }
variantSegmented =
    Ir.token "segmented"


{-| The `sharp` value of the `variant` enum — same open row as `sharp`, prefixed for discovery.
-}
variantSharp : Value { v | sharp : Supported }
variantSharp =
    Ir.token "sharp"


{-| The `standard` value of the `variant` enum — same open row as `standard`, prefixed for discovery.
-}
variantStandard : Value { v | standard : Supported }
variantStandard =
    Ir.token "standard"


{-| The `surface` value of the `variant` enum — same open row as `surface`, prefixed for discovery.
-}
variantSurface : Value { v | surface : Supported }
variantSurface =
    Ir.token "surface"


{-| The `tertiary` value of the `variant` enum — same open row as `tertiary`, prefixed for discovery.
-}
variantTertiary : Value { v | tertiary : Supported }
variantTertiary =
    Ir.token "tertiary"


{-| The `tertiary-container` value of the `variant` enum — same open row as `tertiaryContainer`, prefixed for discovery.
-}
variantTertiaryContainer : Value { v | tertiaryContainer : Supported }
variantTertiaryContainer =
    Ir.token "tertiary-container"


{-| The `text` value of the `variant` enum — same open row as `text`, prefixed for discovery.
-}
variantText : Value { v | text : Supported }
variantText =
    Ir.token "text"


{-| The `title` value of the `variant` enum — same open row as `title`, prefixed for discovery.
-}
variantTitle : Value { v | title : Supported }
variantTitle =
    Ir.token "title"


{-| The `tonal` value of the `variant` enum — same open row as `tonal`, prefixed for discovery.
-}
variantTonal : Value { v | tonal : Supported }
variantTonal =
    Ir.token "tonal"


{-| The `tonal-spot` value of the `variant` enum — same open row as `tonalSpot`, prefixed for discovery.
-}
variantTonalSpot : Value { v | tonalSpot : Supported }
variantTonalSpot =
    Ir.token "tonal-spot"


{-| The `uncontained` value of the `variant` enum — same open row as `uncontained`, prefixed for discovery.
-}
variantUncontained : Value { v | uncontained : Supported }
variantUncontained =
    Ir.token "uncontained"


{-| The `vibrant` value of the `variant` enum — same open row as `vibrant`, prefixed for discovery.
-}
variantVibrant : Value { v | vibrant : Supported }
variantVibrant =
    Ir.token "vibrant"


{-| The `wavy` value of the `variant` enum — same open row as `wavy`, prefixed for discovery.
-}
variantWavy : Value { v | wavy : Supported }
variantWavy =
    Ir.token "wavy"


{-| The `default` value of the `width` enum — same open row as `default`, prefixed for discovery.
-}
widthDefault : Value { v | default : Supported }
widthDefault =
    Ir.token "default"


{-| The `narrow` value of the `width` enum — same open row as `narrow`, prefixed for discovery.
-}
widthNarrow : Value { v | narrow : Supported }
widthNarrow =
    Ir.token "narrow"


{-| The `wide` value of the `width` enum — same open row as `wide`, prefixed for discovery.
-}
widthWide : Value { v | wide : Supported }
widthWide =
    Ir.token "wide"
