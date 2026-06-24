module Route.Studies.Settings exposing (ActionData, Data, Model, Msg, route)

{-| **Settings** study — a realistic Material 3 settings screen.

A canonical settings surface split into four sections (Account, Notifications,
Appearance, Privacy) reachable from a left `Ui.NavigationRail`, with a
`Ui.Breadcrumb` trail showing depth. Rows are real M3 form controls:

  - `Ui.Switch` — instant on/off toggles (per guidance: apply immediately, no
    Save), e.g. two-factor, dark mode, notification channels.
  - `Ui.Slider` — a number within a range (display brightness).
  - `Ui.Select` — pick one from a long, collapsed list (language, timezone).
  - `Ui.RadioButton` — one-of-many from a small, always-visible set (theme).
  - `Ui.SegmentedButton` — inline control for a 2–5 option toggle (density),
    which live-drives the wrapping `Ui.Theme` `density` attribute.

Advanced groups use `Ui.Disclosure.accordion` (one-open-at-a-time); the lone
"Developer options" panel uses `Ui.Disclosure.single` — the two are demoed
side by side so the difference between the presentations is obvious.

"Reset to defaults" opens a confirmation `Ui.Dialog`; saving fires a
`Ui.Snackbar`. The account header carries a `Ui.Avatar`; `Ui.Divider`s
separate groups; `Ui.Tooltip`s annotate info icons; `Ui.Heading` and
`Ui.Icon` throughout. The whole subtree is wrapped in `Ui.Theme`.

Everything is live via `RouteBuilder.buildWithLocalState`.

-}

import BackendTask exposing (BackendTask)
import Effect
import Head
import Head.Seo as Seo
import Html exposing (Html, div, p, section, text)
import Html.Attributes exposing (class)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import Ui.Avatar
import Ui.Breadcrumb
import Ui.Button
import Ui.Dialog
import Ui.Disclosure
import Ui.Divider
import Ui.Heading
import Ui.Icon
import Ui.List
import Ui.NavigationRail
import Ui.RadioButton
import Ui.SegmentedButton
import Ui.Select
import Ui.Slider
import Ui.Snackbar
import Ui.Switch
import Ui.Theme
import Ui.Tooltip
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
    , snackbar : Maybe (Ui.Snackbar.Snackbar Msg)
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


savedSnackbar : Ui.Snackbar.Snackbar Msg
savedSnackbar =
    Ui.Snackbar.new "Settings saved."
        |> Ui.Snackbar.withId "settings-saved"
        |> Ui.Snackbar.withDismissible True
        |> Ui.Snackbar.withDuration 3000


resetSnackbar : Ui.Snackbar.Snackbar Msg
resetSnackbar =
    Ui.Snackbar.new "Settings reset to defaults."
        |> Ui.Snackbar.withId "settings-reset"
        |> Ui.Snackbar.withDismissible True
        |> Ui.Snackbar.withDuration 3000



-- VIEW -------------------------------------------------------------------


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Settings · Studies · elm-m3e"
    , body =
        [ Ui.Theme.new
            |> Ui.Theme.withSeedColor "#4F6BED"
            |> Ui.Theme.withVariant Ui.Theme.Expressive
            |> Ui.Theme.withScheme (themeScheme model.theme)
            |> Ui.Theme.withDensity (densityValue model.density)
            |> Ui.Theme.withMotion (motionScheme model.reduceMotion)
            |> Ui.Theme.view [ Html.map PagesMsg.fromMsg (page model) ]
        ]
    }


page : Model -> Html Msg
page model =
    div [ class "mx-auto flex max-w-5xl flex-col gap-6 rounded-md-corner-large bg-surface p-4 sm:p-6" ]
        [ breadcrumbBar model
        , div [ class "flex flex-col gap-6 md:flex-row md:items-start" ]
            [ railColumn model
            , div [ class "min-w-0 flex-1" ] [ sectionPanel model ]
            ]
        , Html.map never (Ui.Divider.view Ui.Divider.new)
        , advancedColumns model
        , footerActions
        , snackbarHost model
        , resetDialog model
        ]



-- HEADER / NAV -----------------------------------------------------------


