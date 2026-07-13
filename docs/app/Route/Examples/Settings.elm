module Route.Examples.Settings exposing (ActionData, Data, Model, Msg, route)

{-| **Settings** — a self-contained, full-viewport system settings screen built
almost entirely from `M3e.*` components. It demonstrates adaptive navigation
(a `NavRail` on desktop, a bottom `NavBar` on mobile) around an `AppBar` and a
scrollable, width-constrained column of sectioned preference groups.

Each section is a `Kit.Surface` card (surface-container role, large corners) with
an overline heading and a run of `ListItem` rows divided by `Divider`s. Trailing
controls are real components: `Switch`es for toggles, a `Radio` group for theme,
a `Slider` for density, and chevron `Icon`s for drill-in rows. Color, type, and
shape all come from the kit; Tailwind is used only for layout.

-}

import BackendTask
import Effect exposing (Effect)
import ExampleNav
import Head
import Kit
import Kit.Avatar as Avatar
import Kit.Shape as Shape
import Kit.Surface as Surface
import Layout
import M3e
import Markup.Kind
import Markup.Element as Element exposing (Element)
import M3e.Kind
import M3e.Token as Value
import Native
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)



-- MODEL -----------------------------------------------------------------------


{-| `section` and `theme` are held as `String` ids rather than custom types: the
`NoMissingTypeExpose` review rule would require any custom type reachable from
this exposed `Model` alias to be exposed too (the same reason `RouteParams` is
suppressed for every route). Keeping them as strings keeps the module's public
API to what elm-pages needs. The screen is presentational, so the ids are just
selection markers.
-}
type alias Model =
    { section : String
    , push : Bool
    , email : Bool
    , sms : Bool
    , analytics : Bool
    , crashReports : Bool
    , personalized : Bool
    , theme : String
    }


type Toggle
    = Push
    | Email
    | Sms
    | Analytics
    | CrashReports
    | Personalized


type Msg
    = SelectSection String
    | Flip Toggle
    | SetTheme String



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
    ( { section = "general"
      , push = True
      , email = True
      , sms = False
      , analytics = False
      , crashReports = True
      , personalized = True
      , theme = "system"
      }
    , Effect.none
    )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SelectSection section ->
            ( { model | section = section }, Effect.none )

        SetTheme theme ->
            ( { model | theme = theme }, Effect.none )

        Flip toggle ->
            ( flip toggle model, Effect.none )


flip : Toggle -> Model -> Model
flip toggle model =
    case toggle of
        Push ->
            { model | push = not model.push }

        Email ->
            { model | email = not model.email }

        Sms ->
            { model | sms = not model.sms }

        Analytics ->
            { model | analytics = not model.analytics }

        CrashReports ->
            { model | crashReports = not model.crashReports }

        Personalized ->
            { model | personalized = not model.personalized }


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []



-- VIEW ------------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Settings · elm-m3e"
    , body =
        [ Element.toNode (screen model) ]
    }


{-| The full-viewport shell: a desktop nav rail beside a main column, with a
mobile bottom bar. `h-screen`/`overflow-hidden` pin the chrome so only the
content column scrolls.
-}
screen : Model -> Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } (PagesMsg Msg)
screen model =
    Surface.view Surface.surface
        [ Layout.class "flex h-screen w-full overflow-hidden" ]
        [ desktopRail model.section
        , Layout.div "flex flex-1 flex-col overflow-hidden"
            [ appBar
            , Layout.div "flex-1 overflow-y-auto"
                [ Layout.div "mx-auto w-full max-w-2xl flex flex-col gap-6 px-4 py-6 pb-24 md:pb-6"
                    (content model)
                , exampleFooter
                ]
            ]
        , mobileBar model.section
        ]


{-| The shared "Built from" + prev/next strip. Settings is the last example, so
it has no next screen.
-}
exampleFooter : Element { s | html : M3e.Kind.Brand, sharedLink : Markup.Kind.Shared } msg
exampleFooter =
    ExampleNav.footer
        { builtFrom =
            [ ( "appbar", "AppBar" )
            , ( "navrail", "NavRail" )
            , ( "navbar", "NavBar" )
            , ( "listitem", "ListItem" )
            , ( "switch", "Switch" )
            , ( "radio", "Radio" )
            , ( "slider", "Slider" )
            , ( "divider", "Divider" )
            ]
        , prev = Just ( "/examples/travel", "Travel" )
        , next = Just ( "/examples/list-detail", "List-detail" )
        }


