module Route.Studies.Reply exposing (ActionData, Data, Model, Msg, route)

{-| **Reply** — a Material 3 email / inbox client (list-detail).

A responsive mail client that composes a large slice of the elm-m3e
library the way Google's "Reply" Material Study does:

  - A **NavigationRail** in `Expanded` mode (large screens, drawer-shaped:
    icon + label) / `Compact` mode (medium, icons only) / **NavigationBar**
    (compact viewports, bottom-mounted) trio switches mailboxes. The swap
    is driven by responsive breakpoints — the "Size" concern in the
    coverage matrix.
  - An **AppBar** holds a **Search** field, a notifications **IconButton**
    with a **Badge** (unread count), and the user **Avatar**.
  - The message **List** uses **Avatar** rows, a leading multi-select
    **Checkbox**, and a trailing star **IconButton** with a **Tooltip**.
  - Selecting a thread opens a **SplitPane** reading view (list ⇄ message),
    each pane scrolled with a **ScrollContainer**.
  - Composing opens a **BottomSheet** with **TextField**s (to / subject /
    body) and a **SplitButton** (Send / Schedule send).
  - Archiving fires a **Snackbar** with an Undo action.
  - A **Fab** ("Compose") sits bottom-right; a **Menu** provides per-message
    overflow actions; **Divider** separates list sections; **Heading** /
    **Icon** throughout. **Theme** wraps the whole study.

Interactivity is real (selecting a message, switching folders, filtering by
search, composing, archiving) via `RouteBuilder.buildWithLocalState`.

-}

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, p, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import Ui.AppBar as AppBar
import Ui.Avatar as Avatar
import Ui.Badge as Badge
import Ui.BottomSheet as BottomSheet
import Ui.Button as Button
import Ui.Checkbox as Checkbox
import Ui.Divider as Divider
import Ui.Fab as Fab
import Ui.Heading as Heading
import Ui.Icon as Icon
import Ui.IconButton as IconButton
import Ui.Menu as Menu
import Ui.NavigationBar as NavigationBar
import Ui.NavigationRail as NavigationRail
import Ui.ScrollContainer as ScrollContainer
import Ui.Search as Search
import Ui.Snackbar as Snackbar
import Ui.SplitButton as SplitButton
import Ui.SplitPane as SplitPane
import Ui.TextField as TextField
import Ui.Theme as Theme
import Ui.Tooltip as Tooltip
import UrlPath
import View exposing (View)



-- DOMAIN


type Mailbox
    = Inbox
    | Starred
    | Sent
    | Drafts
    | Trash


allMailboxes : List Mailbox
allMailboxes =
    [ Inbox, Starred, Sent, Drafts, Trash ]


mailboxLabel : Mailbox -> String
mailboxLabel mailbox =
    case mailbox of
        Inbox ->
            "Inbox"

        Starred ->
            "Starred"

        Sent ->
            "Sent"

        Drafts ->
            "Drafts"

        Trash ->
            "Trash"


mailboxIcon : Mailbox -> String
mailboxIcon mailbox =
    case mailbox of
        Inbox ->
            "inbox"

        Starred ->
            "star"

        Sent ->
            "send"

        Drafts ->
            "drafts"

        Trash ->
            "delete"


type alias Message =
    { id : Int
    , mailbox : Mailbox
    , sender : String
    , subject : String
    , preview : String
    , body : String
    , time : String
    , unread : Bool
    , starred : Bool
    }


