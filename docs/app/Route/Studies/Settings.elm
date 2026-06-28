module Route.Studies.Settings exposing (ActionData, Data, Model, Msg, route)

{-| **Settings** study — a realistic Material 3 settings screen.

A canonical settings surface split into four sections (Account, Notifications,
Appearance, Privacy) reachable from a left `M3e.NavigationRail`, with a
`M3e.Breadcrumb` trail showing depth. Rows are real M3 form controls:

  - `M3e.Switch` — instant on/off toggles (per guidance: apply immediately, no
    Save), e.g. two-factor, dark mode, notification channels.
  - `M3e.Slider` — a number within a range (display brightness).
  - `M3e.Select` — pick one from a long, collapsed list (language, timezone).
  - `M3e.RadioButton` — one-of-many from a small, always-visible set (theme).
  - `M3e.SegmentedButton` — inline control for a 2–5 option toggle (density),
    which live-drives the wrapping `M3e.Theme` `density` attribute.

Advanced groups use `M3e.Disclosure` accordion (one-open-at-a-time); the lone
"Developer options" panel uses a single `M3e.Disclosure` section — the two are
demoed side by side so the difference between the presentations is obvious.

"Reset to defaults" opens a confirmation `M3e.Dialog`; saving fires a
`M3e.Snackbar`. The account header carries a `M3e.Avatar`; `M3e.Divider`s
separate groups; `M3e.Tooltip`s annotate info icons; `M3e.Heading` and
`M3e.Icon` throughout. The whole subtree is wrapped in `M3e.Theme`.

Everything is live via `RouteBuilder.buildWithLocalState`.

-}

import BackendTask exposing (BackendTask)
import Effect
import Head
import Head.Seo as Seo
import Html exposing (div, p, section, text)
import Html.Attributes exposing (class)
import Layout
import M3e.Avatar as Avatar
import M3e.Breadcrumb as Breadcrumb
import M3e.Button as Button
import M3e.Dialog as Dialog
import M3e.Disclosure as Disclosure
import M3e.Divider as Divider
import M3e.Element as Element exposing (Element, Supported)
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.List as List_
import M3e.NavigationRail as NavigationRail
import M3e.Node as Node exposing (Node)
import M3e.RadioButton as RadioButton
import M3e.SegmentedButton as SegmentedButton
import M3e.Select as Select
import M3e.Slider as Slider
import M3e.Snackbar as Snackbar
import M3e.Switch as Switch
import M3e.Theme as Theme
import M3e.Tooltip as Tooltip
import M3e.Value as Value
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath
import View exposing (View)



-- DOMAIN TYPES -----------------------------------------------------------


{-| The four primary settings sections, reachable from the navigation rail.
-}
type Section
    = Account
    | Notifications
    | Appearance
    | Privacy


{-| The theme choice radio group — System / Light / Dark.
-}
type ThemeChoice
    = SystemTheme
    | LightTheme
    | DarkTheme


{-| The density segmented control — Comfortable / Compact. Live-drives the
wrapping theme's `density` attribute.
-}
type Density
    = Comfortable
    | Compact


type Language
    = English
    | Spanish
    | French
    | German
    | Japanese


type Timezone
    = UTC
    | Eastern
    | Pacific
    | Central
    | London



-- MODEL ------------------------------------------------------------------


type alias SnackbarConfig =
    { message : String, snackbarId : String, duration : Int }


type alias Model =
    { section : Section

    -- Account
    , twoFactor : Bool

    -- Notifications
    , pushEnabled : Bool
    , emailEnabled : Bool
    , marketingEnabled : Bool

    -- Appearance
    , theme : ThemeChoice
    , density : Density
    , brightness : Float
    , reduceMotion : Bool
    , language : Maybe Language
    , timezone : Maybe Timezone

    -- Privacy
    , telemetry : Bool
    , personalizedAds : Bool

    -- Advanced (accordion) / Developer options (single)
    , developerMode : Bool

    -- Transient UI
    , confirmResetOpen : Bool
    , snackbar : Maybe SnackbarConfig
    }