appBar : Element { s | appBar : M3e.Kind.Brand } msg
appBar =
    M3e.appBar [ M3e.sizeMedium ]
        [ M3e.appBarSlotLeading (M3e.icon [ M3e.attrName "menu" ] [])
        , M3e.appBarSlotTitle (Kit.text "Settings")
        ]



-- NAVIGATION ------------------------------------------------------------------


sections : List ( String, String, String )
sections =
    [ ( "general", "General", "tune" )
    , ( "account", "Account", "account_circle" )
    , ( "notifications", "Notifications", "notifications" )
    , ( "privacy", "Privacy", "shield" )
    , ( "about", "About", "info" )
    ]


{-| Desktop navigation rail — hidden below the `md` breakpoint.
-}
desktopRail : String -> Element { s | navRail : M3e.Kind.Brand } (PagesMsg Msg)
desktopRail current =
    M3e.navRail [ Layout.class "hidden md:flex shrink-0" ]
        (List.map (navItem current) sections)


{-| Mobile bottom navigation bar — hidden at `md` and up, pinned to the viewport
bottom so it stays put while the content scrolls.
-}
mobileBar : String -> Element { s | navBar : M3e.Kind.Brand } (PagesMsg Msg)
mobileBar current =
    M3e.navBar [ Layout.class "md:hidden fixed inset-x-0 bottom-0" ]
        (List.map (navItem current) sections)


navItem : String -> ( String, String, String ) -> Element { s | navItem : M3e.Kind.Brand } (PagesMsg Msg)
navItem current ( section, name, iconName ) =
    M3e.navItem
        [ M3e.attrSelected (section == current)
        , Native.onClick (PagesMsg.fromMsg (SelectSection section))
        ]
        [ M3e.navItemSlotIcon (M3e.icon [ M3e.attrName iconName ] [])
        , Kit.text name
        ]



-- CONTENT ---------------------------------------------------------------------


{-| The element kind a card row can be. `ListItem` rows carry `listItem`, the
interleaved `Divider`s carry `divider`, and a few rows nest raw layout (`html`);
they must share ONE type to live in a single list, so `Row` names the union of
every field any row needs. Each producing function's `view` returns an open row,
which widens to fill this closed record.
-}
type alias Row msg =
    Element { html : M3e.Kind.Brand, listItem : M3e.Kind.Brand, divider : M3e.Kind.Brand } msg


content : Model -> List (Element { s | html : M3e.Kind.Brand } (PagesMsg Msg))
content model =
    [ accountCard
    , sectionCard "Notifications"
        [ switchRow "notifications" "Push notifications" "Alerts on this device" model.push (Flip Push)
        , switchRow "mail" "Email updates" "Product news and receipts" model.email (Flip Email)
        , switchRow "sms" "SMS alerts" "Security codes and reminders" model.sms (Flip Sms)
        ]
    , sectionCard "Appearance"
        [ themeRow "light" "Light" "light_mode" model.theme
        , themeRow "dark" "Dark" "dark_mode" model.theme
        , themeRow "system" "System" "brightness_auto" model.theme
        , densityRow
        ]
    , sectionCard "Privacy"
        [ switchRow "analytics" "Usage analytics" "Share anonymous usage data" model.analytics (Flip Analytics)
        , switchRow "bug_report" "Crash reports" "Send diagnostics after a crash" model.crashReports (Flip CrashReports)
        , switchRow "recommend" "Personalized content" "Tailor suggestions to you" model.personalized (Flip Personalized)
        ]
    , sectionCard "About"
        [ linkRow "description" "Terms of Service" "Last updated May 2026"
        , linkRow "policy" "Privacy Policy" "How we handle your data"
        , infoRow "verified" "Version" "3.0.1 (build 4021)"
        ]
    ]


{-| A settings section: an overline heading above a rounded surface-container card
whose `ListItem` rows are separated by `Divider`s.
-}
sectionCard : String -> List (Row (PagesMsg Msg)) -> Element { s | html : M3e.Kind.Brand } (PagesMsg Msg)
sectionCard heading rows =
    Layout.div "flex flex-col gap-2"
        [ Kit.overline [ Kit.onSurfaceVariant ] [ Kit.text heading ]
        , Surface.view Surface.surfaceContainer
            [ Shape.corner Shape.large, Layout.class "overflow-hidden flex flex-col" ]
            (dividize rows)
        ]


