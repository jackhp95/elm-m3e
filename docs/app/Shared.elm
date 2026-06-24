module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

{-| The M3 application shell that frames every docs route.

It owns the single `<m3e-theme>` for the whole app (mirroring matraic, where the
shell itself is a Material 3 app — see `research/visual-gap.md`), renders a top
app bar with the live theme controls and a persistent left sidebar with the
matraic-style information architecture, and applies the M3 surface + type scale
to the document via `style.css`.

-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr exposing (attribute, class, href)
import Html.Events
import Json.Decode as Decode
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
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


{-| Text direction toggle (drives the `dir` attribute on the shell). -}
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
                    [ Html.map toMsg (appBar model)
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


appBar : Model -> Html Msg
appBar model =
    Html.header
        [ class "sticky top-0 z-30 flex items-center gap-3 border-b border-outline-variant bg-surface-container px-4 py-3 shadow-md-level1" ]
        [ Html.button
            [ Html.Events.onClick MenuClicked
            , class "md:hidden grid h-10 w-10 place-items-center rounded-full text-on-surface hover:bg-surface-container-high"
            , attribute "aria-label" "Toggle navigation"
            ]
            [ symbol "menu" ]
        , Html.a
            [ href "/", class "flex items-center gap-2 no-underline" ]
            [ Html.span [ class "grid h-8 w-8 place-items-center rounded-md-corner-medium bg-primary text-on-primary text-title-medium font-semibold" ]
                [ Html.text "M3" ]
            , Html.span [ class "text-title-large font-medium text-on-surface" ] [ Html.text "elm-m3e" ]
            ]
        , Html.span [ class "rounded-full bg-secondary-container px-2 py-0.5 text-label-small text-on-secondary-container" ]
            [ Html.text "M3 Expressive" ]
        , Html.div [ class "ml-auto flex items-center gap-1" ]
            [ schemeQuickToggle model
            , Html.div [ class "relative" ]
                [ Html.button
                    [ Html.Events.onClick ToggleSettings
                    , class "grid h-10 w-10 place-items-center rounded-full text-on-surface hover:bg-surface-container-high"
                    , attribute "aria-label" "Theme settings"
                    , attribute "aria-expanded"
                        (if model.settingsOpen then
                            "true"

                         else
                            "false"
                        )
                    ]
                    [ symbol "tune" ]
                , if model.settingsOpen then
                    settingsPanel model

                  else
                    Html.text ""
                ]
            , Html.a
                [ href "https://github.com/jackhp95/m3e-builder"
                , attribute "target" "_blank"
                , attribute "rel" "noreferrer"
                , class "grid h-10 w-10 place-items-center rounded-full text-on-surface hover:bg-surface-container-high no-underline"
                , attribute "aria-label" "GitHub repository"
                ]
                [ symbol "code" ]
            ]
        ]


schemeQuickToggle : Model -> Html Msg
schemeQuickToggle model =
    let
        ( next, icon ) =
            case model.scheme of
                Theme.Light ->
                    ( Theme.Dark, "dark_mode" )

                Theme.Dark ->
                    ( Theme.Auto, "brightness_auto" )

                Theme.Auto ->
                    ( Theme.Light, "light_mode" )
    in
    Html.button
        [ Html.Events.onClick (SetScheme next)
        , class "grid h-10 w-10 place-items-center rounded-full text-on-surface hover:bg-surface-container-high"
        , attribute "aria-label" "Cycle color scheme"
        ]
        [ symbol icon ]



-- SETTINGS PANEL (the matraic settings cluster, wired to the single m3e-theme)


settingsPanel : Model -> Html Msg
settingsPanel model =
    Html.div
        [ class "absolute right-0 top-12 z-40 w-72 rounded-md-corner-large border border-outline-variant bg-surface-container-high p-4 shadow-md-level3 space-y-4" ]
        [ Html.p [ class "text-title-small font-medium text-on-surface" ] [ Html.text "Theme settings" ]
        , settingGroup "Color scheme"
            [ segmented
                [ ( "Light", model.scheme == Theme.Light, SetScheme Theme.Light )
                , ( "System", model.scheme == Theme.Auto, SetScheme Theme.Auto )
                , ( "Dark", model.scheme == Theme.Dark, SetScheme Theme.Dark )
                ]
            ]
        , settingGroup "Contrast"
            [ segmented
                [ ( "Standard", model.contrast == Theme.Standard, SetContrast Theme.Standard )
                , ( "Medium", model.contrast == Theme.Medium, SetContrast Theme.Medium )
                , ( "High", model.contrast == Theme.High, SetContrast Theme.High )
                ]
            ]
        , settingGroup "Source color"
            [ Html.div [ class "flex items-center gap-3" ]
                [ Html.input
                    [ Attr.type_ "color"
                    , Attr.value model.seed
                    , Html.Events.onInput SetSeed
                    , class "h-9 w-12 cursor-pointer rounded border border-outline-variant bg-transparent"
                    , attribute "aria-label" "Source color"
                    ]
                    []
                , Html.code [ class "text-body-small text-on-surface-variant" ] [ Html.text model.seed ]
                ]
            ]
        , settingGroup "Density"
            [ segmented
                [ ( "0", model.density == 0, SetDensity 0 )
                , ( "-1", model.density == -1, SetDensity -1 )
                , ( "-2", model.density == -2, SetDensity -2 )
                , ( "-3", model.density == -3, SetDensity -3 )
                ]
            ]
        , settingGroup "Direction"
            [ segmented
                [ ( "LTR", model.dir == Ltr, SetDirection Ltr )
                , ( "RTL", model.dir == Rtl, SetDirection Rtl )
                ]
            ]
        ]


settingGroup : String -> List (Html Msg) -> Html Msg
settingGroup label children =
    Html.div [ class "space-y-1.5" ]
        (Html.p [ class "text-label-medium text-on-surface-variant" ] [ Html.text label ] :: children)


segmented : List ( String, Bool, Msg ) -> Html Msg
segmented options =
    Html.div [ class "flex overflow-hidden rounded-full border border-outline" ]
        (List.map
            (\( label, selected, msg ) ->
                Html.button
                    [ Html.Events.onClick msg
                    , class
                        ("flex-1 px-3 py-1.5 text-label-medium "
                            ++ (if selected then
                                    "bg-secondary-container text-on-secondary-container"

                                else
                                    "text-on-surface-variant hover:bg-surface-container-highest"
                               )
                        )
                    ]
                    [ Html.text label ]
            )
            options
        )



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
        (List.map (navGroup currentPath) navSections
            ++ [ componentsGroup currentPath
               , navGroup currentPath
                    { title = "Reference"
                    , items = [ ( "/reference", "Full API reference" ) ]
                    }
               ]
        )


navGroup : String -> NavSection -> Html Msg
navGroup currentPath section =
    Html.div [ class "mb-5" ]
        [ Html.p [ class "px-3 pb-1 text-label-large font-medium uppercase tracking-wide text-on-surface-variant" ]
            [ Html.text section.title ]
        , Html.ul [ class "space-y-0.5" ]
            (List.map (navLink currentPath) section.items)
        ]


componentsGroup : String -> Html Msg
componentsGroup currentPath =
    Html.div [ class "mb-5" ]
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
`data/reference.json` (drives the dynamic `/components/:name` route). -}
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



-- ICON HELPER


symbol : String -> Html msg
symbol name =
    Html.span
        [ class "material-symbols-outlined", attribute "aria-hidden" "true" ]
        [ Html.text name ]