{-| The default settings — the single source of truth for both `init` and
"Reset to defaults". Pure, so it is trivially testable.
-}
defaults : Section -> Model
defaults section =
    { section = section
    , twoFactor = True
    , pushEnabled = True
    , emailEnabled = True
    , marketingEnabled = False
    , theme = SystemTheme
    , density = Comfortable
    , brightness = 70
    , reduceMotion = False
    , language = Just English
    , timezone = Just Eastern
    , telemetry = True
    , personalizedAds = False
    , developerMode = False
    , confirmResetOpen = False
    , snackbar = Nothing
    }


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}



-- MSG --------------------------------------------------------------------


type Msg
    = SectionSelected Section
    | TwoFactorToggled Bool
    | PushToggled Bool
    | EmailToggled Bool
    | MarketingToggled Bool
    | ThemeChosen ThemeChoice
    | DensityChosen Density
    | BrightnessChanged Float
    | ReduceMotionToggled Bool
    | LanguageChosen Language
    | TimezoneChosen Timezone
    | TelemetryToggled Bool
    | PersonalizedAdsToggled Bool
    | DeveloperModeToggled Bool
    | SaveRequested
    | ResetRequested
    | ResetConfirmed
    | DialogClosed
    | SnackbarDismissed



-- ROUTE ------------------------------------------------------------------


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = \_ _ -> ( defaults Appearance, Effect.none )
            , update = update
            , subscriptions = \_ _ _ _ -> Sub.none
            }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "A realistic Material 3 settings screen built with elm-m3e."
        , locale = Nothing
        , title = "Settings · Studies · elm-m3e"
        }
        |> Seo.website



-- UPDATE -----------------------------------------------------------------


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect.Effect Msg )
update _ _ msg model =
    case msg of
        SectionSelected section ->
            ( { model | section = section }, Effect.none )

        TwoFactorToggled on ->
            ( { model | twoFactor = on }, Effect.none )

        PushToggled on ->
            ( { model | pushEnabled = on }, Effect.none )

        EmailToggled on ->
            ( { model | emailEnabled = on }, Effect.none )

        MarketingToggled on ->
            ( { model | marketingEnabled = on }, Effect.none )

        ThemeChosen choice ->
            ( { model | theme = choice }, Effect.none )

        DensityChosen density ->
            ( { model | density = density }, Effect.none )

        BrightnessChanged value ->
            ( { model | brightness = value }, Effect.none )

        ReduceMotionToggled on ->
            ( { model | reduceMotion = on }, Effect.none )

        LanguageChosen language ->
            ( { model | language = Just language }, Effect.none )

        TimezoneChosen timezone ->
            ( { model | timezone = Just timezone }, Effect.none )

        TelemetryToggled on ->
            ( { model | telemetry = on }, Effect.none )

        PersonalizedAdsToggled on ->
            ( { model | personalizedAds = on }, Effect.none )

        DeveloperModeToggled on ->
            ( { model | developerMode = on }, Effect.none )

        SaveRequested ->
            ( { model | snackbar = Just savedSnackbar }, Effect.none )

        ResetRequested ->
            ( { model | confirmResetOpen = True }, Effect.none )

        ResetConfirmed ->
            -- Reset every preference, keep the user on their current section,
            -- and confirm with a snackbar.
            let
                fresh =
                    defaults model.section
            in
            ( { fresh | snackbar = Just resetSnackbar }, Effect.none )

        DialogClosed ->
            ( { model | confirmResetOpen = False }, Effect.none )

        SnackbarDismissed ->
            ( { model | snackbar = Nothing }, Effect.none )


savedSnackbar : SnackbarConfig
savedSnackbar =
    { message = "Settings saved.", snackbarId = "settings-saved", duration = 3000 }


resetSnackbar : SnackbarConfig
resetSnackbar =
    { message = "Settings reset to defaults.", snackbarId = "settings-reset", duration = 3000 }



