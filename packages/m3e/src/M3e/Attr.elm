module M3e.Attr exposing (Animation(..), Contrast(..), Current(..), Dividers(..), EndMode(..), Filter(..), FloatLabel(..), Grade(..), HeaderPosition(..), HideSubscript(..), HighlightMode(..), Icons(..), LabelPosition(..), Mode(..), Motion(..), Orientation(..), PageSizeVariant(..), Position(..), PositionX(..), PositionY(..), Scheme(..), ScrollStrategy(..), Shape(..), Size(..), StartMode(..), StartView(..), State(..), ToggleDirection(..), TogglePosition(..), TouchGestures(..), Type(..), Variant(..), Width(..), action, actionable, activeDate, alert, anchorOffset, animation, animationToString, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, completed, confirmLabel, contained, contrast, contrastToString, current, currentToString, date, density, detent, disableClose, disableHighlight, disableHover, disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel, dismissible, dividers, dividersToString, download, duration, editable, elevated, emphasized, end, endDivider, endMode, endModeToString, extended, filled, filter, filterToString, firstPageLabel, fitAnchorWidth, floatLabel, floatLabelToString, for, grade, gradeToString, handle, handleLabel, headerPosition, headerPositionToString, hideDelay, hideFriction, hideLoading, hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, hideSubscript, hideSubscriptToString, hideToggle, hideable, highlightMode, highlightModeToString, href, icons, iconsToString, indeterminate, inline, inset, insetEnd, insetStart, invalid, inward, itemLabel, itemsPerPageLabel, label, labelPosition, labelPositionToString, labelled, lastPageLabel, length, level, linear, loaded, loading, loadingLabel, lowered, maxAttr, maxDate, maxDepth, maxRows, minAttr, minDate, minRows, modal, mode, modeToString, motion, motionToString, multi, name, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel, noFocusTrap, open, opticalSize, optional, orientation, orientationToString, overshootLimit, pageIndex, pageSize, pageSizeVariant, pageSizeVariantToString, pageSizes, panelClass, position, positionToString, positionX, positionXToString, positionY, positionYToString, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, radius, range, rangeEnd, rangeStart, rel, removable, removeLabel, required, returnValue, scheme, schemeToString, scrollStrategy, scrollStrategyToString, secondary, selected, selectedIndex, shape, shapeToString, showDelay, showFirstLastButtons, size, sizeToString, start, startAt, startDivider, startMode, startModeToString, startView, startViewToString, state, stateToString, step, stretch, strongFocus, submenu, target, targetValue, term, thin, threshold, today, toggle, toggleDirection, toggleDirectionToString, togglePosition, togglePositionToString, touchGestures, touchGesturesToString, typeToString, type_, unbounded, value, variant, variantToString, vertical, weight, width, widthToString, wrap, wrapDetents)

