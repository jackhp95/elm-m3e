module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

{-| The M3 application shell that frames every docs route.

Owns the single `<m3e-theme>` for the whole app, renders a real `Ui.AppBar`
top app bar with the live theme controls in an outlined `Ui.Card` popover,
and a persistent left sidebar mirroring matraic's IA. Every icon goes
through `Ui.Icon`; every action through `Ui.IconButton`; every theme
toggle through `Ui.SegmentedButton`.

-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr exposing (attribute, class, href)
import Html.Events
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import Ui.AppBar as AppBar
import Ui.Card as Card
import Ui.Divider as Divider
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.SegmentedButton as SegmentedButton
import Ui.Theme as Theme
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just (\_ -> CloseMenu)
    }



-- MODEL


type alias Model =
    { showMenu : Bool
    , scheme : Theme.Scheme
    , seed : String
    , contrast : Theme.Contrast
    , density : Float
    , dir : Direction
    , settingsOpen : Bool
    }


{-| Text direction toggle (drives the `dir` attribute on the shell).
-}
type Direction
    = Ltr
    | Rtl


type alias Data =
    ()


type Msg
    = SharedMsg SharedMsg
    | MenuClicked
    | CloseMenu
    | ToggleSettings
    | SetScheme Theme.Scheme
    | SetSeed String
    | SetContrast Theme.Contrast
    | SetDensity Float
    | SetDirection Direction