-- VIEW -------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Settings · Studies · elm-m3e"
    , body =
        [ Theme.view
            { content = [ Element.fromNode (Node.map PagesMsg.fromMsg (page model)) ] }
            [ Theme.seedColor "#4F6BED"
            , Theme.variant Value.expressive
            , Theme.scheme (themeScheme model.theme)
            , Theme.density (densityValue model.density)
            , Theme.motion (motionScheme model.reduceMotion)
            ]
            |> Element.toNode
        ]
    }


page : Model -> Node Msg
page model =
    -- Outer `px-4 py-6 sm:px-6 sm:py-8` lives in `Shared.view` for every
    -- study route, so the page wrapper here only needs to constrain width.
    Layout.div "mx-auto flex max-w-5xl flex-col gap-6 rounded-md-corner-large bg-surface"
        [ breadcrumbBar model
        , Layout.div "flex flex-col gap-6 md:flex-row md:items-start"
            [ railColumn model
            , Layout.div "min-w-0 flex-1" [ sectionPanel model ]
            ]
        , Divider.view [] |> Element.toNode
        , advancedColumns model
        , footerActions
        , snackbarHost model
        , resetDialog model
        ]



-- HEADER / NAV -----------------------------------------------------------


breadcrumbBar : Model -> Node Msg
breadcrumbBar model =
    Layout.div "flex flex-col gap-1"
        [ Breadcrumb.view
            { items =
                [ Breadcrumb.item { label = "Settings" } [ Breadcrumb.itemHref "/studies/settings" ]
                , Breadcrumb.item { label = sectionTitle model.section } [ Breadcrumb.itemCurrent Breadcrumb.Page ]
                ]
            }
            []
            |> Element.toNode
        , Heading.view { label = "Settings", variant = Value.display }
            [ Heading.size Value.small, Heading.level 1 ]
            |> Element.toNode
        , Node.raw
            (p [ class "text-body-lg text-on-surface-variant" ]
                [ text "Manage your account, notifications, appearance, and privacy preferences." ]
            )
        ]


railColumn : Model -> Node Msg
railColumn model =
    Layout.div "shrink-0 self-start rounded-md-corner-large bg-surface-container p-1"
        [ NavigationRail.view
            { items =
                [ railItem model.section "person" "Account" Account
                , railItem model.section "notifications" "Notifications" Notifications
                , railItem model.section "palette" "Appearance" Appearance
                , railItem model.section "lock" "Privacy" Privacy
                ]
            }
            []
            |> Element.toNode
        ]


railItem : Section -> String -> String -> Section -> Element { s | navItem : Supported } Msg
railItem currentSection glyph label itemSection =
    NavigationRail.item { icon = Icon.view { name = glyph } [], label = label }
        [ NavigationRail.itemSelected (currentSection == itemSection)
        , NavigationRail.itemOnClick (SectionSelected itemSection)
        ]


sectionTitle : Section -> String
sectionTitle section =
    case section of
        Account ->
            "Account"

        Notifications ->
            "Notifications"

        Appearance ->
            "Appearance"

        Privacy ->
            "Privacy"



-- SECTION PANELS ---------------------------------------------------------


sectionPanel : Model -> Node Msg
sectionPanel model =
    case model.section of
        Account ->
            accountPanel model

        Notifications ->
            notificationsPanel model

        Appearance ->
            appearancePanel model

        Privacy ->
            privacyPanel model


groupCard : String -> String -> List (Node Msg) -> Node Msg
groupCard glyph title rows =
    Layout.section "flex flex-col gap-3 rounded-md-corner-large bg-surface-container-low p-5"
        (Layout.div "flex items-center gap-2 text-on-surface"
            [ Icon.view { name = glyph } [] |> Element.toNode
            , Heading.view { label = title, variant = Value.title }
                [ Heading.size Value.medium, Heading.level 2 ]
                |> Element.toNode
            ]
            :: rows
        )