breadcrumbBar : Model -> Html Msg
breadcrumbBar model =
    div [ class "flex flex-col gap-1" ]
        [ Ui.Breadcrumb.new
            |> Ui.Breadcrumb.withItems
                [ Ui.Breadcrumb.link (text "Settings") "/studies/settings"
                , Ui.Breadcrumb.link (text (sectionTitle model.section)) "/studies/settings"
                , Ui.Breadcrumb.current (text "Permissions")
                ]
            |> Ui.Breadcrumb.view
        , Ui.Heading.new
            |> Ui.Heading.withVariant Ui.Heading.Display
            |> Ui.Heading.withSize Ui.Heading.Small
            |> Ui.Heading.withLevel 1
            |> Ui.Heading.withContent (text "Settings")
            |> Ui.Heading.view
        , p [ class "text-body-large text-on-surface-variant" ]
            [ text "Manage your account, notifications, appearance, and privacy preferences." ]
        ]


railColumn : Model -> Html Msg
railColumn model =
    div [ class "shrink-0 self-start rounded-md-corner-large bg-surface-container p-1" ]
        [ Ui.NavigationRail.new
            { items =
                [ railItem "person" "Account" Account
                , railItem "notifications" "Notifications" Notifications
                , railItem "palette" "Appearance" Appearance
                , railItem "lock" "Privacy" Privacy
                ]
            , selected = Just model.section
            , onChange = SectionSelected
            }
            |> Ui.NavigationRail.view
        ]


railItem : String -> String -> Section -> Ui.NavigationRail.Item Section Msg
railItem glyph label value =
    Ui.NavigationRail.item { value = value, icon = Ui.Icon.material glyph }
        |> Ui.NavigationRail.withItemLabel label


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


sectionPanel : Model -> Html Msg
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


groupCard : String -> String -> List (Html Msg) -> Html Msg
groupCard glyph title rows =
    section [ class "flex flex-col gap-3 rounded-md-corner-large bg-surface-container-low p-5" ]
        (div [ class "flex items-center gap-2 text-on-surface" ]
            [ Html.map never (Ui.Icon.view (Ui.Icon.material glyph))
            , Ui.Heading.new
                |> Ui.Heading.withVariant Ui.Heading.Title
                |> Ui.Heading.withSize Ui.Heading.Medium
                |> Ui.Heading.withLevel 2
                |> Ui.Heading.withContent (text title)
                |> Ui.Heading.view
            ]
            :: rows
        )


{-| A labeled control row: a description on the left, the control on the right.
-}
controlRow : String -> Maybe String -> Html Msg -> Html Msg
controlRow label supporting control =
    div [ class "flex flex-col gap-2 py-1.5 sm:flex-row sm:items-center sm:justify-between sm:gap-6" ]
        [ div [ class "flex min-w-0 flex-col" ]
            [ Html.span [ class "text-body-large text-on-surface" ] [ text label ]
            , case supporting of
                Just s ->
                    Html.span [ class "text-body-small text-on-surface-variant" ] [ text s ]

                Nothing ->
                    text ""
            ]
        , div [ class "shrink-0" ] [ control ]
        ]


accountPanel : Model -> Html Msg
accountPanel model =
    div [ class "flex flex-col gap-4" ]
        [ section [ class "flex items-center gap-4 rounded-md-corner-large bg-surface-container-low p-5" ]
            [ Html.map never (Ui.Avatar.view (Ui.Avatar.initials "Jack Peterson"))
            , div [ class "flex min-w-0 flex-col" ]
                [ Html.span [ class "text-title-medium text-on-surface" ] [ text "Jack Peterson" ]
                , Html.span [ class "text-body-medium text-on-surface-variant" ] [ text "jack.peterson@avetta.com" ]
                , Html.span [ class "mt-1 w-max rounded-full bg-secondary-container px-2 py-0.5 text-label-small text-on-secondary-container" ]
                    [ text "Pro plan" ]
                ]
            ]
        , groupCard "security"
            "Security"
            [ controlRow "Two-factor authentication"
                (Just "Require a verification code on every sign-in.")
                (Ui.Switch.new
                    { label = "Two-factor authentication"
                    , checked = model.twoFactor
                    , onChange = TwoFactorToggled
                    }
                    |> Ui.Switch.withHandleIcons True
                    |> Ui.Switch.view
                )
            ]
        ]


