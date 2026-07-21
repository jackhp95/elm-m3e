module Route.Examples.ListDetail exposing (ActionData, Data, Model, Msg, route)

{-| **List-detail** — the canonical Material 3 adaptive list-detail (master-detail)
pattern, built as a self-contained contacts screen. It is the worked reference the
`composing-m3e-layouts` skill points at for this pattern.

The body reflows by window size class. On `md:` and up it is two panes side by side:
a fixed-width `M3e.List` of contacts (`md:w-80`) beside a filling detail pane. Below
`md:` the two collapse into one column — the list is full-width and the selected
contact's detail stacks beneath it — the standard compact fallback for list-detail.

Navigation switches the same way every example does: an `M3e.NavRail` on desktop
(`hidden md:flex`), an `M3e.NavBar` pinned to the bottom on mobile
(`md:hidden fixed inset-x-0 bottom-0`), one shared destination list and one `navItem`
producer so the two copies never drift.

Tailwind is layout only (flex/grid/gap/padding/positioning/responsive visibility);
every visual token — color, typography, surface, shape — comes through the `Kit` /
`Kit.Surface` / `Kit.Shape` seam.

-}

import BackendTask
import Effect exposing (Effect)
import ExampleNav
import Head
import Kit
import Kit.Avatar as Avatar
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e
import HtmlIr.Kind
import HtmlIr.Element exposing (Element)
import M3e.Kind
import M3e.Values as Value
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)



-- MODEL -----------------------------------------------------------------------


type alias Model =
    { selected : Int }


type Msg
    = SelectContact Int



-- ROUTE -----------------------------------------------------------------------


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { selected = 0 }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SelectContact i ->
            ( { model | selected = i }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []



-- DATA ------------------------------------------------------------------------


type alias Contact =
    { name : String
    , initials : String
    , role : String
    , email : String
    , phone : String
    , note : String
    }


contacts : List Contact
contacts =
    [ { name = "Ali Connors", initials = "AC", role = "Product designer", email = "ali@example.com", phone = "+1 555 0142", note = "Leads the M3 Expressive motion pass. Prefers async updates." }
    , { name = "Trevor Hansen", initials = "TH", role = "Data analyst", email = "trevor@example.com", phone = "+1 555 0198", note = "Owns the rally dashboard. Ping before 3pm for chart reviews." }
    , { name = "Sandra Adams", initials = "SA", role = "Engineering lead", email = "sandra@example.com", phone = "+1 555 0110", note = "Reviews the component library PRs. Two-week release cadence." }
    , { name = "Britta Holt", initials = "BH", role = "Content strategist", email = "britta@example.com", phone = "+1 555 0176", note = "Writes the release notes and the guide prose." }
    , { name = "Miriam Steketee", initials = "MS", role = "Accessibility", email = "miriam@example.com", phone = "+1 555 0155", note = "Runs the a11y-tree spot-checks each cycle." }
    ]


{-| The four navigation destinations, with their Material Symbols icon name.
-}
destinations : List { icon : String, label : String }
destinations =
    [ { icon = "contacts", label = "Contacts" }
    , { icon = "groups", label = "Teams" }
    , { icon = "star", label = "Favorites" }
    , { icon = "history", label = "Recent" }
    ]



-- VIEW ------------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "List-detail · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode (HtmlIr.Element.map PagesMsg.fromMsg (screen model)) ]
    }


{-| The full-viewport shell: a desktop rail beside a column of AppBar + two-pane
body, with a mobile bottom bar. `h-screen`/`overflow-hidden` pin the chrome so
only the panes scroll.
-}
screen : Model -> Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ Msg
screen model =
    Surface.view Surface.surface
        [ Layout.class "flex h-screen w-full overflow-hidden" ]
        [ desktopRail
        , Layout.colWith "flex flex-1 flex-col min-w-0 overflow-hidden"
            [ appBar
            , body model
            , exampleFooter
            ]
        , mobileBar
        ]


exampleFooter : Element { s | html : M3e.Kind.Brand, sharedLink : HtmlIr.Kind.Shared } adm_ msg
exampleFooter =
    ExampleNav.footer
        { builtFrom =
            [ ( "appbar", "AppBar" )
            , ( "navrail", "NavRail" )
            , ( "navbar", "NavBar" )
            , ( "list", "List" )
            , ( "listitem", "ListItem" )
            , ( "divider", "Divider" )
            , ( "avatar", "Avatar" )
            ]
        , prev = Just ( "/examples/settings", "Settings" )
        , next = Just ( "/examples/supporting-pane", "Supporting pane" )
        }


appBar : Element { s | appBar : M3e.Kind.Brand } adm_ msg
appBar =
    M3e.appBar []
        [ M3e.appBarSlotTitle (Kit.text "Contacts") ]



-- TWO-PANE BODY ---------------------------------------------------------------