messages : List Message
messages =
    [ { id = 1
      , mailbox = Inbox
      , sender = "Ali Connors"
      , subject = "Brunch this weekend?"
      , preview = "I'll be in your neighborhood doing errands on Saturday. Want to grab brunch?"
      , body = "Hey! I'll be in your neighborhood doing errands this Saturday. Do you want to grab brunch? I found this great new spot on 5th that does an amazing weekend menu. Let me know what works for you — I'm free any time after 10."
      , time = "9:14 AM"
      , unread = True
      , starred = True
      }
    , { id = 2
      , mailbox = Inbox
      , sender = "Design Team"
      , subject = "Material 3 component review"
      , preview = "The updated tokens are ready for review. Can you take a look before standup?"
      , body = "The updated Material 3 Expressive tokens are ready for review in Figma. We tightened the corner radii on the container shapes and adjusted the elevation ramp. Can you take a look before standup tomorrow? Particularly interested in your read on the new tonal-surface mapping."
      , time = "8:02 AM"
      , unread = True
      , starred = False
      }
    , { id = 3
      , mailbox = Inbox
      , sender = "Trevor Hansen"
      , subject = "Re: Quarterly roadmap"
      , preview = "Thanks for the notes — I've folded them into the deck. One open question on Q3."
      , body = "Thanks for the notes — I've folded them into the deck. There's one open question on the Q3 milestones: do we want to ship the inbox redesign before or after the search overhaul? Happy to discuss live if that's easier."
      , time = "Yesterday"
      , unread = False
      , starred = False
      }
    , { id = 4
      , mailbox = Inbox
      , sender = "Britta Holt"
      , subject = "Recipe to try"
      , preview = "This braised short rib recipe is unreal. Sending it before I forget."
      , body = "This braised short rib recipe is unreal — we made it last night and it was the best thing I've cooked all winter. Sending it before I forget. The trick is the two-hour low braise and a splash of fish sauce at the end. Trust me."
      , time = "Yesterday"
      , unread = False
      , starred = True
      }
    , { id = 5
      , mailbox = Starred
      , sender = "Sandra Adams"
      , subject = "Concert tickets are live"
      , preview = "Presale starts at noon. I added it to the shared calendar so we don't miss it."
      , body = "Presale starts at noon today! I added it to the shared calendar so we don't miss it again like last time. There are four of us, so grab two pairs if you can and I'll Venmo you my half."
      , time = "Mon"
      , unread = False
      , starred = True
      }
    , { id = 6
      , mailbox = Sent
      , sender = "You"
      , subject = "Re: Budget approval"
      , preview = "Approved — go ahead and place the order. Loop me in on the invoice."
      , body = "Approved — go ahead and place the order. Loop me in on the invoice when it comes through so I can code it to the right cost center. Nice work pulling this together."
      , time = "Tue"
      , unread = False
      , starred = False
      }
    , { id = 7
      , mailbox = Drafts
      , sender = "You"
      , subject = "Notes for the offsite"
      , preview = "Draft agenda — still need to add the afternoon breakout sessions."
      , body = "Draft agenda for the offsite. Still need to add the afternoon breakout sessions and confirm the dinner reservation. Placeholder for now."
      , time = "Wed"
      , unread = False
      , starred = False
      }
    ]


{-| Pure search filter: a message matches when the query (case-insensitive,
trimmed) is empty, or appears in the sender, subject, or preview. Kept as a
top-level pure function so it is trivially testable and obviously correct.
-}
matchesQuery : String -> Message -> Bool
matchesQuery rawQuery message =
    let
        q =
            String.toLower (String.trim rawQuery)
    in
    if String.isEmpty q then
        True

    else
        List.any (\field -> String.contains q (String.toLower field))
            [ message.sender, message.subject, message.preview ]


{-| Messages for the current mailbox, narrowed by the search query.
-}
visibleMessages : Model -> List Message
visibleMessages model =
    messages
        |> List.filter (\m -> m.mailbox == model.mailbox)
        |> List.filter (matchesQuery model.query)


unreadCount : Mailbox -> Int
unreadCount mailbox =
    messages
        |> List.filter (\m -> m.mailbox == mailbox && m.unread)
        |> List.length



-- MODEL


type alias Model =
    { mailbox : Mailbox
    , query : String
    , selected : Maybe Int
    , checked : List Int
    , composing : Bool
    , compose : ComposeFields
    , toast : Maybe String
    }