notificationsPanel : Model -> Html Msg
notificationsPanel model =
    groupCard "notifications"
        "Notification channels"
        [ controlRow "Push notifications"
            (Just "Alerts on this device.")
            (channelSwitch "Push notifications" model.pushEnabled PushToggled)
        , Html.map never (Ui.Divider.view (Ui.Divider.new |> Ui.Divider.withInset True))
        , controlRow "Email notifications"
            (Just "Summaries and security alerts by email.")
            (channelSwitch "Email notifications" model.emailEnabled EmailToggled)
        , Html.map never (Ui.Divider.view (Ui.Divider.new |> Ui.Divider.withInset True))
        , controlRow "Product & marketing"
            (Just "Occasional news about new features.")
            (channelSwitch "Product & marketing" model.marketingEnabled MarketingToggled)
        ]


channelSwitch : String -> Bool -> (Bool -> Msg) -> Html Msg
channelSwitch label checked onChange =
    Ui.Switch.new { label = label, checked = checked, onChange = onChange }
        |> Ui.Switch.view


appearancePanel : Model -> Html Msg
appearancePanel model =
    div [ class "flex flex-col gap-4" ]
        [ groupCard "palette"
            "Theme"
            [ controlRow "Color scheme"
                (Just "Choose how the interface looks. Applies instantly.")
                (Ui.RadioButton.group
                    { label = "Color scheme"
                    , options =
                        [ Ui.RadioButton.option { value = SystemTheme, label = "System" }
                        , Ui.RadioButton.option { value = LightTheme, label = "Light" }
                        , Ui.RadioButton.option { value = DarkTheme, label = "Dark" }
                        ]
                    , selected = Just model.theme
                    , onChange = ThemeChosen
                    }
                    |> Ui.RadioButton.view
                )
            , Html.map never (Ui.Divider.view (Ui.Divider.new |> Ui.Divider.withInset True))
            , controlRow "Density"
                (Just "Compact tightens spacing across the app.")
                (Ui.SegmentedButton.single
                    { label = "Density"
                    , segments =
                        [ Ui.SegmentedButton.segment { value = Comfortable, label = "Comfortable" }
                        , Ui.SegmentedButton.segment { value = Compact, label = "Compact" }
                        ]
                    , selected = Just model.density
                    , onChange = DensityChosen
                    }
                    |> Ui.SegmentedButton.view
                )
            ]
        , groupCard "tune"
            "Display"
            [ controlRow "Brightness"
                (Just (String.fromInt (round model.brightness) ++ "%"))
                (div [ class "w-full sm:w-72" ]
                    [ Ui.Slider.value
                        { label = "Brightness"
                        , value = model.brightness
                        , onChange = BrightnessChanged
                        }
                        |> Ui.Slider.withMin 0
                        |> Ui.Slider.withMax 100
                        |> Ui.Slider.withStep 1
                        |> Ui.Slider.view
                    ]
                )
            , Html.map never (Ui.Divider.view (Ui.Divider.new |> Ui.Divider.withInset True))
            , controlRow "Reduce motion"
                (Just "Minimize non-essential animations.")
                (Ui.Switch.new
                    { label = "Reduce motion"
                    , checked = model.reduceMotion
                    , onChange = ReduceMotionToggled
                    }
                    |> Ui.Switch.view
                )
            ]
        , groupCard "language"
            "Region"
            [ controlRow "Language" Nothing (languageSelect model)
            , Html.map never (Ui.Divider.view (Ui.Divider.new |> Ui.Divider.withInset True))
            , controlRow "Timezone" Nothing (timezoneSelect model)
            ]
        ]