{-| A labeled control row: a description on the left, the control on the right.
-}
controlRow : String -> Maybe String -> Node Msg -> Node Msg
controlRow label supporting control =
    Layout.div "flex flex-col gap-2 py-1.5 sm:flex-row sm:items-center sm:justify-between sm:gap-6"
        [ Layout.div "flex min-w-0 flex-col"
            [ Node.raw (Html.span [ class "text-body-lg text-on-surface" ] [ text label ])
            , case supporting of
                Just s ->
                    Node.raw (Html.span [ class "text-body-sm text-on-surface-variant" ] [ text s ])

                Nothing ->
                    Node.text ""
            ]
        , Layout.div "shrink-0" [ control ]
        ]


accountPanel : Model -> Node Msg
accountPanel model =
    Layout.col
        [ Layout.section "flex flex-col items-start gap-3 rounded-md-corner-large bg-surface-container-low p-5 sm:flex-row sm:items-center sm:gap-4"
            [ Avatar.view { ariaLabel = "Jack Peterson" } [ Avatar.initials "Jack Peterson" ] |> Element.toNode
            , Node.raw
                (div [ class "flex min-w-0 flex-col" ]
                    [ Html.span [ class "text-title-md text-on-surface" ] [ text "Jack Peterson" ]
                    , Html.span [ class "text-body-md text-on-surface-variant break-words" ] [ text "jack.peterson@avetta.com" ]
                    , Html.span [ class "mt-1 w-max rounded-full bg-secondary-container px-2 py-0.5 text-label-sm text-on-secondary-container" ]
                        [ text "Pro plan" ]
                    ]
                )
            ]
        , groupCard "security"
            "Security"
            [ controlRow "Two-factor authentication"
                (Just "Require a verification code on every sign-in.")
                (Switch.view { ariaLabel = "Two-factor authentication" }
                    [ Switch.checked model.twoFactor
                    , Switch.onChange TwoFactorToggled
                    , Switch.icons Switch.Both
                    ]
                    |> Element.toNode
                )
            ]
        ]


notificationsPanel : Model -> Node Msg
notificationsPanel model =
    groupCard "notifications"
        "Notification channels"
        [ controlRow "Push notifications"
            (Just "Alerts on this device.")
            (channelSwitch "Push notifications" model.pushEnabled PushToggled)
        , Divider.view [ Divider.inset True ] |> Element.toNode
        , controlRow "Email notifications"
            (Just "Summaries and security alerts by email.")
            (channelSwitch "Email notifications" model.emailEnabled EmailToggled)
        , Divider.view [ Divider.inset True ] |> Element.toNode
        , controlRow "Product & marketing"
            (Just "Occasional news about new features.")
            (channelSwitch "Product & marketing" model.marketingEnabled MarketingToggled)
        ]


channelSwitch : String -> Bool -> (Bool -> Msg) -> Node Msg
channelSwitch label checked onChange_ =
    Switch.view { ariaLabel = label }
        [ Switch.checked checked
        , Switch.onChange onChange_
        ]
        |> Element.toNode


