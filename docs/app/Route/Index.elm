module Route.Index exposing (ActionData, Data, Model, Msg, route)

{-| Documentation home for `m3e-builder` — the type-safe, MISI Elm builder
layer (`Ui.*`) over matraic's `@m3e/web` Material 3 Expressive web components.

Every example below is written with the **real library modules**, so the Elm
compiler type-checks the whole page.
-}

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, a, code, div, h1, h2, h3, li, nav, p, pre, section, span, text, ul)
import Html.Attributes exposing (attribute, class, href, id)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Ui.Avatar as Avatar
import Ui.Icon as Icon
import Ui.ScrollContainer as ScrollContainer
import Ui.Shape as Shape
import Ui.Skeleton as Skeleton
import Ui.Snackbar as Snackbar
import Ui.Theme as Theme
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed {}


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image =
            { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-m3e"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Type-safe Material 3 Expressive web components for Elm."
        , locale = Nothing
        , title = "elm-m3e · type-safe Material 3 Expressive for Elm"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "elm-m3e · type-safe Material 3 Expressive for Elm"
    , body =
        [ Html.node "m3e-theme"
            [ attribute "color" "#6750A4"
            , attribute "scheme" "auto"
            , attribute "contrast" "standard"
            , class "block min-h-screen bg-surface text-on-surface"
            ]
            [ div [ class "mx-auto max-w-6xl px-6 py-12" ]
                [ hero
                , statusBanner
                , div [ class "mt-12 grid grid-cols-1 lg:grid-cols-[14rem_1fr] gap-10" ]
                    [ sidebar
                    , div [ class "min-w-0 space-y-16" ] sectionsList
                    ]
                ]
            ]
        ]
    }



-- PAGE CHROME


hero : Html msg
hero =
    div [ class "space-y-3" ]
        [ p [ class "text-label-large uppercase tracking-wide text-primary" ]
            [ text "elm-m3e · m3e-builder" ]
        , h1 [ class "text-display-small font-semibold text-on-surface" ]
            [ text "Type-safe Material 3 Expressive for Elm" ]
        , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
            [ text "A Make-Impossible-States-Impossible builder layer over matraic's "
            , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-medium" ] [ text "@m3e/web" ]
            , text " web components. Typed-to-child slots, builders with required collaborators, one module per documented m3e component — invalid compositions don't compile, and there are no silent no-ops."
            ]
        ]


statusBanner : Html msg
statusBanner =
    div [ class "mt-8 rounded-xl border border-outline-variant bg-surface-container-low p-5" ]
        [ p [ class "text-title-medium font-medium text-on-surface" ] [ text "v0.1 — complete library, docs in progress" ]
        , p [ class "mt-1 text-body-medium text-on-surface-variant" ]
            [ text "All 54 component modules now compile against the "
            , code [ class "rounded bg-surface-container px-1 text-body-small" ] [ text "elm-m3e" ]
            , text " bindings — the whole library. 8 are documented in detail below; per-component pages for the rest are in progress. The generator ("
            , code [ class "rounded bg-surface-container px-1 text-body-small" ] [ text "elm-cem" ]
            , text ") resolves TS aliases to real per-component enums ("
            , code [ class "rounded bg-surface-container px-1 text-body-small" ] [ text "variant : Variant -> Attribute" ]
            , text ") and exposes shared attributes per-component."
            ]
        ]


sidebar : Html msg
sidebar =
    nav [ class "lg:sticky lg:top-12 h-max" ]
        [ a
            [ href "/reference"
            , class "mb-5 block rounded-lg bg-primary px-4 py-2.5 text-label-large font-medium text-on-primary hover:opacity-90"
            ]
            [ text "Full reference — all 54 →" ]
        , p [ class "text-label-large uppercase tracking-wide text-on-surface-variant" ] [ text "Documented" ]
        , ul [ class "mt-3 space-y-1" ]
            (List.map navItem
                [ ( "shape", "Shape" )
                , ( "icon", "Icon" )
                , ( "avatar", "Avatar" )
                , ( "skeleton", "Skeleton" )
                , ( "scroll-container", "Scroll container" )
                , ( "snackbar", "Snackbar" )
                , ( "theme", "Theme" )
                , ( "size", "Size" )
                , ( "status", "Status & roadmap" )
                ]
            )
        ]


navItem : ( String, String ) -> Html msg
navItem ( anchor, label ) =
    li []
        [ a
            [ href ("#" ++ anchor)
            , class "block rounded-md px-3 py-1.5 text-body-medium text-on-surface-variant hover:bg-surface-container hover:text-on-surface"
            ]
            [ text label ]
        ]


