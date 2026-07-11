module M3e.Datepicker exposing
    ( view, variant, clearable, date, maxDate, minDate
    , range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
    , nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
    , confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle
    )

{-| Presents a date picker on a temporary surface.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the selected date changes.
  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

<!-- elm-cem:docmeta category=Text inputs -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld1" (Native.node Html.label [ Native.attribute "for" "fld1" ] [ Kit.text "Date Field" ]), M3e.FormField.control "fld1" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld1" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "datepicker" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Datepicker.variant M3e.Token.auto, M3e.Attributes.id "datepicker" ] []
    ]
```

<!-- elm-cem:example title="Variants" -->
```elm
M3e.Datepicker.view [ M3e.Datepicker.variant M3e.Token.auto ] []
```

<!-- elm-cem:example title="Date selection" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld8" (Native.node Html.label [ Native.attribute "for" "fld8" ] [ Kit.text "Date Field" ]), M3e.FormField.control "fld8" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld8" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "picker5" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Datepicker.variant M3e.Token.auto, M3e.Attributes.id "picker5", M3e.Datepicker.date "2026-01-01", M3e.Datepicker.clearable True ] []
    ]
```

<!-- elm-cem:example title="Start date" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld7" (Native.node Html.label [ Native.attribute "for" "fld7" ] [ Kit.text "Date Field" ]), M3e.FormField.control "fld7" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld7" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "picker4" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Datepicker.variant M3e.Token.auto, M3e.Attributes.id "picker4", M3e.Datepicker.startAt "2026-01-01" ] []
    ]
```

<!-- elm-cem:example title="Start view" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld6" (Native.node Html.label [ Native.attribute "for" "fld6" ] [ Kit.text "Date Field" ]), M3e.FormField.control "fld6" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld6" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "picker3" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Datepicker.variant M3e.Token.auto, M3e.Attributes.id "picker3", M3e.Datepicker.startView M3e.Token.multiYear ] []
    ]
```

<!-- elm-cem:example title="Date ranges" -->
```elm
[ M3e.FormField.view [ M3e.Attributes.id "range-field", M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld5" (Native.node Html.label [ Native.attribute "for" "fld5" ] [ Kit.text "Date Range Field" ]), M3e.FormField.control "fld5" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld5" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "date-range" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY - MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Attributes.id "date-range", M3e.Datepicker.rangeStart "2026-01-01", M3e.Datepicker.rangeEnd "2026-01-09", M3e.Datepicker.startAt "2026-01-01" ] []
    ]
```

<!-- elm-cem:example title="Min and max dates" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld4" (Native.node Html.label [ Native.attribute "for" "fld4" ] [ Kit.text "Date Field" ]), M3e.FormField.control "fld4" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld4" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "picker1" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Attributes.id "picker1", M3e.Datepicker.startAt "2026-04-01", M3e.Datepicker.minDate "2026-01-01", M3e.Datepicker.maxDate "2026-04-30" ] []
    ]
```

<!-- elm-cem:example title="Blackout dates" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld3" (Native.node Html.label [ Native.attribute "for" "fld3" ] [ Kit.text "Date Field" ]), M3e.FormField.control "fld3" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld3" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "blackout-dates" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Datepicker.variant M3e.Token.auto, M3e.Attributes.id "blackout-dates" ] []
    ]
```

<!-- elm-cem:example title="Special dates" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld2" (Native.node Html.label [ Native.attribute "for" "fld2" ] [ Kit.text "Date Field" ]), M3e.FormField.control "fld2" (Native.node Html.input [ Native.attribute "autocomplete" "off", Native.attribute "id" "fld2" ] []), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "calendar_today" ] [], M3e.DatepickerToggle.view [ M3e.DatepickerToggle.for "special-dates" ] [] ]), M3e.FormField.hint (Native.span [] [ Kit.text "MM/DD/YYYY" ]) ]
    , M3e.Datepicker.view [ M3e.Datepicker.variant M3e.Token.auto, M3e.Attributes.id "special-dates", M3e.Datepicker.startAt "2026-04-01" ] []
    ]
