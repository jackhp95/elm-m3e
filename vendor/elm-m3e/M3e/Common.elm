module M3e.Common exposing (targetValue, activeDate, anchorOffset, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, current, date, detent, disabled, disabledInteractive, dismissible, download, fitAnchorWidth, for, headerPosition, hideDelay, hideSelectionIndicator, hideToggle, href, indeterminate, label, level, maxAttr, maxDate, minAttr, minDate, mode, multi, name, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, orientation, overshootLimit, panelClass, position, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, rangeEnd, rangeStart, rel, scheme, scrollStrategy, selected, shape, showDelay, size, startAt, startView, step, target, term, today, toggle, toggleDirection, togglePosition, touchGestures, type_, variant, vertical)

{-|

@docs targetValue, activeDate, anchorOffset, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, current, date, detent, disabled, disabledInteractive, dismissible, download, fitAnchorWidth, for, headerPosition, hideDelay, hideSelectionIndicator, hideToggle, href, indeterminate, label, level, maxAttr, maxDate, minAttr, minDate, mode, multi, name, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, orientation, overshootLimit, panelClass, position, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, rangeEnd, rangeStart, rel, scheme, scrollStrategy, selected, shape, showDelay, size, startAt, startView, step, target, term, today, toggle, toggleDirection, togglePosition, touchGestures, type_, variant, vertical

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


{-| Indicates the current item in the breadcrumb path.
-}
current : String -> Html.Attribute msg
current val_ =
    Html.Attributes.attribute "current" val_


{-| The selected date. (default: `null`)
-}
date : String -> Html.Attribute msg
date val_ =
    Html.Attributes.attribute "date" val_


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


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


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition : String -> Html.Attribute msg
headerPosition val_ =
    Html.Attributes.attribute "header-position" val_


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
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
label : String -> Html.Attribute msg
label val_ =
    Html.Attributes.attribute "label" val_


{-| The accessibility level of the heading.
-}
level : String -> Html.Attribute msg
level val_ =
    Html.Attributes.attribute "level" val_


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


{-| The behavior mode of the view. (default: `"docked"`)
-}
mode : String -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" val_


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


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


{-| The orientation of the stepper. (default: `"horizontal"`)
-}
orientation : String -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" val_


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


{-| The position of the tooltip. (default: `"below"`)
-}
position : String -> Html.Attribute msg
position val_ =
    Html.Attributes.attribute "position" val_


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


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme : String -> Html.Attribute msg
scheme val_ =
    Html.Attributes.attribute "scheme" val_


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy : String -> Html.Attribute msg
scrollStrategy val_ =
    Html.Attributes.attribute "scroll-strategy" val_


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| The shape of the toolbar. (default: `"square"`)
-}
shape : String -> Html.Attribute msg
shape val_ =
    Html.Attributes.attribute "shape" val_


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "show-delay" (Json.Encode.float val_)


{-| The size of the button. (default: `"small"`)
-}
size : String -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" val_


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| The initial view used to select a date. (default: `"month"`)
-}
startView : String -> Html.Attribute msg
startView val_ =
    Html.Attributes.attribute "start-view" val_


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
step : Float -> Html.Attribute msg
step val_ =
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


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection : String -> Html.Attribute msg
toggleDirection val_ =
    Html.Attributes.attribute "toggle-direction" val_


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition : String -> Html.Attribute msg
togglePosition val_ =
    Html.Attributes.attribute "toggle-position" val_


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures : String -> Html.Attribute msg
touchGestures val_ =
    Html.Attributes.attribute "touch-gestures" val_


{-| The type of the element. (default: `"button"`)
-}
type_ : String -> Html.Attribute msg
type_ val_ =
    Html.Attributes.attribute "type" val_


{-| The appearance variant of the toolbar. (default: `"standard"`)
-}
variant : String -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" val_


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)