type alias ComposeFields =
    { to : String
    , subject : String
    , body : String
    }


emptyCompose : ComposeFields
emptyCompose =
    { to = "", subject = "", body = "" }


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


type Msg
    = SelectMailbox Mailbox
    | SetQuery String
    | SelectMessage Int
    | CloseReadingPane
    | ToggleChecked Int Bool
    | ToggleStar Int Bool
    | OpenCompose
    | CloseCompose
    | SetComposeTo String
    | SetComposeSubject String
    | SetComposeBody String
    | SendMessage
    | ScheduleSend
    | ArchiveSelected
    | NoOp



-- ROUTE


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = \_ _ _ _ -> Sub.none
            }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { mailbox = Inbox
      , query = ""
      , selected = Nothing
      , checked = []
      , composing = False
      , compose = emptyCompose
      , toast = Nothing
      }
    , Effect.none
    )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SelectMailbox mailbox ->
            ( { model | mailbox = mailbox, selected = Nothing, checked = [] }, Effect.none )

        SetQuery query ->
            ( { model | query = query }, Effect.none )

        SelectMessage id ->
            ( { model | selected = Just id }, Effect.none )

        CloseReadingPane ->
            ( { model | selected = Nothing }, Effect.none )

        ToggleChecked id isChecked ->
            let
                checked =
                    if isChecked then
                        id :: List.filter ((/=) id) model.checked

                    else
                        List.filter ((/=) id) model.checked
            in
            ( { model | checked = checked }, Effect.none )

        ToggleStar _ _ ->
            -- Demo data is static; starring is a no-op that still proves the
            -- toggle IconButton wiring compiles and renders.
            ( model, Effect.none )

        OpenCompose ->
            ( { model | composing = True, compose = emptyCompose }, Effect.none )

        CloseCompose ->
            ( { model | composing = False }, Effect.none )

        SetComposeTo value ->
            ( { model | compose = setTo value model.compose }, Effect.none )

        SetComposeSubject value ->
            ( { model | compose = setSubject value model.compose }, Effect.none )

        SetComposeBody value ->
            ( { model | compose = setBody value model.compose }, Effect.none )

        SendMessage ->
            ( { model | composing = False, compose = emptyCompose, toast = Just "Message sent" }
            , Effect.none
            )

        ScheduleSend ->
            ( { model | composing = False, compose = emptyCompose, toast = Just "Send scheduled" }
            , Effect.none
            )

        ArchiveSelected ->
            ( { model | selected = Nothing, checked = [], toast = Just "Conversation archived" }
            , Effect.none
            )

        NoOp ->
            ( model, Effect.none )


setTo : String -> ComposeFields -> ComposeFields
setTo value fields =
    { fields | to = value }


setSubject : String -> ComposeFields -> ComposeFields
setSubject value fields =
    { fields | subject = value }


setBody : String -> ComposeFields -> ComposeFields
setBody value fields =
    { fields | body = value }



-- HEAD


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "Reply — an interactive Material 3 email client built with elm-m3e."
        , locale = Nothing
        , title = "Reply · Studies · elm-m3e"
        }
        |> Seo.website



-- VIEW


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = "Reply · Studies · elm-m3e"
    , body =
        [ Html.map PagesMsg.fromMsg (viewApp model) ]
    }


viewApp : Model -> Html Msg
viewApp model =
    Theme.new
        |> Theme.withSeedColor "#4F6354"
        |> Theme.withVariant Theme.Vibrant
        |> Theme.withScheme Theme.Light
        |> Theme.view
            [ div [ class "flex h-[100dvh] w-full overflow-hidden bg-surface-container-lowest text-on-surface md:h-[calc(100vh-2rem)] md:min-h-[36rem] md:rounded-md-corner-large md:border md:border-outline-variant" ]
                [ viewSideNav model
                , div [ class "relative flex min-w-0 flex-1 flex-col" ]
                    [ viewAppBar model
                    , div [ class "min-h-0 flex-1 overflow-hidden" ] [ viewMain model ]
                    , viewBottomNav model
                    , viewComposeFab model
                    , viewCompose model
                    , viewSnackbar model
                    ]
                ]
            ]