{-| The reflowing list-detail body. `flex-1 flex-col md:flex-row` is the whole
adaptivity: a single column on compact (list, then detail beneath), two panes on
`md:` and up (a fixed `md:w-80` list beside a filling detail). Both panes scroll
independently.
-}
body : Model -> Element { s | html : M3e.Kind.Brand } adm_ Msg
body model =
    Layout.div "flex flex-1 flex-col overflow-hidden md:flex-row"
        [ listPane model.selected
        , detailPane (selectedContact model.selected)
        ]


{-| The master list — full-width on compact, a fixed rail on `md:`.
-}
listPane : Int -> Element { s | html : M3e.Kind.Brand, list : M3e.Kind.Brand } adm_ Msg
listPane selected =
    Layout.div "shrink-0 overflow-y-auto border-outline-variant/40 md:w-80 md:border-r"
        [ M3e.list []
            (List.intersperse (M3e.divider [ M3e.attrInset True ] [])
                (List.indexedMap (contactRow selected) contacts)
            )
        ]


{-| One row. The selected row swaps to a `surfaceContainer` role (a Surface-role
token swap, not a background class) so the active item reads against the base
surface. `ListItem` is a passive display component, so the click affordance is
added the userland way: a `role="button"` and a `Native.onClick` (see the Mail
example — the `@m3e/web` list item does not carry an interactive/onClick fact).
-}
contactRow : Int -> Int -> Contact -> Element { s | listItem : M3e.Kind.Brand } adm_ Msg
contactRow selected index contact =
    let
        rowSurface : Surface
        rowSurface =
            if index == selected then
                Surface.surfaceContainer

            else
                Surface.surface
    in
    M3e.listItem
        [ Surface.asAttribute rowSurface
        , Layout.class "cursor-pointer"
        , Native.attribute "role" "button"
        , Native.onClick (SelectContact index)
        ]
        [ M3e.listItemSlotLeading (Avatar.initials contact.initials)
        , Kit.text contact.name
        , M3e.listItemSlotSupportingText (Kit.text contact.role)
        ]


{-| The detail pane — fills the rest on `md:`, stacks beneath the list on compact.
-}
detailPane : Contact -> Element { s | html : M3e.Kind.Brand } adm_ msg
detailPane contact =
    Layout.div "flex-1 overflow-y-auto p-4 md:p-8"
        [ Layout.div "mx-auto flex w-full max-w-xl flex-col gap-6"
            [ header contact
            , detailCard contact
            ]
        ]


header : Contact -> Element { s | html : M3e.Kind.Brand } adm_ msg
header contact =
    Layout.colWith "flex flex-col items-center gap-3 pt-2"
        [ Avatar.initials contact.initials
        , Kit.headline Value.small [ Kit.onSurface ] [ Kit.text contact.name ]
        , Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text contact.role ]
        ]


{-| The contact's fields, as a surface-container card of divided rows.
-}
detailCard : Contact -> Element { s | html : M3e.Kind.Brand } adm_ msg
detailCard contact =
    Surface.view Surface.surfaceContainer
        [ Shape.corner Shape.large, Layout.class "overflow-hidden flex flex-col" ]
        (List.intersperse (M3e.divider [ M3e.attrInset True ] [])
            [ fieldRow "mail" "Email" contact.email
            , fieldRow "call" "Phone" contact.phone
            , fieldRow "sticky_note_2" "Note" contact.note
            ]
        )


fieldRow : String -> String -> String -> Element { s | listItem : M3e.Kind.Brand } adm_ msg
fieldRow iconName label value =
    M3e.listItem []
        [ M3e.listItemSlotLeading (M3e.icon [ M3e.attrName iconName ] [])
        , Kit.text label
        , M3e.listItemSlotSupportingText (Kit.text value)
        ]


selectedContact : Int -> Contact
selectedContact index =
    contacts
        |> List.drop index
        |> List.head
        |> Maybe.withDefault fallbackContact


fallbackContact : Contact
fallbackContact =
    { name = "No contact", initials = "?", role = "", email = "", phone = "", note = "" }



-- NAVIGATION ------------------------------------------------------------------


desktopRail : Element { s | navRail : M3e.Kind.Brand } adm_ msg
desktopRail =
    M3e.navRail [ Layout.class "hidden md:flex shrink-0" ]
        (List.map navItem destinations)


mobileBar : Element { s | navBar : M3e.Kind.Brand } adm_ msg
mobileBar =
    M3e.navBar [ Layout.class "md:hidden fixed inset-x-0 bottom-0" ]
        (List.map navItem destinations)


navItem : { icon : String, label : String } -> Element { s | navItem : M3e.Kind.Brand } adm_ msg
navItem d =
    M3e.navItem
        [ M3e.attrSelected (d.label == "Contacts") ]
        [ M3e.navItemSlotIcon (M3e.icon [ M3e.attrName d.icon ] [])
        , Kit.text d.label
        ]