languageSelect : Model -> Html Msg
languageSelect model =
    div [ class "w-full sm:w-64" ]
        [ Ui.Select.single
            { label = "Language"
            , options =
                [ Ui.Select.option { value = English, label = "English" }
                , Ui.Select.option { value = Spanish, label = "Español" }
                , Ui.Select.option { value = French, label = "Français" }
                , Ui.Select.option { value = German, label = "Deutsch" }
                , Ui.Select.option { value = Japanese, label = "日本語" }
                ]
            , selected = model.language
            , onChange = LanguageChosen
            }
            |> Ui.Select.view
        ]


timezoneSelect : Model -> Html Msg
timezoneSelect model =
    div [ class "w-full sm:w-64" ]
        [ Ui.Select.single
            { label = "Timezone"
            , options =
                [ Ui.Select.option { value = UTC, label = "UTC" }
                , Ui.Select.option { value = Eastern, label = "Eastern (UTC−5)" }
                , Ui.Select.option { value = Central, label = "Central (UTC−6)" }
                , Ui.Select.option { value = Pacific, label = "Pacific (UTC−8)" }
                , Ui.Select.option { value = London, label = "London (UTC+0)" }
                ]
            , selected = model.timezone
            , onChange = TimezoneChosen
            }
            |> Ui.Select.view
        ]


privacyPanel : Model -> Html Msg
privacyPanel model =
    div [ class "flex flex-col gap-4" ]
        [ groupCard "lock"
            "Privacy"
            [ controlRow "Usage analytics"
                (Just "Share anonymized usage data to help improve the product.")
                (div [ class "flex items-center gap-2" ]
                    [ infoIcon "telemetry-info" "We never sell your data."
                    , Ui.Switch.new
                        { label = "Usage analytics"
                        , checked = model.telemetry
                        , onChange = TelemetryToggled
                        }
                        |> Ui.Switch.view
                    ]
                )
            , Html.map never (Ui.Divider.view (Ui.Divider.new |> Ui.Divider.withInset True))
            , controlRow "Personalized ads"
                (Just "Use your activity to tailor advertising.")
                (Ui.Switch.new
                    { label = "Personalized ads"
                    , checked = model.personalizedAds
                    , onChange = PersonalizedAdsToggled
                    }
                    |> Ui.Switch.view
                )
            ]
        , section [ class "rounded-md-corner-large bg-surface-container-low p-2" ]
            [ Ui.List.new
                [ Ui.List.actionItem "Download my data"
                    |> Ui.List.withItemSupporting "Export a copy of your information."
                    |> Ui.List.withItemLeadingIcon (Ui.Icon.material "download")
                    |> Ui.List.withItemTrailingIcon (Ui.Icon.material "chevron_right")
                    |> Ui.List.withItemOnClick SaveRequested
                , Ui.List.actionItem "Delete account"
                    |> Ui.List.withItemSupporting "Permanently remove your account and data."
                    |> Ui.List.withItemLeadingIcon (Ui.Icon.material "delete")
                    |> Ui.List.withItemTrailingIcon (Ui.Icon.material "chevron_right")
                    |> Ui.List.withItemOnClick ResetRequested
                ]
                |> Ui.List.view
            ]
        ]


{-| A small info glyph that carries a plain tooltip. The icon's `id` is the
tooltip's anchor.
-}
infoIcon : String -> String -> Html Msg
infoIcon anchorId label =
    Html.span []
        [ Html.span [ Html.Attributes.id anchorId, class "inline-flex text-on-surface-variant" ]
            [ Html.map never
                (Ui.Icon.view
                    (Ui.Icon.material "info"
                        |> Ui.Icon.withA11y (text label)
                    )
                )
            ]
        , Html.map never
            (Ui.Tooltip.plain { anchorId = anchorId, label = label }
                |> Ui.Tooltip.view
            )
        ]



-- ADVANCED: DISCLOSURE SINGLE + ACCORDION SIDE BY SIDE -------------------