{-| Drawer on large screens, rail on medium. Hidden on compact (the
NavigationBar takes over at the bottom). This swap is the responsive "Size"
concern from the coverage matrix.

The lg "drawer" is an `NavigationRail` in `Expanded` mode (the rail's wide
variant) rather than a real `m3e-drawer-container` — the drawer-container
primitive wraps its content (slot-based layout), so dropping it as a sibling
of the list/detail collapses to zero height. The expanded rail gives the
same shape (icon + label, full destination labels) without that constraint.
A persistent `NavigationDrawer` shell would require restructuring the entire
study so the inbox lives in the drawer's content slot.

`contents` on the outer wrapper collapses it for layout so the visible rail
sits as a direct flex child of the app shell.

-}
viewSideNav : Model -> Html Msg
viewSideNav model =
    div [ class "contents" ]
        [ -- Large screens: expanded rail (drawer-like; icon + label per item)
          div [ class "hidden h-full border-r border-outline-variant bg-surface-container-low lg:block" ]
            [ navRail NavigationRail.Expanded model ]
        , -- Medium screens: compact navigation rail (icons only)
          div [ class "hidden h-full border-r border-outline-variant bg-surface-container-low md:block lg:hidden" ]
            [ navRail NavigationRail.Compact model ]
        ]


navRail : NavigationRail.Mode -> Model -> Html Msg
navRail mode model =
    NavigationRail.new
        { items = List.map railItem allMailboxes
        , selected = Just model.mailbox
        , onChange = SelectMailbox
        }
        |> NavigationRail.withId
            (case mode of
                NavigationRail.Expanded ->
                    "reply-rail-expanded"

                _ ->
                    "reply-rail-compact"
            )
        |> NavigationRail.withMode mode
        |> NavigationRail.view


railItem : Mailbox -> NavigationRail.Item Mailbox Msg
railItem mailbox =
    let
        base =
            NavigationRail.item
                { value = mailbox
                , icon = Icon.material (mailboxIcon mailbox)
                }
                |> NavigationRail.withItemLabel (mailboxLabel mailbox)
    in
    if unreadCount mailbox > 0 then
        NavigationRail.withItemBadge (String.fromInt (unreadCount mailbox)) base

    else
        base


{-| Compact-only bottom navigation bar. Hidden when the reading pane is open
on compact so the message body owns the full viewport.
-}
viewBottomNav : Model -> Html Msg
viewBottomNav model =
    let
        hideWhenReading =
            case model.selected of
                Just _ ->
                    "hidden"

                Nothing ->
                    ""
    in
    div [ class ("bg-surface-container-low md:hidden " ++ hideWhenReading) ]
        [ Divider.new |> Divider.view
        , NavigationBar.new
            { items = List.map barItem [ Inbox, Starred, Sent, Drafts ]
            , selected = Just model.mailbox
            , onChange = SelectMailbox
            }
            |> NavigationBar.withId "reply-bar"
            |> NavigationBar.view
        ]


barItem : Mailbox -> NavigationBar.Item Mailbox Msg
barItem mailbox =
    let
        base =
            NavigationBar.item
                { value = mailbox
                , icon = Icon.material (mailboxIcon mailbox)
                }
                |> NavigationBar.withItemLabel (mailboxLabel mailbox)
    in
    if unreadCount mailbox > 0 then
        NavigationBar.withItemBadge (String.fromInt (unreadCount mailbox)) base

    else
        base



-- APP BAR