type SharedMsg
    = NoOp


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init _ _ =
    ( { showMenu = False
      , scheme = Theme.Auto
      , seed = "#6750A4"
      , contrast = Theme.Standard
      , density = 0
      , dir = Ltr
      , settingsOpen = False
      }
    , Effect.none
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg _ ->
            ( model, Effect.none )

        MenuClicked ->
            ( { model | showMenu = not model.showMenu }, Effect.none )

        CloseMenu ->
            ( { model | showMenu = False }, Effect.none )

        ToggleSettings ->
            ( { model | settingsOpen = not model.settingsOpen }, Effect.none )

        SetScheme scheme ->
            ( { model | scheme = scheme }, Effect.none )

        SetSeed seed ->
            ( { model | seed = seed }, Effect.none )

        SetContrast contrast ->
            ( { model | contrast = contrast }, Effect.none )

        SetDensity density ->
            ( { model | density = density }, Effect.none )

        SetDirection dir ->
            ( { model | dir = dir }, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()



-- VIEW


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view _ page model toMsg pageView =
    { title = pageView.title
    , body =
        [ Theme.new
            |> Theme.withSeedColor model.seed
            |> Theme.withScheme model.scheme
            |> Theme.withContrast model.contrast
            |> Theme.withDensity model.density
            |> Theme.view
                [ Html.div
                    [ class "grid min-h-screen grid-rows-[auto_1fr] bg-surface text-on-surface"
                    , attribute "dir" (directionAttr model.dir)
                    ]
                    [ Html.map toMsg (appShellBar model)
                    , Html.div [ class "grid grid-cols-1 md:grid-cols-[16rem_1fr] min-h-0" ]
                        [ Html.map toMsg (sidebar model page)
                        , Html.main_ [ class "min-w-0 px-6 py-10 md:px-10" ] pageView.body
                        ]
                    ]
                ]
        ]
    }


normalizePath : String -> String
normalizePath path =
    if path /= "/" && String.endsWith "/" path then
        String.dropRight 1 path

    else
        path


directionAttr : Direction -> String
directionAttr dir =
    case dir of
        Ltr ->
            "ltr"

        Rtl ->
            "rtl"



-- TOP APP BAR


appShellBar : Model -> Html Msg
appShellBar model =
    Html.header
        [ class "sticky top-0 z-30 border-b border-outline-variant bg-surface-container shadow-md-level1" ]
        [ AppBar.new "elm-m3e"
            |> AppBar.withId "docs-app-bar"
            |> AppBar.withSize AppBar.Small
            |> AppBar.withLeading (menuButton model)
            |> AppBar.withTrailing
                [ schemeQuickToggle model
                , settingsTrigger model
                , githubLink
                ]
            |> AppBar.view
        ]


menuButton : Model -> Html Msg
menuButton _ =
    Html.div [ class "md:hidden" ]
        [ IconButton.new
            { icon = Icon.material "menu"
            , label = "Toggle navigation"
            , variant = IconButton.Standard
            }
            |> IconButton.withOnClick MenuClicked
            |> IconButton.view
        ]


githubLink : Html Msg
githubLink =
    Html.a
        [ href "https://github.com/jackhp95/m3e-builder"
        , attribute "target" "_blank"
        , attribute "rel" "noreferrer"
        , class "no-underline"
        , attribute "aria-label" "GitHub repository"
        ]
        [ IconButton.new
            { icon = Icon.material "code"
            , label = "GitHub repository"
            , variant = IconButton.Standard
            }
            |> IconButton.view
        ]


schemeQuickToggle : Model -> Html Msg
schemeQuickToggle model =
    let
        ( next, iconName, label ) =
            case model.scheme of
                Theme.Light ->
                    ( Theme.Dark, "dark_mode", "Switch to dark mode" )

                Theme.Dark ->
                    ( Theme.Auto, "brightness_auto", "Use system color scheme" )

                Theme.Auto ->
                    ( Theme.Light, "light_mode", "Switch to light mode" )
    in
    IconButton.new
        { icon = Icon.material iconName
        , label = label
        , variant = IconButton.Standard
        }
        |> IconButton.withOnClick (SetScheme next)
        |> IconButton.view



-- SETTINGS POPOVER (anchored to a relative-positioned wrapper)


settingsTrigger : Model -> Html Msg
settingsTrigger model =
    Html.div [ class "relative" ]
        [ IconButton.new
            { icon = Icon.material "tune"
            , label = "Theme settings"
            , variant = IconButton.Standard
            }
            |> IconButton.withOnClick ToggleSettings
            |> IconButton.view
        , if model.settingsOpen then
            settingsPanel model

          else
            Html.text ""
        ]


settingsPanel : Model -> Html Msg
settingsPanel model =
    Html.div [ class "absolute right-0 top-12 z-40 w-72" ]
        [ Card.new Card.Filled
            |> Card.withHeadline "Theme settings"
            |> Card.withBody (settingsBody model)
            |> Card.view
        ]


settingsBody : Model -> Html Msg
settingsBody model =
    Html.div [ class "space-y-4" ]
        [ schemeSegmented model
        , contrastSegmented model
        , seedColorInput model
        , densitySegmented model
        , directionSegmented model
        ]


schemeSegmented : Model -> Html Msg
schemeSegmented model =
    SegmentedButton.single
        { label = "Color scheme"
        , segments =
            [ SegmentedButton.segment { value = Theme.Light, label = "Light" }
            , SegmentedButton.segment { value = Theme.Auto, label = "System" }
            , SegmentedButton.segment { value = Theme.Dark, label = "Dark" }
            ]
        , selected = Just model.scheme
        , onChange = SetScheme
        }
        |> SegmentedButton.withId "docs-scheme"
        |> SegmentedButton.view


contrastSegmented : Model -> Html Msg
contrastSegmented model =
    SegmentedButton.single
        { label = "Contrast"
        , segments =
            [ SegmentedButton.segment { value = Theme.Standard, label = "Standard" }
            , SegmentedButton.segment { value = Theme.Medium, label = "Medium" }
            , SegmentedButton.segment { value = Theme.High, label = "High" }
            ]
        , selected = Just model.contrast
        , onChange = SetContrast
        }
        |> SegmentedButton.withId "docs-contrast"
        |> SegmentedButton.view


seedColorInput : Model -> Html Msg
seedColorInput model =
    Html.div [ class "space-y-1.5" ]
        [ Html.label
            [ Attr.for "docs-seed", class "block text-label-medium text-on-surface-variant" ]
            [ Html.text "Source color" ]
        , Html.div [ class "flex items-center gap-3" ]
            [ Html.input
                [ Attr.type_ "color"
                , Attr.id "docs-seed"
                , Attr.value model.seed
                , Html.Events.onInput SetSeed
                , class "h-9 w-12 cursor-pointer rounded border border-outline-variant bg-transparent"
                , attribute "aria-label" "Source color"
                ]
                []
            , Html.code [ class "text-body-small text-on-surface-variant" ] [ Html.text model.seed ]
            ]
        ]


densitySegmented : Model -> Html Msg
densitySegmented model =
    SegmentedButton.single
        { label = "Density"
        , segments =
            [ SegmentedButton.segment { value = 0, label = "0" }
            , SegmentedButton.segment { value = -1, label = "-1" }
            , SegmentedButton.segment { value = -2, label = "-2" }
            , SegmentedButton.segment { value = -3, label = "-3" }
            ]
        , selected = Just model.density
        , onChange = SetDensity
        }
        |> SegmentedButton.withId "docs-density"
        |> SegmentedButton.view


directionSegmented : Model -> Html Msg
directionSegmented model =
    SegmentedButton.single
        { label = "Direction"
        , segments =
            [ SegmentedButton.segment { value = Ltr, label = "LTR" }
            , SegmentedButton.segment { value = Rtl, label = "RTL" }
            ]
        , selected = Just model.dir
        , onChange = SetDirection
        }
        |> SegmentedButton.withId "docs-direction"
        |> SegmentedButton.view



-- SIDEBAR NAVIGATION (matraic IA)


type alias NavSection =
    { title : String, items : List ( String, String ) }


navSections : List NavSection
navSections =
    [ { title = "Getting Started"
      , items =
            [ ( "/getting-started/overview", "Overview" )
            , ( "/getting-started/installation", "Installation" )
            , ( "/getting-started/browser-support", "Browser Support" )
            ]
      }
    , { title = "Styles"
      , items =
            [ ( "/styles/color", "Color" )
            , ( "/styles/typography", "Typography" )
            , ( "/styles/density", "Density" )
            , ( "/styles/motion", "Motion" )
            , ( "/styles/shape", "Shape" )
            ]
      }
    , { title = "Studies"
      , items =
            [ ( "/studies", "Overview" )
            , ( "/studies/reply", "Reply" )
            , ( "/studies/shrine", "Shrine" )
            , ( "/studies/rally", "Rally" )
            , ( "/studies/crane", "Crane" )
            , ( "/studies/settings", "Settings" )
            ]
      }
    ]


sidebar : Model -> { path : UrlPath, route : Maybe Route } -> Html Msg
sidebar model page =
    let
        currentPath =
            normalizePath (UrlPath.toAbsolute page.path)
    in
    Html.nav
        [ class
            ("md:block md:sticky md:top-[57px] md:h-[calc(100vh-57px)] overflow-y-auto border-r border-outline-variant bg-surface-container-low px-3 py-4 "
                ++ (if model.showMenu then
                        "block"

                    else
                        "hidden"
                   )
            )
        ]
        (List.intersperse sidebarDivider
            (List.map (navGroup currentPath) navSections
                ++ [ componentsGroup currentPath
                   , navGroup currentPath
                        { title = "Reference"
                        , items = [ ( "/reference", "Full API reference" ) ]
                        }
                   ]
            )
        )


sidebarDivider : Html Msg
sidebarDivider =
    Html.div [ class "my-2 px-2" ]
        [ Divider.new |> Divider.view ]


navGroup : String -> NavSection -> Html Msg
navGroup currentPath section =
    Html.div []
        [ Html.p [ class "px-3 pb-1 text-label-large font-medium uppercase tracking-wide text-on-surface-variant" ]
            [ Html.text section.title ]
        , Html.ul [ class "space-y-0.5" ]
            (List.map (navLink currentPath) section.items)
        ]


componentsGroup : String -> Html Msg
componentsGroup currentPath =
    Html.div []
        [ Html.p [ class "px-3 pb-1 text-label-large font-medium uppercase tracking-wide text-on-surface-variant" ]
            [ Html.text "Components" ]
        , Html.ul [ class "max-h-72 space-y-0.5 overflow-y-auto pr-1" ]
            (List.map
                (\( slug, label ) ->
                    navLink currentPath ( "/components/" ++ slug, label )
                )
                componentList
            )
        ]


navLink : String -> ( String, String ) -> Html Msg
navLink currentPath ( path, label ) =
    let
        active =
            currentPath == path
    in
    Html.li []
        [ Html.a
            [ href path
            , class
                ("block rounded-full px-3 py-1.5 text-body-medium no-underline "
                    ++ (if active then
                            "bg-secondary-container text-on-secondary-container font-medium"

                        else
                            "text-on-surface-variant hover:bg-surface-container hover:text-on-surface"
                       )
                )
            ]
            [ Html.text label ]
        ]


{-| (slug, label) for every documented component, kept in sync with
`data/reference.json` (drives the dynamic `/components/:name` route).
-}
componentList : List ( String, String )
componentList =
    [ ( "appbar", "App Bar" )
    , ( "avatar", "Avatar" )
    , ( "badge", "Badge" )
    , ( "bottomsheet", "Bottom Sheet" )
    , ( "breadcrumb", "Breadcrumb" )
    , ( "button", "Button" )
    , ( "buttongroup", "Button Group" )
    , ( "calendar", "Calendar" )
    , ( "card", "Card" )
    , ( "carousel", "Carousel" )
    , ( "checkbox", "Checkbox" )
    , ( "chip", "Chips" )
    , ( "datepicker", "Date Picker" )
    , ( "dialog", "Dialog" )
    , ( "disclosure", "Disclosure" )
    , ( "divider", "Divider" )
    , ( "extendedfab", "Extended FAB" )
    , ( "fab", "FAB" )
    , ( "fabmenu", "FAB Menu" )
    , ( "heading", "Heading" )
    , ( "icon", "Icon" )
    , ( "iconbutton", "Icon Button" )
    , ( "list", "List" )
    , ( "loadingindicator", "Loading Indicator" )
    , ( "menu", "Menu" )
    , ( "navigationbar", "Navigation Bar" )
    , ( "navigationdrawer", "Navigation Drawer" )
    , ( "navigationrail", "Navigation Rail" )
    , ( "paginator", "Paginator" )
    , ( "progress", "Progress" )
    , ( "radiobutton", "Radio Button" )
    , ( "scrollcontainer", "Scroll Container" )
    , ( "search", "Search" )
    , ( "segmentedbutton", "Segmented Button" )
    , ( "select", "Select" )
    , ( "shape", "Shape" )
    , ( "sidesheet", "Side Sheet" )
    , ( "skeleton", "Skeleton" )
    , ( "slide", "Slide Group" )
    , ( "slider", "Slider" )
    , ( "snackbar", "Snackbar" )
    , ( "splitbutton", "Split Button" )
    , ( "splitpane", "Split Pane" )
    , ( "stepper", "Stepper" )
    , ( "switch", "Switch" )
    , ( "tabs", "Tabs" )
    , ( "textfield", "Text Field" )
    , ( "texthighlight", "Text Highlight" )
    , ( "theme", "Theme" )
    , ( "timepicker", "Time Picker" )
    , ( "toc", "TOC" )
    , ( "toolbar", "Toolbar" )
    , ( "tooltip", "Tooltip" )
    ]