appearancePanel : Model -> Node Msg
appearancePanel model =
    Layout.col
        [ groupCard "palette"
            "Theme"
            [ controlRow "Color scheme"
                (Just "Choose how the interface looks. Applies instantly.")
                (RadioButton.view
                    { name = "Color scheme"
                    , options =
                        [ { value = "system", label = "System" }
                        , { value = "light", label = "Light" }
                        , { value = "dark", label = "Dark" }
                        ]
                    , selected = Just (themeChoiceToString model.theme)
                    }
                    [ RadioButton.onChange
                        (\s ->
                            themeChoiceFromString s
                                |> Maybe.withDefault SystemTheme
                                |> ThemeChosen
                        )
                    ]
                    |> Element.toNode
                )
            , Divider.view [ Divider.inset True ] |> Element.toNode
            , controlRow "Density"
                (Just "Compact tightens spacing across the app.")
                (SegmentedButton.view
                    { segments =
                        [ SegmentedButton.segment
                            { label = "Comfortable", checked = model.density == Comfortable }
                            [ SegmentedButton.segmentOnClick (DensityChosen Comfortable) ]
                        , SegmentedButton.segment
                            { label = "Compact", checked = model.density == Compact }
                            [ SegmentedButton.segmentOnClick (DensityChosen Compact) ]
                        ]
                    }
                    []
                    |> Element.toNode
                )
            ]
        , groupCard "tune"
            "Display"
            [ controlRow "Brightness"
                (Just (String.fromInt (round model.brightness) ++ "%"))
                (Layout.div "w-full sm:w-72"
                    [ Slider.view { name = "Brightness" }
                        [ Slider.value model.brightness
                        , Slider.onInput BrightnessChanged
                        , Slider.min 0
                        , Slider.max 100
                        , Slider.step 1
                        ]
                        |> Element.toNode
                    ]
                )
            , Divider.view [ Divider.inset True ] |> Element.toNode
            , controlRow "Reduce motion"
                (Just "Minimize non-essential animations.")
                (Switch.view { ariaLabel = "Reduce motion" }
                    [ Switch.checked model.reduceMotion
                    , Switch.onChange ReduceMotionToggled
                    ]
                    |> Element.toNode
                )
            ]
        , groupCard "language"
            "Region"
            [ controlRow "Language" Nothing (languageSelect model)
            , Divider.view [ Divider.inset True ] |> Element.toNode
            , controlRow "Timezone" Nothing (timezoneSelect model)
            ]
        ]


languageSelect : Model -> Node Msg
languageSelect model =
    Layout.div "w-full sm:w-64"
        [ Select.view { label = "Language" }
            [ Select.options
                [ Select.option { value = "english", label = "English" }
                    [ Select.optionSelected (model.language == Just English) ]
                , Select.option { value = "spanish", label = "Español" }
                    [ Select.optionSelected (model.language == Just Spanish) ]
                , Select.option { value = "french", label = "Français" }
                    [ Select.optionSelected (model.language == Just French) ]
                , Select.option { value = "german", label = "Deutsch" }
                    [ Select.optionSelected (model.language == Just German) ]
                , Select.option { value = "japanese", label = "日本語" }
                    [ Select.optionSelected (model.language == Just Japanese) ]
                ]
            , Select.onChange
                (\s ->
                    languageFromString s
                        |> Maybe.withDefault English
                        |> LanguageChosen
                )
            ]
            |> Element.toNode
        ]


timezoneSelect : Model -> Node Msg
timezoneSelect model =
    Layout.div "w-full sm:w-64"
        [ Select.view { label = "Timezone" }
            [ Select.options
                [ Select.option { value = "utc", label = "UTC" }
                    [ Select.optionSelected (model.timezone == Just UTC) ]
                , Select.option { value = "eastern", label = "Eastern (UTC−5)" }
                    [ Select.optionSelected (model.timezone == Just Eastern) ]
                , Select.option { value = "central", label = "Central (UTC−6)" }
                    [ Select.optionSelected (model.timezone == Just Central) ]
                , Select.option { value = "pacific", label = "Pacific (UTC−8)" }
                    [ Select.optionSelected (model.timezone == Just Pacific) ]
                , Select.option { value = "london", label = "London (UTC+0)" }
                    [ Select.optionSelected (model.timezone == Just London) ]
                ]
            , Select.onChange
                (\s ->
                    timezoneFromString s
                        |> Maybe.withDefault UTC
                        |> TimezoneChosen
                )
            ]
            |> Element.toNode
        ]