{-| 
@docs targetValue, action, actionable, activeDate, alert, anchorOffset, Animation, animation, animationToString, ariaInvalid, autoActivate, bufferValue, cascade, caseSensitive, centered, checked, clearLabel, clearable, closeLabel, color, completed, confirmLabel, contained, Contrast, contrast, contrastToString, Current, current, currentToString, date, density, detent, disableClose, disableHighlight, disableHover, disablePagination, disableRestoreFocus, disabled, disabledInteractive, discrete, dismissLabel, dismissible, Dividers, dividers, dividersToString, download, duration, editable, elevated, emphasized, end, endDivider, EndMode, endMode, endModeToString, extended, filled, Filter, filter, filterToString, firstPageLabel, fitAnchorWidth, FloatLabel, floatLabel, floatLabelToString, for, Grade, grade, gradeToString, handle, handleLabel, HeaderPosition, headerPosition, headerPositionToString, hideDelay, hideFriction, hideLoading, hideNoData, hidePageSize, hideRequiredMarker, hideSearchIcon, hideSelectionIndicator, HideSubscript, hideSubscript, hideSubscriptToString, hideToggle, hideable, HighlightMode, highlightMode, highlightModeToString, href, Icons, icons, iconsToString, indeterminate, inline, inset, insetEnd, insetStart, invalid, inward, itemLabel, itemsPerPageLabel, label, LabelPosition, labelPosition, labelPositionToString, labelled, lastPageLabel, length, level, linear, loaded, loading, loadingLabel, lowered, maxAttr, maxDate, maxDepth, maxRows, minAttr, minDate, minRows, modal, Mode, mode, modeToString, Motion, motion, motionToString, multi, name, nextMonthLabel, nextMultiYearLabel, nextPageLabel, nextYearLabel, noAnimate, noDataLabel, noFocusTrap, open, opticalSize, optional, Orientation, orientation, orientationToString, overshootLimit, pageIndex, pageSize, PageSizeVariant, pageSizeVariant, pageSizeVariantToString, pageSizes, panelClass, Position, position, positionToString, PositionX, positionX, positionXToString, PositionY, positionY, positionYToString, previousMonthLabel, previousMultiYearLabel, previousPageLabel, previousYearLabel, radius, range, rangeEnd, rangeStart, rel, removable, removeLabel, required, returnValue, Scheme, scheme, schemeToString, ScrollStrategy, scrollStrategy, scrollStrategyToString, secondary, selected, selectedIndex, Shape, shape, shapeToString, showDelay, showFirstLastButtons, Size, size, sizeToString, start, startAt, startDivider, StartMode, startMode, startModeToString, StartView, startView, startViewToString, State, state, stateToString, step, stretch, strongFocus, submenu, target, term, thin, threshold, today, toggle, ToggleDirection, toggleDirection, toggleDirectionToString, TogglePosition, togglePosition, togglePositionToString, TouchGestures, touchGestures, touchGesturesToString, Type, type_, typeToString, unbounded, value, Variant, variant, variantToString, vertical, weight, Width, width, widthToString, wrap, wrapDetents
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


{-| The label of the snackbar's action. (default: `""`) -}
action : String -> Html.Attribute msg
action val_ =
    Html.Attributes.attribute "action" val_


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable : Bool -> Html.Attribute msg
actionable val_ =
    Html.Attributes.property "actionable" (Json.Encode.bool val_)


{-| The active date. (default: `new Date()`) -}
activeDate : String -> Html.Attribute msg
activeDate val_ =
    Html.Attributes.attribute "active-date" val_


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> Html.Attribute msg
alert val_ =
    Html.Attributes.property "alert" (Json.Encode.bool val_)


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`) -}
anchorOffset : Float -> Html.Attribute msg
anchorOffset val_ =
    Html.Attributes.property "anchorOffset" (Json.Encode.float val_)


{-| Values for the `animation` attribute. -}
type Animation
    = AnimationNone
    | Pulse
    | Wave


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation : Animation -> Html.Attribute msg
animation val_ =
    Html.Attributes.attribute "animation" (animationToString val_)


{-| Render the `animation` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
animationToString : Animation -> String
animationToString val_ =
    case val_ of
        AnimationNone ->
            "none"
    
        Pulse ->
            "pulse"
    
        Wave ->
            "wave"


{-| Set the `aria-invalid` attribute. -}
ariaInvalid : String -> Html.Attribute msg
ariaInvalid val_ =
    Html.Attributes.attribute "aria-invalid" val_


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate : Bool -> Html.Attribute msg
autoActivate val_ =
    Html.Attributes.property "autoActivate" (Json.Encode.bool val_)


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
bufferValue : Float -> Html.Attribute msg
bufferValue val_ =
    Html.Attributes.property "bufferValue" (Json.Encode.float val_)


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> Html.Attribute msg
cascade val_ =
    Html.Attributes.property "cascade" (Json.Encode.bool val_)


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "caseSensitive" (Json.Encode.bool val_)


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


{-| Whether the step has been completed. (default: `false`) -}
completed : Bool -> Html.Attribute msg
completed val_ =
    Html.Attributes.property "completed" (Json.Encode.bool val_)


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel : String -> Html.Attribute msg
confirmLabel val_ =
    Html.Attributes.attribute "confirm-label" val_


{-| Whether the view features a persistent, filled search container. (default: `false`) -}
contained : Bool -> Html.Attribute msg
contained val_ =
    Html.Attributes.property "contained" (Json.Encode.bool val_)


{-| Values for the `contrast` attribute. -}
type Contrast
    = ContrastHigh
    | ContrastMedium
    | ContrastStandard


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast : Contrast -> Html.Attribute msg
contrast val_ =
    Html.Attributes.attribute "contrast" (contrastToString val_)


{-| Render the `contrast` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
contrastToString : Contrast -> String
contrastToString val_ =
    case val_ of
        ContrastHigh ->
            "high"
    
        ContrastMedium ->
            "medium"
    
        ContrastStandard ->
            "standard"


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


{-| Render the `current` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
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


{-| The density scale (0, -1, -2). (default: `0`) -}
density : Float -> Html.Attribute msg
density val_ =
    Html.Attributes.property "density" (Json.Encode.float val_)


{-| The zero‑based index of the detent the sheet should open to. -}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose : Bool -> Html.Attribute msg
disableClose val_ =
    Html.Attributes.property "disableClose" (Json.Encode.bool val_)


{-| Whether text highlighting is disabled. (default: `false`) -}
disableHighlight : Bool -> Html.Attribute msg
disableHighlight val_ =
    Html.Attributes.property "disableHighlight" (Json.Encode.bool val_)


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> Html.Attribute msg
disableHover val_ =
    Html.Attributes.property "disableHover" (Json.Encode.bool val_)


{-| Whether scroll buttons are disabled. -}
disablePagination : String -> Html.Attribute msg
disablePagination val_ =
    Html.Attributes.attribute "disable-pagination" val_


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus : Bool -> Html.Attribute msg
disableRestoreFocus val_ =
    Html.Attributes.property "disableRestoreFocus" (Json.Encode.bool val_)


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| Whether to show tick marks. (default: `false`) -}
discrete : Bool -> Html.Attribute msg
discrete val_ =
    Html.Attributes.property "discrete" (Json.Encode.bool val_)


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel : String -> Html.Attribute msg
dismissLabel val_ =
    Html.Attributes.attribute "dismiss-label" val_


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    Html.Attributes.property "dismissible" (Json.Encode.bool val_)


{-| Values for the `dividers` attribute. -}
type Dividers
    = DividersAbove
    | AboveBelow
    | DividersBelow
    | DividersNone


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers : Dividers -> Html.Attribute msg
dividers val_ =
    Html.Attributes.attribute "dividers" (dividersToString val_)


{-| Render the `dividers` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
dividersToString : Dividers -> String
dividersToString val_ =
    case val_ of
        DividersAbove ->
            "above"
    
        AboveBelow ->
            "above-below"
    
        DividersBelow ->
            "below"
    
        DividersNone ->
            "none"


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration : Float -> Html.Attribute msg
duration val_ =
    Html.Attributes.property "duration" (Json.Encode.float val_)


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> Html.Attribute msg
editable val_ =
    Html.Attributes.property "editable" (Json.Encode.bool val_)


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated : Bool -> Html.Attribute msg
elevated val_ =
    Html.Attributes.property "elevated" (Json.Encode.bool val_)


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized : Bool -> Html.Attribute msg
emphasized val_ =
    Html.Attributes.property "emphasized" (Json.Encode.bool val_)


{-| Whether the end drawer is open. (default: `false`) -}
end : Bool -> Html.Attribute msg
end val_ =
    Html.Attributes.property "end" (Json.Encode.bool val_)


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider : Bool -> Html.Attribute msg
endDivider val_ =
    Html.Attributes.property "endDivider" (Json.Encode.bool val_)


{-| Values for the `end-mode` attribute. -}
type EndMode
    = EndModeAuto
    | EndModeOver
    | EndModePush
    | EndModeSide


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode : EndMode -> Html.Attribute msg
endMode val_ =
    Html.Attributes.attribute "end-mode" (endModeToString val_)


{-| Render the `end-mode` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
endModeToString : EndMode -> String
endModeToString val_ =
    case val_ of
        EndModeAuto ->
            "auto"
    
        EndModeOver ->
            "over"
    
        EndModePush ->
            "push"
    
        EndModeSide ->
            "side"


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> Html.Attribute msg
extended val_ =
    Html.Attributes.property "extended" (Json.Encode.bool val_)


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> Html.Attribute msg
filled val_ =
    Html.Attributes.property "filled" (Json.Encode.bool val_)


{-| Values for the `filter` attribute. -}
type Filter
    = FilterContains
    | FilterEndsWith
    | FilterNone
    | FilterStartsWith


{-| Mode in which to filter options. (default: `"contains"`) -}
filter : Filter -> Html.Attribute msg
filter val_ =
    Html.Attributes.attribute "filter" (filterToString val_)


{-| Render the `filter` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
filterToString : Filter -> String
filterToString val_ =
    case val_ of
        FilterContains ->
            "contains"
    
        FilterEndsWith ->
            "ends-with"
    
        FilterNone ->
            "none"
    
        FilterStartsWith ->
            "starts-with"


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel : String -> Html.Attribute msg
firstPageLabel val_ =
    Html.Attributes.attribute "first-page-label" val_


{-| Whether the panel's width should match its anchor's width. (default: `false`) -}
fitAnchorWidth : Bool -> Html.Attribute msg
fitAnchorWidth val_ =
    Html.Attributes.property "fitAnchorWidth" (Json.Encode.bool val_)


{-| Values for the `float-label` attribute. -}
type FloatLabel
    = FloatLabelAlways
    | FloatLabelAuto


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel : FloatLabel -> Html.Attribute msg
floatLabel val_ =
    Html.Attributes.attribute "float-label" (floatLabelToString val_)


{-| Render the `float-label` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
floatLabelToString : FloatLabel -> String
floatLabelToString val_ =
    case val_ of
        FloatLabelAlways ->
            "always"
    
        FloatLabelAuto ->
            "auto"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| Values for the `grade` attribute. -}
type Grade
    = GradeHigh
    | Low
    | GradeMedium


{-| The grade of the icon. (default: `"medium"`) -}
grade : Grade -> Html.Attribute msg
grade val_ =
    Html.Attributes.attribute "grade" (gradeToString val_)


{-| Render the `grade` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
gradeToString : Grade -> String
gradeToString val_ =
    case val_ of
        GradeHigh ->
            "high"
    
        Low ->
            "low"
    
        GradeMedium ->
            "medium"


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> Html.Attribute msg
handle val_ =
    Html.Attributes.property "handle" (Json.Encode.bool val_)


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel : String -> Html.Attribute msg
handleLabel val_ =
    Html.Attributes.attribute "handle-label" val_


{-| Values for the `header-position` attribute. -}
type HeaderPosition
    = HeaderPositionAfter
    | HeaderPositionBefore
    | HeaderPositionAbove
    | HeaderPositionBelow


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition : HeaderPosition -> Html.Attribute msg
headerPosition val_ =
    Html.Attributes.attribute "header-position" (headerPositionToString val_)


{-| Render the `header-position` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
headerPositionToString : HeaderPosition -> String
headerPositionToString val_ =
    case val_ of
        HeaderPositionAfter ->
            "after"
    
        HeaderPositionBefore ->
            "before"
    
        HeaderPositionAbove ->
            "above"
    
        HeaderPositionBelow ->
            "below"


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hideDelay" (Json.Encode.float val_)


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction : Float -> Html.Attribute msg
hideFriction val_ =
    Html.Attributes.property "hideFriction" (Json.Encode.float val_)


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading : Bool -> Html.Attribute msg
hideLoading val_ =
    Html.Attributes.property "hideLoading" (Json.Encode.bool val_)


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData : Bool -> Html.Attribute msg
hideNoData val_ =
    Html.Attributes.property "hideNoData" (Json.Encode.bool val_)


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize : Bool -> Html.Attribute msg
hidePageSize val_ =
    Html.Attributes.property "hidePageSize" (Json.Encode.bool val_)


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker : Bool -> Html.Attribute msg
hideRequiredMarker val_ =
    Html.Attributes.property "hideRequiredMarker" (Json.Encode.bool val_)


{-| Whether to hide the search icon. (default: `false`) -}
hideSearchIcon : Bool -> Html.Attribute msg
hideSearchIcon val_ =
    Html.Attributes.property "hideSearchIcon" (Json.Encode.bool val_)


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hideSelectionIndicator" (Json.Encode.bool val_)


{-| Values for the `hide-subscript` attribute. -}
type HideSubscript
    = HideSubscriptAlways
    | HideSubscriptAuto
    | Never


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript : HideSubscript -> Html.Attribute msg
hideSubscript val_ =
    Html.Attributes.attribute "hide-subscript" (hideSubscriptToString val_)


{-| Render the `hide-subscript` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
hideSubscriptToString : HideSubscript -> String
hideSubscriptToString val_ =
    case val_ of
        HideSubscriptAlways ->
            "always"
    
        HideSubscriptAuto ->
            "auto"
    
        Never ->
            "never"


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hideToggle" (Json.Encode.bool val_)


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable : Bool -> Html.Attribute msg
hideable val_ =
    Html.Attributes.property "hideable" (Json.Encode.bool val_)


{-| Values for the `highlight-mode` attribute. -}
type HighlightMode
    = HighlightModeContains
    | HighlightModeEndsWith
    | HighlightModeStartsWith


{-| The mode in which to highlight a term. (default: `"contains"`) -}
highlightMode : HighlightMode -> Html.Attribute msg
highlightMode val_ =
    Html.Attributes.attribute "highlight-mode" (highlightModeToString val_)


{-| Render the `highlight-mode` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
highlightModeToString : HighlightMode -> String
highlightModeToString val_ =
    case val_ of
        HighlightModeContains ->
            "contains"
    
        HighlightModeEndsWith ->
            "ends-with"
    
        HighlightModeStartsWith ->
            "starts-with"


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| Values for the `icons` attribute. -}
type Icons
    = Both
    | IconsNone
    | Selected


{-| The icons to present. (default: `"none"`) -}
icons : Icons -> Html.Attribute msg
icons val_ =
    Html.Attributes.attribute "icons" (iconsToString val_)


{-| Render the `icons` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
iconsToString : Icons -> String
iconsToString val_ =
    case val_ of
        Both ->
            "both"
    
        IconsNone ->
            "none"
    
        Selected ->
            "selected"


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline : Bool -> Html.Attribute msg
inline val_ =
    Html.Attributes.property "inline" (Json.Encode.bool val_)


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset : Bool -> Html.Attribute msg
inset val_ =
    Html.Attributes.property "inset" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd : Bool -> Html.Attribute msg
insetEnd val_ =
    Html.Attributes.property "insetEnd" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart : Bool -> Html.Attribute msg
insetStart val_ =
    Html.Attributes.property "insetStart" (Json.Encode.bool val_)


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> Html.Attribute msg
invalid val_ =
    Html.Attributes.property "invalid" (Json.Encode.bool val_)


{-| Whether the focus ring animates inward instead of outward. (default: `false`) -}
inward : Bool -> Html.Attribute msg
inward val_ =
    Html.Attributes.property "inward" (Json.Encode.bool val_)


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel : String -> Html.Attribute msg
itemLabel val_ =
    Html.Attributes.attribute "item-label" val_


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel : String -> Html.Attribute msg
itemsPerPageLabel val_ =
    Html.Attributes.attribute "items-per-page-label" val_


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> Html.Attribute msg
label val_ =
    Html.Attributes.attribute "label" val_


{-| Values for the `label-position` attribute. -}
type LabelPosition
    = LabelPositionBelow
    | End


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition : LabelPosition -> Html.Attribute msg
labelPosition val_ =
    Html.Attributes.attribute "label-position" (labelPositionToString val_)


{-| Render the `label-position` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
labelPositionToString : LabelPosition -> String
labelPositionToString val_ =
    case val_ of
        LabelPositionBelow ->
            "below"
    
        End ->
            "end"


{-| Whether to show value labels when activated. (default: `false`) -}
labelled : Bool -> Html.Attribute msg
labelled val_ =
    Html.Attributes.property "labelled" (Json.Encode.bool val_)


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel : String -> Html.Attribute msg
lastPageLabel val_ =
    Html.Attributes.attribute "last-page-label" val_


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length : Float -> Html.Attribute msg
length val_ =
    Html.Attributes.property "length" (Json.Encode.float val_)


{-| The accessibility level of the heading. -}
level : String -> Html.Attribute msg
level val_ =
    Html.Attributes.attribute "level" val_


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear : Bool -> Html.Attribute msg
linear val_ =
    Html.Attributes.property "linear" (Json.Encode.bool val_)


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> Html.Attribute msg
loaded val_ =
    Html.Attributes.property "loaded" (Json.Encode.bool val_)


{-| Whether options are being loaded. (default: `false`) -}
loading : Bool -> Html.Attribute msg
loading val_ =
    Html.Attributes.property "loading" (Json.Encode.bool val_)


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel : String -> Html.Attribute msg
loadingLabel val_ =
    Html.Attributes.attribute "loading-label" val_


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> Html.Attribute msg
lowered val_ =
    Html.Attributes.property "lowered" (Json.Encode.bool val_)


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> Html.Attribute msg
maxDepth val_ =
    Html.Attributes.property "maxDepth" (Json.Encode.float val_)


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> Html.Attribute msg
maxRows val_ =
    Html.Attributes.property "maxRows" (Json.Encode.float val_)


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
minAttr : Float -> Html.Attribute msg
minAttr val_ =
    Html.Attributes.property "min" (Json.Encode.float val_)


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> Html.Attribute msg
minRows val_ =
    Html.Attributes.property "minRows" (Json.Encode.float val_)


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal : Bool -> Html.Attribute msg
modal val_ =
    Html.Attributes.property "modal" (Json.Encode.bool val_)


{-| Values for the `mode` attribute. -}
type Mode
    = ModeDocked
    | Fullscreen
    | Buffer
    | Determinate
    | Indeterminate
    | Query
    | ModeAuto
    | Compact
    | Expanded
    | ModeContains
    | ModeEndsWith
    | ModeStartsWith


{-| The behavior mode of the view. (default: `"docked"`) -}
mode : Mode -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" (modeToString val_)


{-| Render the `mode` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
modeToString : Mode -> String
modeToString val_ =
    case val_ of
        ModeDocked ->
            "docked"
    
        Fullscreen ->
            "fullscreen"
    
        Buffer ->
            "buffer"
    
        Determinate ->
            "determinate"
    
        Indeterminate ->
            "indeterminate"
    
        Query ->
            "query"
    
        ModeAuto ->
            "auto"
    
        Compact ->
            "compact"
    
        Expanded ->
            "expanded"
    
        ModeContains ->
            "contains"
    
        ModeEndsWith ->
            "ends-with"
    
        ModeStartsWith ->
            "starts-with"


{-| Values for the `motion` attribute. -}
type Motion
    = MotionExpressive
    | MotionStandard


{-| The motion scheme. (default: `"standard"`) -}
motion : Motion -> Html.Attribute msg
motion val_ =
    Html.Attributes.attribute "motion" (motionToString val_)


{-| Render the `motion` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
motionToString : Motion -> String
motionToString val_ =
    case val_ of
        MotionExpressive ->
            "expressive"
    
        MotionStandard ->
            "standard"


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


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


{-| Whether to disable animation. (default: `false`) -}
noAnimate : Bool -> Html.Attribute msg
noAnimate val_ =
    Html.Attributes.property "noAnimate" (Json.Encode.bool val_)


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel : String -> Html.Attribute msg
noDataLabel val_ =
    Html.Attributes.attribute "no-data-label" val_


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap : Bool -> Html.Attribute msg
noFocusTrap val_ =
    Html.Attributes.property "noFocusTrap" (Json.Encode.bool val_)


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize : Float -> Html.Attribute msg
opticalSize val_ =
    Html.Attributes.property "opticalSize" (Json.Encode.float val_)


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> Html.Attribute msg
optional val_ =
    Html.Attributes.property "optional" (Json.Encode.bool val_)


{-| Values for the `orientation` attribute. -}
type Orientation
    = OrientationAuto
    | OrientationHorizontal
    | OrientationVertical


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation : Orientation -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" (orientationToString val_)


{-| Render the `orientation` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
orientationToString : Orientation -> String
orientationToString val_ =
    case val_ of
        OrientationAuto ->
            "auto"
    
        OrientationHorizontal ->
            "horizontal"
    
        OrientationVertical ->
            "vertical"


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.property "overshootLimit" (Json.Encode.float val_)


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex : Float -> Html.Attribute msg
pageIndex val_ =
    Html.Attributes.property "pageIndex" (Json.Encode.float val_)


{-| The number of items to display in a page. (default: `50`) -}
pageSize : String -> Html.Attribute msg
pageSize val_ =
    Html.Attributes.attribute "page-size" val_


{-| Values for the `page-size-variant` attribute. -}
type PageSizeVariant
    = PageSizeVariantFilled
    | PageSizeVariantOutlined


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant : PageSizeVariant -> Html.Attribute msg
pageSizeVariant val_ =
    Html.Attributes.attribute "page-size-variant" (pageSizeVariantToString val_)


{-| Render the `page-size-variant` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
pageSizeVariantToString : PageSizeVariant -> String
pageSizeVariantToString val_ =
    case val_ of
        PageSizeVariantFilled ->
            "filled"
    
        PageSizeVariantOutlined ->
            "outlined"


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes : String -> Html.Attribute msg
pageSizes val_ =
    Html.Attributes.attribute "page-sizes" val_


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass : String -> Html.Attribute msg
panelClass val_ =
    Html.Attributes.attribute "panel-class" val_


{-| Values for the `position` attribute. -}
type Position
    = PositionAbove
    | AboveAfter
    | AboveBefore
    | PositionAfter
    | PositionBefore
    | PositionBelow
    | BelowAfter
    | BelowBefore


{-| The position of the tooltip. (default: `"below"`) -}
position : Position -> Html.Attribute msg
position val_ =
    Html.Attributes.attribute "position" (positionToString val_)


{-| Render the `position` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
positionToString : Position -> String
positionToString val_ =
    case val_ of
        PositionAbove ->
            "above"
    
        AboveAfter ->
            "above-after"
    
        AboveBefore ->
            "above-before"
    
        PositionAfter ->
            "after"
    
        PositionBefore ->
            "before"
    
        PositionBelow ->
            "below"
    
        BelowAfter ->
            "below-after"
    
        BelowBefore ->
            "below-before"


{-| Values for the `position-x` attribute. -}
type PositionX
    = PositionXAfter
    | PositionXBefore


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX : PositionX -> Html.Attribute msg
positionX val_ =
    Html.Attributes.attribute "position-x" (positionXToString val_)


{-| Render the `position-x` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
positionXToString : PositionX -> String
positionXToString val_ =
    case val_ of
        PositionXAfter ->
            "after"
    
        PositionXBefore ->
            "before"


{-| Values for the `position-y` attribute. -}
type PositionY
    = PositionYAbove
    | PositionYBelow


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY : PositionY -> Html.Attribute msg
positionY val_ =
    Html.Attributes.attribute "position-y" (positionYToString val_)


{-| Render the `position-y` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
positionYToString : PositionY -> String
positionYToString val_ =
    case val_ of
        PositionYAbove ->
            "above"
    
        PositionYBelow ->
            "below"


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


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius : Float -> Html.Attribute msg
radius val_ =
    Html.Attributes.property "radius" (Json.Encode.float val_)


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> Html.Attribute msg
range val_ =
    Html.Attributes.property "range" (Json.Encode.bool val_)


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


{-| Whether the chip is removable. (default: `false`) -}
removable : Bool -> Html.Attribute msg
removable val_ =
    Html.Attributes.property "removable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel : String -> Html.Attribute msg
removeLabel val_ =
    Html.Attributes.attribute "remove-label" val_


{-| Whether the element is required. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| The value to return from the dialog. (default: `""`) -}
returnValue : String -> Html.Attribute msg
returnValue val_ =
    Html.Attributes.attribute "return-value" val_


{-| Values for the `scheme` attribute. -}
type Scheme
    = SchemeAuto
    | Dark
    | Light


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme : Scheme -> Html.Attribute msg
scheme val_ =
    Html.Attributes.attribute "scheme" (schemeToString val_)


{-| Render the `scheme` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
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


{-| Render the `scroll-strategy` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
scrollStrategyToString : ScrollStrategy -> String
scrollStrategyToString val_ =
    case val_ of
        Hide ->
            "hide"
    
        Reposition ->
            "reposition"


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary : Bool -> Html.Attribute msg
secondary val_ =
    Html.Attributes.property "secondary" (Json.Encode.bool val_)


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex : Float -> Html.Attribute msg
selectedIndex val_ =
    Html.Attributes.property "selectedIndex" (Json.Encode.float val_)


{-| Values for the `shape` attribute. -}
type Shape
    = ShapeAuto
    | Circular
    | ShapeRounded
    | Square


{-| The shape of the toolbar. (default: `"square"`) -}
shape : Shape -> Html.Attribute msg
shape val_ =
    Html.Attributes.attribute "shape" (shapeToString val_)


{-| Render the `shape` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
shapeToString : Shape -> String
shapeToString val_ =
    case val_ of
        ShapeAuto ->
            "auto"
    
        Circular ->
            "circular"
    
        ShapeRounded ->
            "rounded"
    
        Square ->
            "square"


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "showDelay" (Json.Encode.float val_)


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons : Bool -> Html.Attribute msg
showFirstLastButtons val_ =
    Html.Attributes.property "showFirstLastButtons" (Json.Encode.bool val_)


{-| Values for the `size` attribute. -}
type Size
    = ExtraLarge
    | ExtraSmall
    | Large
    | SizeMedium
    | Small


{-| The size of the button. (default: `"small"`) -}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


{-| Render the `size` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
sizeToString : Size -> String
sizeToString val_ =
    case val_ of
        ExtraLarge ->
            "extra-large"
    
        ExtraSmall ->
            "extra-small"
    
        Large ->
            "large"
    
        SizeMedium ->
            "medium"
    
        Small ->
            "small"


{-| Whether the start drawer is open. (default: `false`) -}
start : Bool -> Html.Attribute msg
start val_ =
    Html.Attributes.property "start" (Json.Encode.bool val_)


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider : Bool -> Html.Attribute msg
startDivider val_ =
    Html.Attributes.property "startDivider" (Json.Encode.bool val_)


{-| Values for the `start-mode` attribute. -}
type StartMode
    = StartModeAuto
    | StartModeOver
    | StartModePush
    | StartModeSide


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode : StartMode -> Html.Attribute msg
startMode val_ =
    Html.Attributes.attribute "start-mode" (startModeToString val_)


{-| Render the `start-mode` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
startModeToString : StartMode -> String
startModeToString val_ =
    case val_ of
        StartModeAuto ->
            "auto"
    
        StartModeOver ->
            "over"
    
        StartModePush ->
            "push"
    
        StartModeSide ->
            "side"


{-| Values for the `start-view` attribute. -}
type StartView
    = Month
    | MultiYear
    | Year


{-| The initial view used to select a date. (default: `"month"`) -}
startView : StartView -> Html.Attribute msg
startView val_ =
    Html.Attributes.attribute "start-view" (startViewToString val_)


{-| Render the `start-view` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
startViewToString : StartView -> String
startViewToString val_ =
    case val_ of
        Month ->
            "month"
    
        MultiYear ->
            "multi-year"
    
        Year ->
            "year"


{-| Values for the `state` attribute. -}
type State
    = StateContent
    | Loading
    | NoData


{-| The state for which to present content. (default: `"content"`) -}
state : State -> Html.Attribute msg
state val_ =
    Html.Attributes.attribute "state" (stateToString val_)


{-| Render the `state` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
stateToString : State -> String
stateToString val_ =
    case val_ of
        StateContent ->
            "content"
    
        Loading ->
            "loading"
    
        NoData ->
            "no-data"


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step : Float -> Html.Attribute msg
step val_ =
    Html.Attributes.property "step" (Json.Encode.float val_)


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch : Bool -> Html.Attribute msg
stretch val_ =
    Html.Attributes.property "stretch" (Json.Encode.bool val_)


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus : Bool -> Html.Attribute msg
strongFocus val_ =
    Html.Attributes.property "strongFocus" (Json.Encode.bool val_)


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu : Bool -> Html.Attribute msg
submenu val_ =
    Html.Attributes.property "submenu" (Json.Encode.bool val_)


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| The search term to highlight. (default: `""`) -}
term : String -> Html.Attribute msg
term val_ =
    Html.Attributes.attribute "term" val_


{-| Whether to present thin scrollbars. (default: `false`) -}
thin : Bool -> Html.Attribute msg
thin val_ =
    Html.Attributes.property "thin" (Json.Encode.bool val_)


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold : Float -> Html.Attribute msg
threshold val_ =
    Html.Attributes.property "threshold" (Json.Encode.float val_)


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
    = ToggleDirectionHorizontal
    | ToggleDirectionVertical


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection : ToggleDirection -> Html.Attribute msg
toggleDirection val_ =
    Html.Attributes.attribute "toggle-direction" (toggleDirectionToString val_)


{-| Render the `toggle-direction` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
toggleDirectionToString : ToggleDirection -> String
toggleDirectionToString val_ =
    case val_ of
        ToggleDirectionHorizontal ->
            "horizontal"
    
        ToggleDirectionVertical ->
            "vertical"


{-| Values for the `toggle-position` attribute. -}
type TogglePosition
    = TogglePositionAfter
    | TogglePositionBefore


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition : TogglePosition -> Html.Attribute msg
togglePosition val_ =
    Html.Attributes.attribute "toggle-position" (togglePositionToString val_)


{-| Render the `toggle-position` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
togglePositionToString : TogglePosition -> String
togglePositionToString val_ =
    case val_ of
        TogglePositionAfter ->
            "after"
    
        TogglePositionBefore ->
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


{-| Render the `touch-gestures` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
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


{-| Render the `type` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
typeToString : Type -> String
typeToString val_ =
    case val_ of
        Button ->
            "button"
    
        Reset ->
            "reset"
    
        Submit ->
            "submit"


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded : Bool -> Html.Attribute msg
unbounded val_ =
    Html.Attributes.property "unbounded" (Json.Encode.bool val_)


{-| A string representing the value of the switch. (default: `"on"`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `variant` attribute. -}
type Variant
    = VariantContent
    | VariantExpressive
    | Fidelity
    | FruitSalad
    | Monochrome
    | Neutral
    | Rainbow
    | TonalSpot
    | Flat
    | Wavy
    | Vibrant
    | Contained
    | Uncontained
    | Segmented
    | VariantRounded
    | Sharp
    | Display
    | Headline
    | Label
    | Title
    | Primary
    | PrimaryContainer
    | Secondary
    | SecondaryContainer
    | Surface
    | Tertiary
    | TertiaryContainer
    | VariantAuto
    | VariantDocked
    | Modal
    | Connected
    | VariantStandard
    | Elevated
    | Text
    | Tonal
    | VariantFilled
    | VariantOutlined


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


{-| Render the `variant` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
variantToString : Variant -> String
variantToString val_ =
    case val_ of
        VariantContent ->
            "content"
    
        VariantExpressive ->
            "expressive"
    
        Fidelity ->
            "fidelity"
    
        FruitSalad ->
            "fruit-salad"
    
        Monochrome ->
            "monochrome"
    
        Neutral ->
            "neutral"
    
        Rainbow ->
            "rainbow"
    
        TonalSpot ->
            "tonal-spot"
    
        Flat ->
            "flat"
    
        Wavy ->
            "wavy"
    
        Vibrant ->
            "vibrant"
    
        Contained ->
            "contained"
    
        Uncontained ->
            "uncontained"
    
        Segmented ->
            "segmented"
    
        VariantRounded ->
            "rounded"
    
        Sharp ->
            "sharp"
    
        Display ->
            "display"
    
        Headline ->
            "headline"
    
        Label ->
            "label"
    
        Title ->
            "title"
    
        Primary ->
            "primary"
    
        PrimaryContainer ->
            "primary-container"
    
        Secondary ->
            "secondary"
    
        SecondaryContainer ->
            "secondary-container"
    
        Surface ->
            "surface"
    
        Tertiary ->
            "tertiary"
    
        TertiaryContainer ->
            "tertiary-container"
    
        VariantAuto ->
            "auto"
    
        VariantDocked ->
            "docked"
    
        Modal ->
            "modal"
    
        Connected ->
            "connected"
    
        VariantStandard ->
            "standard"
    
        Elevated ->
            "elevated"
    
        Text ->
            "text"
    
        Tonal ->
            "tonal"
    
        VariantFilled ->
            "filled"
    
        VariantOutlined ->
            "outlined"


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : String -> Html.Attribute msg
weight val_ =
    Html.Attributes.attribute "weight" val_


{-| Values for the `width` attribute. -}
type Width
    = Default
    | Narrow
    | Wide


{-| The width of the button. (default: `"default"`) -}
width : Width -> Html.Attribute msg
width val_ =
    Html.Attributes.attribute "width" (widthToString val_)


{-| Render the `width` value as the string the element observes — exposed so a consumer building its own introspectable attribute/IR can reuse the typed mapping instead of re-stringifying by hand. -}
widthToString : Width -> String
widthToString val_ =
    case val_ of
        Default ->
            "default"
    
        Narrow ->
            "narrow"
    
        Wide ->
            "wide"


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> Html.Attribute msg
wrap val_ =
    Html.Attributes.property "wrap" (Json.Encode.bool val_)


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents : Bool -> Html.Attribute msg
wrapDetents val_ =
    Html.Attributes.property "wrapDetents" (Json.Encode.bool val_)