sectionsList : List (Html msg)
sectionsList =
    [ shapeSection
    , iconSection
    , avatarSection
    , skeletonSection
    , scrollContainerSection
    , snackbarSection
    , themeSection
    , sizeSection
    , statusSection
    ]



-- SECTION SCAFFOLDING


type alias Doc msg =
    { anchor : String
    , title : String
    , tagline : String
    , whenToUse : String
    , demo : Html msg
    , source : String
    }


docSection : Doc msg -> Html msg
docSection d =
    section [ id d.anchor, class "scroll-mt-12 border-t border-outline-variant pt-12" ]
        [ h2 [ class "text-headline-medium font-semibold text-on-surface" ] [ text d.title ]
        , p [ class "mt-2 max-w-2xl text-body-large text-on-surface-variant" ] [ text d.tagline ]
        , whenToUseNote d.whenToUse
        , demoPanel [ d.demo ]
        , codeBlock d.source
        ]


whenToUseNote : String -> Html msg
whenToUseNote copy =
    div [ class "mt-5 rounded-lg border-l-4 border-primary bg-surface-container-high px-4 py-3" ]
        [ span [ class "text-label-large font-medium text-on-surface" ] [ text "When to use — " ]
        , span [ class "text-body-medium text-on-surface-variant" ] [ text copy ]
        ]


demoPanel : List (Html msg) -> Html msg
demoPanel children =
    div [ class "mt-5 rounded-xl border border-outline-variant bg-surface-container-lowest p-8" ] children


codeBlock : String -> Html msg
codeBlock src =
    pre [ class "mt-4 overflow-x-auto rounded-xl bg-surface-container p-4 text-body-small leading-relaxed text-on-surface" ]
        [ code [] [ text (String.trim src) ] ]


swatch : List (Html msg) -> Html msg
swatch =
    div [ class "flex flex-col items-center gap-2 text-label-small text-on-surface-variant" ]



-- SHAPE


shapeSection : Html msg
shapeSection =
    docSection
        { anchor = "shape"
        , title = "Shape"
        , tagline = "A decorative surface for emphasis and flair. Size and corners come from utility classes; the element supplies the M3 shape styling."
        , whenToUse = "reach for Shape to add a contained splash of colour, a media frame, or a decorative element. It is presentational — interactive surfaces belong to Button, Card, or Chip."
        , demo =
            div [ class "flex flex-wrap items-end gap-6" ]
                [ swatch
                    [ Shape.new |> Shape.withClass "block w-16 h-16 bg-primary rounded-md-corner-large" |> Shape.view
                    , text "primary · large"
                    ]
                , swatch
                    [ Shape.new |> Shape.withClass "block w-16 h-16 bg-tertiary-container rounded-md-corner-extra-large" |> Shape.view
                    , text "tertiary · xl"
                    ]
                , swatch
                    [ Shape.new |> Shape.withClass "block w-16 h-16 bg-secondary-container rounded-full" |> Shape.view
                    , text "secondary · full"
                    ]
                , swatch
                    [ Shape.new
                        |> Shape.withClass "grid place-items-center w-24 h-24 bg-primary-container text-on-primary-container rounded-md-corner-large text-title-large"
                        |> Shape.withContent [ text "A" ]
                        |> Shape.view
                    , text "with content"
                    ]
                ]
        , source = """
import Ui.Shape as Shape

Shape.new
    |> Shape.withClass "block w-16 h-16 bg-primary rounded-md-corner-large"
    |> Shape.view

Shape.new
    |> Shape.withClass "grid place-items-center w-24 h-24 bg-primary-container"
    |> Shape.withContent [ text "A" ]
    |> Shape.view
"""
        }



-- ICON