viewAppBar : Model -> Html Msg
viewAppBar model =
    AppBar.new
        |> AppBar.withTitle (Heading.title (appBarTitle model))
        |> AppBar.withId "reply-appbar"
        |> AppBar.withSize AppBar.Small
        |> AppBar.withLeadingHtmlElementEscapeHatch Html.div [] [ leadingControl model ]
        -- Search occupies most of the trailing slot at md+; hidden on
        -- compact (a search icon button replaces it).
        |> AppBar.withTrailingHtmlElementEscapeHatch Html.div
            [ class "hidden md:block min-w-0 max-w-md flex-1" ]
            [ searchBar model ]
        |> AppBar.withTrailingHtmlElementEscapeHatch Html.div [ class "md:hidden" ] [ compactSearchButton ]
        |> AppBar.withTrailingHtmlElementEscapeHatch Html.div [] [ notificationsButton ]
        |> AppBar.withTrailingHtmlElementEscapeHatch Html.div
            []
            [ Avatar.initials "Jane Reed"
                |> Avatar.withId "reply-user-avatar"
                |> Avatar.view
            ]
        |> AppBar.view


{-| On compact, when a message is selected the reading pane replaces the list
and the app bar title becomes the conversation subject (truncated) — feels
more like a native mail client. On md+ the title is the mailbox label.
-}
appBarTitle : Model -> String
appBarTitle model =
    case ( model.selected, model.selected |> Maybe.andThen findMessage ) of
        ( Just _, Just message ) ->
            message.subject

        _ ->
            mailboxLabel model.mailbox


{-| Compact: a back arrow when a message is open, otherwise the menu icon.
At md+ this is always the menu icon.
-}
leadingControl : Model -> Html Msg
leadingControl model =
    case model.selected of
        Just _ ->
            div []
                [ -- Back arrow only on compact; the desktop SplitPane keeps the list visible.
                  div [ class "md:hidden" ] [ backLeading ]
                , div [ class "hidden md:block" ] [ menuLeading ]
                ]

        Nothing ->
            menuLeading


backLeading : Html Msg
backLeading =
    IconButton.new
        { icon = Icon.material "arrow_back"
        , label = "Back to inbox"
        , variant = IconButton.Standard
        }
        |> IconButton.withOnClick CloseReadingPane
        |> IconButton.view


compactSearchButton : Html Msg
compactSearchButton =
    IconButton.new
        { icon = Icon.material "search"
        , label = "Search mail"
        , variant = IconButton.Standard
        }
        |> IconButton.view


menuLeading : Html Msg
menuLeading =
    div [ attribute "id" "reply-menu-anchor" ]
        [ IconButton.new
            { icon = Icon.material "menu"
            , label = "Mailboxes"
            , variant = IconButton.Standard
            }
            |> IconButton.view
        ]


searchBar : Model -> Html Msg
searchBar model =
    Search.bar
        |> Search.withId "reply-search"
        |> Search.withPlaceholder "Search mail"
        |> Search.withQuery model.query SetQuery
        |> Search.withClearable True
        |> Search.view


notificationsButton : Html Msg
notificationsButton =
    let
        total =
            unreadCount Inbox
    in
    div [ class "relative", attribute "id" "reply-notifications" ]
        [ IconButton.new
            { icon = Icon.material "notifications"
            , label = "Notifications"
            , variant = IconButton.Standard
            }
            |> IconButton.view
        , if total > 0 then
            Badge.count total
                |> Badge.withFor "reply-notifications"
                |> Badge.view

          else
            text ""
        ]



-- MAIN (list ⇄ reading pane)