advancedColumns : Model -> Html Msg
advancedColumns model =
    div [ class "flex flex-col gap-4 lg:flex-row lg:items-start" ]
        [ div [ class "min-w-0 flex-1" ]
            [ Ui.Heading.new
                |> Ui.Heading.withVariant Ui.Heading.Title
                |> Ui.Heading.withSize Ui.Heading.Small
                |> Ui.Heading.withLevel 2
                |> Ui.Heading.withContent (text "Advanced (accordion — one open at a time)")
                |> Ui.Heading.view
            , advancedAccordion
            ]
        , div [ class "min-w-0 flex-1" ]
            [ Ui.Heading.new
                |> Ui.Heading.withVariant Ui.Heading.Title
                |> Ui.Heading.withSize Ui.Heading.Small
                |> Ui.Heading.withLevel 2
                |> Ui.Heading.withContent (text "Developer options (single panel)")
                |> Ui.Heading.view
            , developerPanel model
            ]
        ]


advancedAccordion : Html Msg
advancedAccordion =
    Ui.Disclosure.accordion "settings-advanced"
        [ Ui.Disclosure.section "advanced-storage"
            (text "Storage & cache")
            [ p [ class "text-body-medium text-on-surface-variant" ]
                [ text "Cached data uses 248 MB. Clearing the cache will sign you out of some sites." ]
            ]
        , Ui.Disclosure.section "advanced-network"
            (text "Network")
            [ p [ class "text-body-medium text-on-surface-variant" ]
                [ text "Configure proxy, DNS-over-HTTPS, and connection preferences." ]
            ]
        , Ui.Disclosure.section "advanced-accessibility"
            (text "Accessibility")
            [ p [ class "text-body-medium text-on-surface-variant" ]
                [ text "High-contrast mode, larger text, and screen-reader hints." ]
            ]
        ]
        |> Ui.Disclosure.view


developerPanel : Model -> Html Msg
developerPanel model =
    Ui.Disclosure.single "settings-developer"
        (text "Developer options")
        [ controlRow "Developer mode"
            (Just "Show experimental flags and verbose logging.")
            (Ui.Switch.new
                { label = "Developer mode"
                , checked = model.developerMode
                , onChange = DeveloperModeToggled
                }
                |> Ui.Switch.view
            )
        ]
        |> Ui.Disclosure.view



-- FOOTER / DIALOG / SNACKBAR ---------------------------------------------


footerActions : Html Msg
footerActions =
    div [ class "flex flex-wrap items-center justify-end gap-3" ]
        [ Ui.Button.new { label = "Reset to defaults", variant = Ui.Button.Text }
            |> Ui.Button.withLeadingIcon (Ui.Icon.material "restart_alt")
            |> Ui.Button.withOnClick ResetRequested
            |> Ui.Button.view
        , Ui.Button.new { label = "Save changes", variant = Ui.Button.Filled }
            |> Ui.Button.withLeadingIcon (Ui.Icon.material "save")
            |> Ui.Button.withOnClick SaveRequested
            |> Ui.Button.view
        ]


resetDialog : Model -> Html Msg
resetDialog model =
    Ui.Dialog.new
        { title = "Reset to defaults?"
        , open = model.confirmResetOpen
        , onClose = DialogClosed
        }
        |> Ui.Dialog.withBody
            (text "This restores every setting in this screen to its original value. This can't be undone.")
        |> Ui.Dialog.withActions
            [ Ui.Button.new { label = "Cancel", variant = Ui.Button.Text }
                |> Ui.Button.withOnClick DialogClosed
            , Ui.Button.new { label = "Reset", variant = Ui.Button.Filled }
                |> Ui.Button.withOnClick ResetConfirmed
            ]
        |> Ui.Dialog.view


snackbarHost : Model -> Html Msg
snackbarHost model =
    case model.snackbar of
        Nothing ->
            text ""

        Just s ->
            Ui.Snackbar.view s



-- THEME MAPPING (pure) ---------------------------------------------------


themeScheme : ThemeChoice -> Ui.Theme.Scheme
themeScheme choice =
    case choice of
        SystemTheme ->
            Ui.Theme.Auto

        LightTheme ->
            Ui.Theme.Light

        DarkTheme ->
            Ui.Theme.Dark


densityValue : Density -> Float
densityValue density =
    case density of
        Comfortable ->
            0

        Compact ->
            -2


motionScheme : Bool -> Ui.Theme.Motion
motionScheme reduceMotion =
    if reduceMotion then
        Ui.Theme.MotionStandard

    else
        Ui.Theme.MotionExpressive