```

@docs view, variant, clearable, date, maxDate, minDate
@docs range, rangeEnd, rangeStart, startAt, startView, previousMonthLabel
@docs nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel, clearLabel
@docs confirmLabel, dismissLabel, label, onChange, onBeforetoggle, onToggle

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Datepicker
import M3e.Node
import M3e.Token


{-| Build the `<m3e-datepicker>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , clearable : M3e.Token.Supported
            , date : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , range : M3e.Token.Supported
            , rangeEnd : M3e.Token.Supported
            , rangeStart : M3e.Token.Supported
            , startAt : M3e.Token.Supported
            , startView : M3e.Token.Supported
            , previousMonthLabel : M3e.Token.Supported
            , nextMonthLabel : M3e.Token.Supported
            , previousYearLabel : M3e.Token.Supported
            , nextYearLabel : M3e.Token.Supported
            , previousMultiYearLabel : M3e.Token.Supported
            , nextMultiYearLabel : M3e.Token.Supported
            , clearLabel : M3e.Token.Supported
            , confirmLabel : M3e.Token.Supported
            , dismissLabel : M3e.Token.Supported
            , label : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | datepicker : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Datepicker.datepicker
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the picker. (default: `"docked"`)
-}
variant :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , docked : M3e.Token.Supported
        , modal : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.Datepicker.variant


{-| Whether the user can clear the selected date and close the picker. (default: `false`)
-}
clearable : Bool -> M3e.Html.Attr.Attr { c | clearable : M3e.Token.Supported } msg
clearable =
    M3e.Html.Datepicker.clearable


{-| The selected date. (default: `null`)
-}
date : String -> M3e.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    M3e.Html.Datepicker.date


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> M3e.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    M3e.Html.Datepicker.maxDate


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> M3e.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    M3e.Html.Datepicker.minDate


{-| Whether a range of dates can be selected. (default: `false`)
-}
range : Bool -> M3e.Html.Attr.Attr { c | range : M3e.Token.Supported } msg
range =
    M3e.Html.Datepicker.range


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> M3e.Html.Attr.Attr { c | rangeEnd : M3e.Token.Supported } msg
rangeEnd =
    M3e.Html.Datepicker.rangeEnd


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> M3e.Html.Attr.Attr { c | rangeStart : M3e.Token.Supported } msg
rangeStart =
    M3e.Html.Datepicker.rangeStart


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> M3e.Html.Attr.Attr { c | startAt : M3e.Token.Supported } msg
startAt =
    M3e.Html.Datepicker.startAt


{-| The initial view used to select a date. (default: `"month"`)
-}
startView :
    M3e.Token.Value
        { month : M3e.Token.Supported
        , multiYear : M3e.Token.Supported
        , year : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | startView : M3e.Token.Supported } msg
startView =
    M3e.Html.Datepicker.startView


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousMonthLabel : M3e.Token.Supported } msg
previousMonthLabel =
    M3e.Html.Datepicker.previousMonthLabel


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMonthLabel : M3e.Token.Supported } msg
nextMonthLabel =
    M3e.Html.Datepicker.nextMonthLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | previousYearLabel : M3e.Token.Supported } msg
previousYearLabel =
    M3e.Html.Datepicker.previousYearLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel : String -> M3e.Html.Attr.Attr { c | nextYearLabel : M3e.Token.Supported } msg
nextYearLabel =
    M3e.Html.Datepicker.nextYearLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel :
    String
    ->
        M3e.Html.Attr.Attr
            { c
                | previousMultiYearLabel : M3e.Token.Supported
            }
            msg
previousMultiYearLabel =
    M3e.Html.Datepicker.previousMultiYearLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel :
    String
    -> M3e.Html.Attr.Attr { c | nextMultiYearLabel : M3e.Token.Supported } msg
nextMultiYearLabel =
    M3e.Html.Datepicker.nextMultiYearLabel


{-| The label given to the button used clear the selected date and close the picker. (default: `"Clear"`)
-}
clearLabel : String -> M3e.Html.Attr.Attr { c | clearLabel : M3e.Token.Supported } msg
clearLabel =
    M3e.Html.Datepicker.clearLabel


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`)
-}
confirmLabel : String -> M3e.Html.Attr.Attr { c | confirmLabel : M3e.Token.Supported } msg
confirmLabel =
    M3e.Html.Datepicker.confirmLabel


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`)
-}
dismissLabel : String -> M3e.Html.Attr.Attr { c | dismissLabel : M3e.Token.Supported } msg
dismissLabel =
    M3e.Html.Datepicker.dismissLabel


{-| The label given to the the picker. (default: `"Select date"`)
-}
label : String -> M3e.Html.Attr.Attr { c | label : M3e.Token.Supported } msg
label =
    M3e.Html.Datepicker.label


{-| Listen for `change` events.
-}
onChange :
    (String -> msg)
    -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Datepicker.onChange


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.Datepicker.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.Datepicker.onToggle