viewMain : Model -> Html Msg
viewMain model =
    case model.selected of
        Just id ->
            case findMessage id of
                Just message ->
                    div [ class "h-full" ]
                        [ -- md+: SplitPane keeps list visible alongside the reading pane.
                          div [ class "hidden h-full md:block" ]
                            [ SplitPane.new
                                |> SplitPane.withId "reply-splitpane"
                                |> SplitPane.withStart [ messageListPane model ]
                                |> SplitPane.withEnd [ readingPane message ]
                                |> SplitPane.view
                            ]
                        , -- Compact: reading pane stacks over the list — single column.
                          div [ class "h-full md:hidden" ] [ readingPane message ]
                        ]

                Nothing ->
                    messageListPane model

        Nothing ->
            messageListPane model


findMessage : Int -> Maybe Message
findMessage id =
    messages
        |> List.filter (\m -> m.id == id)
        |> List.head


messageListPane : Model -> Html Msg
messageListPane model =
    let
        shown =
            visibleMessages model
    in
    ScrollContainer.new
        |> ScrollContainer.withId "reply-list-scroll"
        |> ScrollContainer.withDividers ScrollContainer.Top
        |> ScrollContainer.view
            [ div [ class "flex flex-col" ]
                (if List.isEmpty shown then
                    [ emptyState model.query ]

                 else
                    List.intersperse listDivider (List.map (messageRow model) shown)
                )
            ]


listDivider : Html Msg
listDivider =
    Divider.new
        |> Divider.withInsetStart True
        |> Divider.view


emptyState : String -> Html Msg
emptyState query =
    div [ class "flex flex-col items-center gap-2 px-6 py-16 text-center text-on-surface-variant" ]
        [ Icon.material "mail" |> Icon.view
        , p [ class "text-body-medium" ]
            [ text
                (if String.isEmpty (String.trim query) then
                    "No conversations here."

                 else
                    "No conversations match \"" ++ query ++ "\"."
                )
            ]
        ]


messageRow : Model -> Message -> Html Msg
messageRow model message =
    let
        isSelected =
            model.selected == Just message.id

        isChecked =
            List.member message.id model.checked

        rowBg =
            if isSelected then
                "bg-secondary-container"

            else if message.unread then
                "bg-surface-container-low hover:bg-surface-container"

            else
                "hover:bg-surface-container-low"

        starId =
            "reply-star-" ++ String.fromInt message.id
    in
    div [ class ("flex items-start gap-3 px-3 py-3 transition-colors " ++ rowBg) ]
        [ div [ class "pt-1" ]
            [ Checkbox.boolean
                { label = "Select " ++ message.subject
                , checked = isChecked
                , onChange = ToggleChecked message.id
                }
                |> Checkbox.withId ("reply-check-" ++ String.fromInt message.id)
                |> Checkbox.view
            ]
        , Avatar.initials message.sender
            |> Avatar.withId ("reply-avatar-" ++ String.fromInt message.id)
            |> Avatar.view
        , div
            [ class "min-w-0 flex-1 cursor-pointer"
            , attribute "role" "button"
            , Html.Events.onClick (SelectMessage message.id)
            ]
            [ div [ class "flex items-baseline justify-between gap-2" ]
                [ span
                    [ class
                        ("truncate text-title-small "
                            ++ (if message.unread then
                                    "font-semibold text-on-surface"

                                else
                                    "text-on-surface-variant"
                               )
                        )
                    ]
                    [ text message.sender ]
                , span [ class "shrink-0 text-label-small text-on-surface-variant" ] [ text message.time ]
                ]
            , div
                [ class
                    ("truncate text-body-medium "
                        ++ (if message.unread then
                                "font-medium text-on-surface"

                            else
                                "text-on-surface-variant"
                           )
                    )
                ]
                [ text message.subject ]
            , p [ class "mt-0.5 line-clamp-1 text-body-small text-on-surface-variant" ] [ text message.preview ]
            ]
        , div [ class "flex flex-col items-center gap-1" ]
            [ div [ attribute "id" starId ]
                [ IconButton.new
                    { icon = Icon.material "star"
                    , label =
                        if message.starred then
                            "Unstar"

                        else
                            "Star"
                    , variant = IconButton.Standard
                    }
                    |> IconButton.withSize IconButton.Small
                    |> IconButton.withToggle
                        { selected = message.starred
                        , onChange = ToggleStar message.id
                        , selectedIcon = Just (Icon.material "star" |> Icon.withFilled True)
                        }
                    |> IconButton.view
                ]
            , Tooltip.plain
                { anchorId = starId
                , label =
                    if message.starred then
                        "Remove star"

                    else
                        "Add star"
                }
                |> Tooltip.view
            ]
        ]



