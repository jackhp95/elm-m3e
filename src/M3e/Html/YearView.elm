module M3e.Html.YearView exposing
    ( yearView, active, today, date, activeDate, minDate
    , maxDate, onChange, onActiveChange
    )

{-| Middle layer for `<m3e-year-view>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.YearView` module for everyday use.

@docs yearView, active, today, date, activeDate, minDate
@docs maxDate, onChange, onActiveChange

-}

import Html
import Json.Decode
import M3e.Raw.YearView
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An internal component used to display a single year in a calendar.

**Component Info:**

  - **Extends:** `CalendarViewElementBase` from `/src/calendar/CalendarViewElementBase`

**Events:**

  - `change`: No description
  - `active-change`: No description

-}
yearView :
    List
        (Markup.Html.Attr.Attr
            { active : M3e.Token.Supported
            , today : M3e.Token.Supported
            , date : M3e.Token.Supported
            , activeDate : M3e.Token.Supported
            , minDate : M3e.Token.Supported
            , maxDate : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onActiveChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
yearView attributes children =
    M3e.Raw.YearView.yearView
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the view is active. (default: `false`)
-}
active : Bool -> Markup.Html.Attr.Attr { c | active : M3e.Token.Supported } msg
active =
    Markup.Html.Attr.Internal.attribute M3e.Raw.YearView.active


{-| Today's date. (default: `new Date()`)
-}
today : String -> Markup.Html.Attr.Attr { c | today : M3e.Token.Supported } msg
today =
    Markup.Html.Attr.Internal.attribute M3e.Raw.YearView.today


{-| The selected date. (default: `null`)
-}
date : String -> Markup.Html.Attr.Attr { c | date : M3e.Token.Supported } msg
date =
    Markup.Html.Attr.Internal.attribute M3e.Raw.YearView.date


{-| The active date. (default: `new Date()`)
-}
activeDate : String -> Markup.Html.Attr.Attr { c | activeDate : M3e.Token.Supported } msg
activeDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.YearView.activeDate


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Markup.Html.Attr.Attr { c | minDate : M3e.Token.Supported } msg
minDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.YearView.minDate


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Markup.Html.Attr.Attr { c | maxDate : M3e.Token.Supported } msg
maxDate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.YearView.maxDate


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.YearView.onChange
        (Json.Decode.succeed f_)


{-| Listen for `active-change` events.
-}
onActiveChange :
    msg
    -> Markup.Html.Attr.Attr { c | onActiveChange : M3e.Token.Supported } msg
onActiveChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.YearView.onActiveChange
        (Json.Decode.succeed f_)