iconSection : Html msg
iconSection =
    docSection
        { anchor = "icon"
        , title = "Icon"
        , tagline = "The Material Symbols primitive every typed slot accepts. The name is a Material Symbols identifier; weight, grade, fill and optical size are typed axes."
        , whenToUse = "use Icon anywhere a glyph is needed. Containers take a Ui.Icon.Icon directly, so a non-icon can never land in an icon slot."
        , demo =
            div [ class "flex flex-wrap items-end gap-8 text-on-surface" ]
                [ swatch [ div [ class "text-4xl text-primary" ] [ Icon.material "favorite" |> Icon.view ], text "favorite" ]
                , swatch [ div [ class "text-4xl text-on-surface" ] [ Icon.material "settings" |> Icon.withFilled True |> Icon.view ], text "filled" ]
                , swatch [ div [ class "text-4xl text-on-surface" ] [ Icon.material "bolt" |> Icon.withWeight Icon.Bold |> Icon.view ], text "bold" ]
                , swatch [ div [ class "text-4xl text-tertiary" ] [ Icon.material "eco" |> Icon.withGrade Icon.HighGrade |> Icon.view ], text "high grade" ]
                ]
        , source = """
import Ui.Icon as Icon

Icon.material "favorite" |> Icon.view

Icon.material "settings"
    |> Icon.withFilled True
    |> Icon.view

Icon.material "bolt"
    |> Icon.withWeight Icon.Bold
    |> Icon.view
"""
        }



-- AVATAR


avatarSection : Html msg
avatarSection =
    docSection
        { anchor = "avatar"
        , title = "Avatar"
        , tagline = "Represents a person or entity. Three explicit constructors — image, initials, icon — so an avatar is never an empty colored circle."
        , whenToUse = "use Avatar in lists, app bars, and account menus. Content is required by construction: pick image / initials / icon at the call site."
        , demo =
            div [ class "flex flex-wrap items-end gap-8" ]
                [ swatch [ div [ class "text-2xl" ] [ Avatar.initials "JP" |> Avatar.view ], text "initials" ]
                , swatch [ div [ class "text-2xl" ] [ Avatar.icon (Icon.material "person") |> Avatar.view ], text "icon" ]
                , swatch [ div [ class "text-2xl" ] [ Avatar.image { url = "https://i.pravatar.cc/96?img=12", alt = "Portrait" } |> Avatar.view ], text "image" ]
                ]
        , source = """
import Ui.Avatar as Avatar
import Ui.Icon as Icon

Avatar.initials "JP" |> Avatar.view

Avatar.icon (Icon.material "person") |> Avatar.view

Avatar.image { url = "/me.png", alt = "Portrait" } |> Avatar.view
"""
        }



-- SKELETON


skeletonSection : Html msg
skeletonSection =
    docSection
        { anchor = "skeleton"
        , title = "Skeleton"
        , tagline = "A shimmering placeholder for content that has not loaded yet. Shape and size come from utility classes."
        , whenToUse = "show Skeletons in the layout shape of the content they stand in for, to reduce perceived load time and avoid layout shift."
        , demo =
            div [ class "w-full max-w-sm space-y-3" ]
                [ div [ class "flex items-center gap-3" ]
                    [ Skeleton.new |> Skeleton.withClass "block w-12 h-12 rounded-full" |> Skeleton.view
                    , div [ class "flex-1 space-y-2" ]
                        [ Skeleton.new |> Skeleton.withClass "block h-4 w-2/3 rounded" |> Skeleton.view
                        , Skeleton.new |> Skeleton.withClass "block h-4 w-1/3 rounded" |> Skeleton.view
                        ]
                    ]
                , Skeleton.new |> Skeleton.withClass "block h-24 w-full rounded-lg" |> Skeleton.view
                ]
        , source = """
import Ui.Skeleton as Skeleton

Skeleton.new
    |> Skeleton.withClass "block w-12 h-12 rounded-full"
    |> Skeleton.view
"""
        }



-- SCROLL CONTAINER


scrollContainerSection : Html msg
scrollContainerSection =
    docSection
        { anchor = "scroll-container"
        , title = "Scroll container"
        , tagline = "A vertically scrollable region that reveals dividers above/below when there is more content out of view."
        , whenToUse = "wrap long lists or panels whose overflow should read as 'scrollable'. The dividers cue hidden content; tune which edges show with withDividers."
        , demo =
            div [ class "w-full max-w-sm" ]
                [ ScrollContainer.new
                    |> ScrollContainer.withThin True
                    |> ScrollContainer.withDividers ScrollContainer.Both
                    |> ScrollContainer.view
                        [ div [ class "max-h-40 space-y-2 pr-2" ]
                            (List.range 1 12
                                |> List.map
                                    (\n ->
                                        div [ class "rounded-md bg-surface-container px-3 py-2 text-body-medium" ]
                                            [ text ("Item " ++ String.fromInt n) ]
                                    )
                            )
                        ]
                ]
        , source = """
import Ui.ScrollContainer as ScrollContainer

ScrollContainer.new
    |> ScrollContainer.withThin True
    |> ScrollContainer.withDividers ScrollContainer.Both
    |> ScrollContainer.view [ longContent ]
"""
        }



-- SNACKBAR