-- READING PANE


readingPane : Message -> Html Msg
readingPane message =
    ScrollContainer.new
        |> ScrollContainer.withId "reply-reading-scroll"
        |> ScrollContainer.view
            [ div [ class "flex flex-col gap-4 p-4 md:p-6" ]
                [ div [ class "flex items-start justify-between gap-3" ]
                    [ Heading.new
                        |> Heading.withVariant Heading.Headline
                        |> Heading.withSize Heading.Small
                        |> Heading.withLevel 2
                        |> Heading.withContent (text message.subject)
                        |> Heading.view
                    , readingActions
                    ]
                , Divider.new |> Divider.view
                , div [ class "flex items-center gap-3" ]
                    [ Avatar.initials message.sender
                        |> Avatar.withId "reply-reading-avatar"
                        |> Avatar.view
                    , div [ class "min-w-0 flex-1" ]
                        [ div [ class "text-title-small font-medium text-on-surface" ] [ text message.sender ]
                        , div [ class "text-body-small text-on-surface-variant" ] [ text ("to me · " ++ message.time) ]
                        ]
                    ]
                , p [ class "whitespace-pre-line text-body-large leading-relaxed text-on-surface" ] [ text message.body ]
                , Divider.new |> Divider.view
                , div [ class "flex flex-wrap gap-2" ]
                    [ Button.new { label = "Reply", variant = Button.Filled }
                        |> Button.withLeadingIcon (Icon.material "reply")
                        |> Button.withOnClick OpenCompose
                        |> Button.view
                    , Button.new { label = "Forward", variant = Button.Tonal }
                        |> Button.withLeadingIcon (Icon.material "forward")
                        |> Button.withOnClick OpenCompose
                        |> Button.view
                    ]
                ]
            ]


readingActions : Html Msg
readingActions =
    div [ class "flex shrink-0 items-center gap-1" ]
        [ -- The compact app bar already has a back arrow; hide the close button there.
          div [ class "hidden md:block" ] [ closeReadingButton ]
        , archiveButton
        , overflowMenu
        ]


closeReadingButton : Html Msg
closeReadingButton =
    IconButton.new
        { icon = Icon.material "close"
        , label = "Close conversation"
        , variant = IconButton.Standard
        }
        |> IconButton.withOnClick CloseReadingPane
        |> IconButton.view


archiveButton : Html Msg
archiveButton =
    let
        anchor =
            "reply-archive"
    in
    div [ class "flex flex-col items-center" ]
        [ div [ attribute "id" anchor ]
            [ IconButton.new
                { icon = Icon.material "archive"
                , label = "Archive"
                , variant = IconButton.Standard
                }
                |> IconButton.withOnClick ArchiveSelected
                |> IconButton.view
            ]
        , Tooltip.plain { anchorId = anchor, label = "Archive" }
            |> Tooltip.view
        ]


overflowMenu : Html Msg
overflowMenu =
    div [ attribute "id" "reply-overflow", class "relative" ]
        [ IconButton.new
            { icon = Icon.material "more_vert"
            , label = "More actions"
            , variant = IconButton.Standard
            }
            |> IconButton.view
        , Menu.new
            [ Menu.item "Mark as unread" NoOp
                |> Menu.withItemIcon (Icon.material "mark_email_unread")
            , Menu.item "Move to" NoOp
                |> Menu.withItemIcon (Icon.material "drive_file_move")
            , Menu.item "Report spam" NoOp
                |> Menu.withItemIcon (Icon.material "report")
            , Menu.item "Delete" ArchiveSelected
                |> Menu.withItemIcon (Icon.material "delete")
            ]
            |> Menu.withId "reply-overflow-menu"
            |> Menu.view
        ]