{-| Interleave `Divider`s between rows so groups read as one card.
-}
dividize : List (Row msg) -> List (Row msg)
dividize rows =
    List.intersperse (M3e.divider [ M3e.attrInset True ] []) rows


{-| The account header: a profile card (avatar + name + email) followed by a
drill-in row for managing the account.
-}
accountCard : Element { s | html : M3e.Kind.Brand } (PagesMsg Msg)
accountCard =
    Layout.div "flex flex-col gap-2"
        [ Kit.overline [ Kit.onSurfaceVariant ] [ Kit.text "Account" ]
        , Surface.view Surface.surfaceContainer
            [ Shape.corner Shape.large, Layout.class "overflow-hidden flex flex-col" ]
            (dividize
                [ M3e.listItem []
                    [ M3e.listItemSlotLeading (Avatar.initials "JD")
                    , Kit.text "Jane Doe"
                    , M3e.listItemSlotSupportingText (Kit.text "jane@example.com")
                    , M3e.listItemSlotTrailing (M3e.icon [ M3e.attrName "chevron_right" ] [])
                    ]
                , linkRow "manage_accounts" "Manage account" "Password, 2FA, connected apps"
                , linkRow "sync" "Sync & backup" "Last synced 2 minutes ago"
                ]
            )
        ]


{-| A toggle row: leading icon, label + supporting text, trailing `Switch`.
-}
switchRow : String -> String -> String -> Bool -> Msg -> Row (PagesMsg Msg)
switchRow iconName label supporting on toggle =
    M3e.listItem []
        [ M3e.listItemSlotLeading (M3e.icon [ M3e.attrName iconName ] [])
        , Kit.text label
        , M3e.listItemSlotSupportingText (Kit.text supporting)
        , M3e.listItemSlotTrailing
            (M3e.switch
                [ M3e.ariaLabel label
                , M3e.attrChecked on
                , Native.onClick (PagesMsg.fromMsg toggle)
                ]
                []
            )
        ]


{-| A theme-choice row backed by a `Radio` (single group via shared `name`).
-}
themeRow : String -> String -> String -> String -> Row (PagesMsg Msg)
themeRow theme label iconName current =
    M3e.listItem []
        [ M3e.listItemSlotLeading (M3e.icon [ M3e.attrName iconName ] [])
        , Kit.text label
        , M3e.listItemSlotTrailing
            (M3e.radio
                [ M3e.ariaLabel label
                , M3e.attrName "theme"
                , M3e.attrValue theme
                , M3e.attrChecked (theme == current)
                , Native.onClick (PagesMsg.fromMsg (SetTheme theme))
                ]
                []
            )
        ]


{-| A density row whose control is a full-width `Slider`. A `Slider` is not list
supporting-text, so this row is a plain layout (leading icon + label above the
slider) rather than a `ListItem` with the control crammed into a text slot.
-}
densityRow : Row msg
densityRow =
    Layout.colWith "flex flex-col gap-3 px-4 py-3"
        [ Layout.rowWith "flex items-center gap-4"
            [ M3e.icon [ M3e.attrName "density_medium" ] []
            , Kit.text "Display density"
            ]
        , M3e.slider
            [ M3e.attrMin 0
            , M3e.attrMax 3
            , M3e.attrStep 1
            , M3e.attrDiscrete True
            , M3e.attrLabelled True
            , M3e.ariaLabel "Display density"
            , Layout.class "w-full"
            ]
            [ M3e.sliderThumb [ M3e.attrValueFloat 2 ] [] ]
        ]


{-| A drill-in row: label + supporting text with a trailing chevron.
-}
linkRow : String -> String -> String -> Row msg
linkRow iconName label supporting =
    M3e.listItem []
        [ M3e.listItemSlotLeading (M3e.icon [ M3e.attrName iconName ] [])
        , Kit.text label
        , M3e.listItemSlotSupportingText (Kit.text supporting)
        , M3e.listItemSlotTrailing (M3e.icon [ M3e.attrName "chevron_right" ] [])
        ]


{-| A static info row: label with a trailing value tinted as a variant.
-}
infoRow : String -> String -> String -> Row msg
infoRow iconName label value =
    M3e.listItem []
        [ M3e.listItemSlotLeading (M3e.icon [ M3e.attrName iconName ] [])
        , Kit.text label
        , M3e.listItemSlotTrailing
            (Kit.labelText Value.large [ Kit.onSurfaceVariant ] [ Kit.text value ])
        ]