snackbarSection : Html msg
snackbarSection =
    docSection
        { anchor = "snackbar"
        , title = "Snackbar"
        , tagline = "Brief, low-emphasis feedback at the bottom of the screen, optionally with one action."
        , whenToUse = "use a Snackbar for transient confirmations ('Saved', 'Undo'). Note: <m3e-snackbar> is an imperative singleton — the fully-wired declarative/port presentation is tracked as an open issue; the builder below is the shared description."
        , demo =
            div [ class "w-full max-w-md" ]
                [ Snackbar.new "Photo saved to album"
                    |> Snackbar.withAction "Undo"
                    |> Snackbar.withDismissible True
                    |> Snackbar.view
                ]
        , source = """
import Ui.Snackbar as Snackbar

Snackbar.new "Photo saved to album"
    |> Snackbar.withAction "Undo"
    |> Snackbar.withDismissible True
    |> Snackbar.view
"""
        }



-- THEME (static role examples)


themeSection : Html msg
themeSection =
    docSection
        { anchor = "theme"
        , title = "Theme"
        , tagline = "Apply a Material color role to a subtree as a typed attribute, instead of hand-picking token classes."
        , whenToUse = "use Theme.toAttribute to scope a semantic color role (primary, tertiary, danger…) to a region of the page."
        , demo =
            div [ class "grid grid-cols-1 sm:grid-cols-3 gap-4 w-full" ]
                [ themedPanel "Primary" Theme.Primary
                , themedPanel "Tertiary" Theme.Tertiary
                , themedPanel "Danger" Theme.Danger
                ]
        , source = """
import Ui.Theme as Theme

div [ Theme.toAttribute Theme.Tertiary ]
    [ themedContent ]
"""
        }


themedPanel : String -> Theme.Theme -> Html msg
themedPanel label role =
    div
        [ Theme.toAttribute role
        , class "rounded-xl border border-outline-variant bg-surface-container p-5"
        ]
        [ div [ class "flex items-center gap-3" ]
            [ Shape.new |> Shape.withClass "block w-10 h-10 bg-primary rounded-md-corner-large" |> Shape.view
            , div []
                [ p [ class "text-title-small text-on-surface" ] [ text label ]
                , p [ class "text-body-small text-on-surface-variant" ] [ text "role" ]
                ]
            ]
        ]



-- SIZE (primitive)


sizeSection : Html msg
sizeSection =
    section [ id "size", class "scroll-mt-12 border-t border-outline-variant pt-12" ]
        [ h2 [ class "text-headline-medium font-semibold text-on-surface" ] [ text "Size" ]
        , p [ class "mt-2 max-w-2xl text-body-large text-on-surface-variant" ]
            [ text "A shared size scale used across components — a typed enum (no stringly-typed sizes). Render to the m3e attribute value with Ui.Size.toString." ]
        , codeBlock """
import Ui.Size as Size

-- Size is a typed enum shared by sizeable components.
Size.toString chosenSize
"""
        ]



-- STATUS / ROADMAP


statusSection : Html msg
statusSection =
    section [ id "status", class "scroll-mt-12 border-t border-outline-variant pt-12" ]
        [ h2 [ class "text-headline-medium font-semibold text-on-surface" ] [ text "Status & roadmap" ]
        , p [ class "mt-2 max-w-2xl text-body-large text-on-surface-variant" ]
            [ text "The honest current state of the standalone library." ]
        , div [ class "mt-6 grid gap-4 sm:grid-cols-2" ]
            [ statusCard "Complete (54)" "Every Ui.* module compiles against the bindings — buttons, cards, dialogs, the nav family, chips, fabs, form controls, sliders, date/time pickers, tooltips, and more."
            , statusCard "Documented (8)" "Shape, Icon, Avatar, Skeleton, ScrollContainer, Snackbar, Theme and Size have detailed pages above; per-component pages for the rest are in progress."
            , statusCard "Removed (1)" "Ui.Table — m3e ships no table element, so it does not belong in a library that wraps m3e."
            , statusCard "Generator fixed" "elm-cem now resolves TS string-literal aliases to real per-component Elm enums and emits shared attributes per-component — benefiting every binding library."
            ]
        ]


statusCard : String -> String -> Html msg
statusCard title body =
    div [ class "rounded-xl border border-outline-variant bg-surface-container-low p-5" ]
        [ h3 [ class "text-title-medium font-medium text-on-surface" ] [ text title ]
        , p [ class "mt-1 text-body-medium text-on-surface-variant" ] [ text body ]
        ]
