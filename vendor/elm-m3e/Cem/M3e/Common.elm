module Cem.M3e.Common exposing (Current(..), Scheme(..), ScrollStrategy(..), StartView(..), ToggleDirection(..), TogglePosition(..), TouchGestures(..), Type(..), activeDate, anchorOffset, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, current, date, detent, disabled, disabledInteractive, dismissible, download, fitAnchorWidth, for, hideDelay, hideSelectionIndicator, hideToggle, href, indeterminate, label, level, maxAttr, maxDate, minAttr, minDate, multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, overshootLimit, panelClass, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, rangeEnd, rangeStart, rel, scheme, scrollStrategy, selected, showDelay, startAt, startView, step, target, targetValue, term, today, toggle, toggleDirection, togglePosition, touchGestures, type_, vertical)

{-| 
@docs targetValue, activeDate, anchorOffset, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, Current, current, date, detent, disabled, disabledInteractive, dismissible, download, fitAnchorWidth, for, hideDelay, hideSelectionIndicator, hideToggle, href, indeterminate, label, level, maxAttr, maxDate, minAttr, minDate, multi, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, overshootLimit, panelClass, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, rangeEnd, rangeStart, rel, Scheme, scheme, ScrollStrategy, scrollStrategy, selected, showDelay, startAt, StartView, startView, step, target, term, today, toggle, ToggleDirection, toggleDirection, TogglePosition, togglePosition, TouchGestures, touchGestures, Type, type_, vertical
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


{-| The active date. (default: `new Date()`) -}
activeDate : String -> Html.Attribute msg
activeDate val_ =
    Html.Attributes.attribute "active-date" val_


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset : Float -> Html.Attribute msg
anchorOffset val_ =
    Html.Attributes.property "anchor-offset" (Json.Encode.float val_)


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "case-sensitive" (Json.Encode.bool val_)


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered : Bool -> Html.Attribute msg
centered val_ =
    Html.Attributes.property "centered" (Json.Encode.bool val_)


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel : String -> Html.Attribute msg
clearLabel val_ =
    Html.Attributes.attribute "clear-label" val_


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    Html.Attributes.property "clearable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel : String -> Html.Attribute msg
closeLabel val_ =
    Html.Attributes.attribute "close-label" val_


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> Html.Attribute msg
color val_ =
    Html.Attributes.attribute "color" val_


{-| Values for the `current` attribute. -}
type Current
    = Date
    | Location
    | Page
    | Step
    | Time
    | True


{-| Indicates the current item in the breadcrumb path. -}
current : Current -> Html.Attribute msg
current val_ =
    Html.Attributes.attribute "current" (currentToString val_)


currentToString : Current -> String
currentToString val_ =
    case val_ of
        Date ->
            "date"
    
        Location ->
            "location"
    
        Page ->
            "page"
    
        Step ->
            "step"
    
        Time ->
            "time"
    
        True ->
            "true"


{-| The selected date. (default: `null`) -}
date : String -> Html.Attribute msg
date val_ =
    Html.Attributes.attribute "date" val_


{-| The zero‑based index of the detent the sheet should open to. -}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabled-interactive" (Json.Encode.bool val_)


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    Html.Attributes.property "dismissible" (Json.Encode.bool val_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth : Bool -> Html.Attribute msg
fitAnchorWidth val_ =
    Html.Attributes.property "fit-anchor-width" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hide-delay" (Json.Encode.float val_)


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hide-selection-indicator" (Json.Encode.bool val_)


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hide-toggle" (Json.Encode.bool val_)


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> Html.Attribute msg
label val_ =
    Html.Attributes.attribute "label" val_


{-| The accessibility level of the heading. -}
level : String -> Html.Attribute msg
level val_ =
    Html.Attributes.attribute "level" val_


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
minAttr : Float -> Html.Attribute msg
minAttr val_ =
    Html.Attributes.property "min" (Json.Encode.float val_)


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel val_ =
    Html.Attributes.attribute "next-month-label" val_


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel val_ =
    Html.Attributes.attribute "next-multi-year-label" val_


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel val_ =
    Html.Attributes.attribute "next-page-label" val_


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel val_ =
    Html.Attributes.attribute "next-year-label" val_


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.property "overshoot-limit" (Json.Encode.float val_)


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass : String -> Html.Attribute msg
panelClass val_ =
    Html.Attributes.attribute "panel-class" val_


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel val_ =
    Html.Attributes.attribute "previous-month-label" val_


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel val_ =
    Html.Attributes.attribute "previous-multi-year-label" val_


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel val_ =
    Html.Attributes.attribute "previous-page-label" val_


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel val_ =
    Html.Attributes.attribute "previous-year-label" val_


{-| End of a date range. (default: `null`) -}
rangeEnd : String -> Html.Attribute msg
rangeEnd val_ =
    Html.Attributes.attribute "range-end" val_


{-| Start of a date range. (default: `null`) -}
rangeStart : String -> Html.Attribute msg
rangeStart val_ =
    Html.Attributes.attribute "range-start" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| Values for the `scheme` attribute. -}
type Scheme
    = SchemeAuto
    | Dark
    | Light


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme : Scheme -> Html.Attribute msg
scheme val_ =
    Html.Attributes.attribute "scheme" (schemeToString val_)


schemeToString : Scheme -> String
schemeToString val_ =
    case val_ of
        SchemeAuto ->
            "auto"
    
        Dark ->
            "dark"
    
        Light ->
            "light"


{-| Values for the `scroll-strategy` attribute. -}
type ScrollStrategy
    = Hide
    | Reposition


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`) -}
scrollStrategy : ScrollStrategy -> Html.Attribute msg
scrollStrategy val_ =
    Html.Attributes.attribute "scroll-strategy" (scrollStrategyToString val_)


scrollStrategyToString : ScrollStrategy -> String
scrollStrategyToString val_ =
    case val_ of
        Hide ->
            "hide"
    
        Reposition ->
            "reposition"


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "show-delay" (Json.Encode.float val_)


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| Values for the `start-view` attribute. -}
type StartView
    = Month
    | MultiYear
    | Year


{-| The initial view used to select a date. (default: `"month"`) -}
startView : StartView -> Html.Attribute msg
startView val_ =
    Html.Attributes.attribute "start-view" (startViewToString val_)


startViewToString : StartView -> String
startViewToString val_ =
    case val_ of
        Month ->
            "month"
    
        MultiYear ->
            "multi-year"
    
        Year ->
            "year"


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step : Float -> Html.Attribute msg
step val_ =
    Html.Attributes.property "step" (Json.Encode.float val_)


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| The search term to highlight. (default: `""`) -}
term : String -> Html.Attribute msg
term val_ =
    Html.Attributes.attribute "term" val_


{-| Today's date. (default: `new Date()`) -}
today : String -> Html.Attribute msg
today val_ =
    Html.Attributes.attribute "today" val_


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> Html.Attribute msg
toggle val_ =
    Html.Attributes.property "toggle" (Json.Encode.bool val_)


{-| Values for the `toggle-direction` attribute. -}
type ToggleDirection
    = Horizontal
    | Vertical


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection : ToggleDirection -> Html.Attribute msg
toggleDirection val_ =
    Html.Attributes.attribute "toggle-direction" (toggleDirectionToString val_)


toggleDirectionToString : ToggleDirection -> String
toggleDirectionToString val_ =
    case val_ of
        Horizontal ->
            "horizontal"
    
        Vertical ->
            "vertical"


{-| Values for the `toggle-position` attribute. -}
type TogglePosition
    = After
    | Before


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition : TogglePosition -> Html.Attribute msg
togglePosition val_ =
    Html.Attributes.attribute "toggle-position" (togglePositionToString val_)


togglePositionToString : TogglePosition -> String
togglePositionToString val_ =
    case val_ of
        After ->
            "after"
    
        Before ->
            "before"


{-| Values for the `touch-gestures` attribute. -}
type TouchGestures
    = TouchGesturesAuto
    | Off
    | On


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures : TouchGestures -> Html.Attribute msg
touchGestures val_ =
    Html.Attributes.attribute "touch-gestures" (touchGesturesToString val_)


touchGesturesToString : TouchGestures -> String
touchGesturesToString val_ =
    case val_ of
        TouchGesturesAuto ->
            "auto"
    
        Off ->
            "off"
    
        On ->
            "on"


{-| Values for the `type` attribute. -}
type Type
    = Button
    | Reset
    | Submit


{-| The type of the element. (default: `"button"`) -}
type_ : Type -> Html.Attribute msg
type_ val_ =
    Html.Attributes.attribute "type" (typeToString val_)


typeToString : Type -> String
typeToString val_ =
    case val_ of
        Button ->
            "button"
    
        Reset ->
            "reset"
    
        Submit ->
            "submit"


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)