privacyPanel : Model -> Node Msg
privacyPanel model =
    Layout.col
        [ groupCard "lock"
            "Privacy"
            [ controlRow "Usage analytics"
                (Just "Share anonymized usage data to help improve the product.")
                (Layout.div "flex items-center gap-2"
                    [ infoIcon "telemetry-info" "We never sell your data."
                    , Switch.view { ariaLabel = "Usage analytics" }
                        [ Switch.checked model.telemetry
                        , Switch.onChange TelemetryToggled
                        ]
                        |> Element.toNode
                    ]
                )
            , Divider.view [ Divider.inset True ] |> Element.toNode
            , controlRow "Personalized ads"
                (Just "Use your activity to tailor advertising.")
                (Switch.view { ariaLabel = "Personalized ads" }
                    [ Switch.checked model.personalizedAds
                    , Switch.onChange PersonalizedAdsToggled
                    ]
                    |> Element.toNode
                )
            ]
        , Layout.section "rounded-md-corner-large bg-surface-container-low p-2"
            [ List_.actionList
                { items =
                    [ List_.actionItem { headline = "Download my data" }
                        [ List_.actionSupporting "Export a copy of your information."
                        , List_.actionLeading
                            (Element.element { tag = "span" }
                                []
                                [ Element.toNode (Icon.view { name = "download" } []) ]
                            )
                        , List_.actionTrailing
                            (Element.element { tag = "span" }
                                []
                                [ Element.toNode (Icon.view { name = "chevron_right" } []) ]
                            )
                        , List_.actionOnClick SaveRequested
                        ]
                    , List_.actionItem { headline = "Delete account" }
                        [ List_.actionSupporting "Permanently remove your account and data."
                        , List_.actionLeading
                            (Element.element { tag = "span" }
                                []
                                [ Element.toNode (Icon.view { name = "delete" } []) ]
                            )
                        , List_.actionTrailing
                            (Element.element { tag = "span" }
                                []
                                [ Element.toNode (Icon.view { name = "chevron_right" } []) ]
                            )
                        , List_.actionOnClick ResetRequested
                        ]
                    ]
                }
                []
                |> Element.toNode
            ]
        ]


{-| A small info glyph that carries a plain tooltip. The icon's `id` is the
tooltip's anchor.
-}
infoIcon : String -> String -> Node Msg
infoIcon anchorId label =
    Node.element "span"
        []
        [ Node.element "span"
            [ Node.rawAttr (Html.Attributes.id anchorId), Node.rawAttr (class "inline-flex text-on-surface-variant") ]
            [ Icon.view { name = "info" } [] |> Element.toNode ]
        , Tooltip.plain { anchorId = anchorId, label = label } [] |> Element.toNode
        ]



-- ADVANCED: DISCLOSURE SINGLE + ACCORDION SIDE BY SIDE -------------------


advancedColumns : Model -> Node Msg
advancedColumns model =
    Layout.div "flex flex-col gap-4 lg:flex-row lg:items-start"
        [ Layout.div "min-w-0 flex-1"
            [ Heading.view
                { label = "Advanced (accordion — one open at a time)", variant = Value.title }
                [ Heading.size Value.small, Heading.level 2 ]
                |> Element.toNode
            , advancedAccordion
            ]
        , Layout.div "min-w-0 flex-1"
            [ Heading.view
                { label = "Developer options (single panel)", variant = Value.title }
                [ Heading.size Value.small, Heading.level 2 ]
                |> Element.toNode
            , developerPanel model
            ]
        ]


advancedAccordion : Node Msg
advancedAccordion =
    Disclosure.view
        { sections =
            [ Disclosure.section
                { header = "Storage & cache"
                , content =
                    [ Element.fromNode
                        (Node.raw
                            (p [ class "text-body-md text-on-surface-variant" ]
                                [ text "Cached data uses 248 MB. Clearing the cache will sign you out of some sites." ]
                            )
                        )
                    ]
                }
                []
            , Disclosure.section
                { header = "Network"
                , content =
                    [ Element.fromNode
                        (Node.raw
                            (p [ class "text-body-md text-on-surface-variant" ]
                                [ text "Configure proxy, DNS-over-HTTPS, and connection preferences." ]
                            )
                        )
                    ]
                }
                []
            , Disclosure.section
                { header = "Accessibility"
                , content =
                    [ Element.fromNode
                        (Node.raw
                            (p [ class "text-body-md text-on-surface-variant" ]
                                [ text "High-contrast mode, larger text, and screen-reader hints." ]
                            )
                        )
                    ]
                }
                []
            ]
        }
        []
        |> Element.toNode