-- COMPOSE


viewComposeFab : Model -> Html Msg
viewComposeFab model =
    -- Hide the FAB while the reading pane covers the screen on compact — the
    -- inline Reply/Forward buttons own that flow there and the FAB would
    -- collide with them. md+ keeps the FAB visible regardless.
    let
        compactHide =
            case model.selected of
                Just _ ->
                    "hidden md:block"

                Nothing ->
                    ""
    in
    div [ class ("absolute bottom-20 right-4 z-10 md:bottom-6 md:right-6 " ++ compactHide) ]
        [ Fab.new
            { icon = Icon.material "edit"
            , label = "Compose"
            , variant = Fab.Primary
            }
            |> Fab.withOnClick OpenCompose
            |> Fab.view
        ]


viewCompose : Model -> Html Msg
viewCompose model =
    BottomSheet.new { open = model.composing, onClose = CloseCompose }
        |> BottomSheet.withId "reply-compose"
        |> BottomSheet.withModal True
        |> BottomSheet.withHandle True
        |> BottomSheet.withAttributes
            -- Without explicit detents the m3e-bottom-sheet opens to a 16px
            -- peek and waits for a drag gesture; on a touch-less test page
            -- that hides the compose form entirely. Three detents matches
            -- the m3e example (`fit half full`) and the property `detent: 2`
            -- snaps to the full-height detent on open.
            [ attribute "detents" "fit half full"
            , attribute "detent" "2"
            ]
        |> BottomSheet.withHeader
            (Heading.new
                |> Heading.withVariant Heading.Title
                |> Heading.withSize Heading.Large
                |> Heading.withLevel 2
                |> Heading.withContent (text "New message")
                |> Heading.view
            )
        |> BottomSheet.withBody (composeBody model.compose)
        |> BottomSheet.view


composeBody : ComposeFields -> Html Msg
composeBody fields =
    div [ class "flex flex-col gap-4 pt-2" ]
        [ TextField.text
            { label = "To"
            , value = fields.to
            , variant = TextField.Outlined
            , onChange = SetComposeTo
            }
            |> TextField.withId "reply-compose-to"
            |> TextField.withEmailValidator
            |> TextField.view
        , TextField.text
            { label = "Subject"
            , value = fields.subject
            , variant = TextField.Outlined
            , onChange = SetComposeSubject
            }
            |> TextField.withId "reply-compose-subject"
            |> TextField.view
        , TextField.multiline
            { label = "Message"
            , value = fields.body
            , variant = TextField.Outlined
            , onChange = SetComposeBody
            }
            |> TextField.withId "reply-compose-body"
            |> TextField.withRows 5
            |> TextField.view
        , div [ class "flex items-center justify-between gap-2" ]
            [ Button.new { label = "Discard", variant = Button.Text }
                |> Button.withOnClick CloseCompose
                |> Button.view
            , SplitButton.new
                { label = "Send"
                , onPrimaryClick = SendMessage
                , onTriggerClick = ScheduleSend
                , trailingIcon = Icon.material "schedule_send"
                }
                |> SplitButton.withVariant SplitButton.Filled
                |> SplitButton.withTriggerLabel "Schedule send"
                |> SplitButton.view
            ]
        ]



-- SNACKBAR


viewSnackbar : Model -> Html Msg
viewSnackbar model =
    case model.toast of
        Just message ->
            Snackbar.new message
                |> Snackbar.withId "reply-snackbar"
                |> Snackbar.withAction "Undo"
                |> Snackbar.withDismissible True
                |> Snackbar.view

        Nothing ->
            text ""