developerPanel : Model -> Node Msg
developerPanel model =
    Disclosure.view
        { sections =
            [ Disclosure.section
                { header = "Developer options"
                , content =
                    [ Element.fromNode
                        (controlRow "Developer mode"
                            (Just "Show experimental flags and verbose logging.")
                            (Switch.view { ariaLabel = "Developer mode" }
                                [ Switch.checked model.developerMode
                                , Switch.onChange DeveloperModeToggled
                                ]
                                |> Element.toNode
                            )
                        )
                    ]
                }
                []
            ]
        }
        []
        |> Element.toNode



-- FOOTER / DIALOG / SNACKBAR ---------------------------------------------


footerActions : Node Msg
footerActions =
    Layout.div "flex flex-wrap items-center justify-end gap-3"
        [ Button.view { label = "Reset to defaults", variant = Value.text }
            [ Button.leadingIcon (Icon.view { name = "restart_alt" } [])
            , Button.onClick ResetRequested
            ]
            |> Element.toNode
        , Button.view { label = "Save changes", variant = Value.filled }
            [ Button.leadingIcon (Icon.view { name = "save" } [])
            , Button.onClick SaveRequested
            ]
            |> Element.toNode
        ]


resetDialog : Model -> Node Msg
resetDialog model =
    Dialog.view
        { headline = "Reset to defaults?"
        , content =
            [ Element.fromNode (Node.text "This restores every setting in this screen to its original value. This can't be undone.")
            ]
        }
        [ Dialog.open model.confirmResetOpen
        , Dialog.onClose DialogClosed
        , Dialog.actions
            [ Button.view { label = "Cancel", variant = Value.text }
                [ Button.onClick DialogClosed ]
            , Button.view { label = "Reset", variant = Value.filled }
                [ Button.onClick ResetConfirmed ]
            ]
        ]
        |> Element.toNode


snackbarHost : Model -> Node Msg
snackbarHost model =
    case model.snackbar of
        Nothing ->
            Node.text ""

        Just s ->
            Snackbar.view { message = s.message }
                [ Snackbar.id s.snackbarId
                , Snackbar.dismissible True
                , Snackbar.duration s.duration
                ]
                |> Element.toNode



-- THEME MAPPING (pure) ---------------------------------------------------


themeScheme : ThemeChoice -> Theme.Scheme
themeScheme choice =
    case choice of
        SystemTheme ->
            Theme.Auto

        LightTheme ->
            Theme.Light

        DarkTheme ->
            Theme.Dark


densityValue : Density -> Float
densityValue density =
    case density of
        Comfortable ->
            0

        Compact ->
            -2


motionScheme : Bool -> Theme.Motion
motionScheme reduceMotion =
    if reduceMotion then
        Theme.MotionStandard

    else
        Theme.MotionExpressive



-- STRING CONVERSIONS (for Select / RadioButton) --------------------------


themeChoiceToString : ThemeChoice -> String
themeChoiceToString choice =
    case choice of
        SystemTheme ->
            "system"

        LightTheme ->
            "light"

        DarkTheme ->
            "dark"


themeChoiceFromString : String -> Maybe ThemeChoice
themeChoiceFromString s =
    case s of
        "system" ->
            Just SystemTheme

        "light" ->
            Just LightTheme

        "dark" ->
            Just DarkTheme

        _ ->
            Nothing


languageFromString : String -> Maybe Language
languageFromString s =
    case s of
        "english" ->
            Just English

        "spanish" ->
            Just Spanish

        "french" ->
            Just French

        "german" ->
            Just German

        "japanese" ->
            Just Japanese

        _ ->
            Nothing


timezoneFromString : String -> Maybe Timezone
timezoneFromString s =
    case s of
        "utc" ->
            Just UTC

        "eastern" ->
            Just Eastern

        "pacific" ->
            Just Pacific

        "central" ->
            Just Central

        "london" ->
            Just London

        _ ->
            Nothing
