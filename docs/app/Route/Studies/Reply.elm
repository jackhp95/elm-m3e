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
import Html exposing (div, p, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events
import Layout
import M3e.AppBar as AppBar
import M3e.Avatar as Avatar
import M3e.Badge as Badge
import M3e.BottomSheet as BottomSheet
import M3e.Button as Button
import M3e.Checkbox as Checkbox
import M3e.Divider as Divider
import M3e.Fab as Fab
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.IconButton as IconButton
import M3e.Menu as Menu
import M3e.NavigationBar as NavigationBar
import M3e.NavigationRail as NavigationRail
import M3e.Node as Node exposing (Node)
import M3e.Element as Element exposing (Element, Supported)
import M3e.ScrollContainer as ScrollContainer
import M3e.Search as Search
import M3e.Snackbar as Snackbar
import M3e.SplitButton as SplitButton
import M3e.SplitPane as SplitPane
import M3e.TextField as TextField
import M3e.Theme as Theme
import M3e.Tooltip as Tooltip
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
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
        [ Node.map PagesMsg.fromMsg (viewApp model) ]
    }


viewApp : Model -> Node Msg
viewApp model =
    Theme.view
        { content =
            [ Element.fromNode
                (Layout.div "flex h-[100dvh] w-full overflow-hidden bg-surface-container-lowest text-on-surface md:h-[calc(100vh-2rem)] md:min-h-[36rem] md:rounded-md-corner-large md:border md:border-outline-variant"
                    [ viewSideNav model
                    , Layout.div "relative flex min-w-0 flex-1 flex-col"
                        [ viewAppBar model
                        , Layout.div "min-h-0 flex-1 overflow-hidden" [ viewMain model ]
                        , viewBottomNav model
                        , viewComposeFab model
                        , viewCompose model
                        , viewSnackbar model
                        ]
                    ]
                )
            ]
        }
        [ Theme.seedColor "#4F6354"
        , Theme.variant Theme.Vibrant
        , Theme.scheme Theme.Light
        ]
        |> Element.toNode


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
viewSideNav : Model -> Node Msg
viewSideNav model =
    Layout.div "contents"
        [ -- Large screens: expanded rail (drawer-like; icon + label per item)
          Layout.div "hidden h-full border-r border-outline-variant bg-surface-container-low lg:block"
            [ navRail NavigationRail.Expanded model ]
        , -- Medium screens: compact navigation rail (icons only)
          Layout.div "hidden h-full border-r border-outline-variant bg-surface-container-low md:block lg:hidden"
            [ navRail NavigationRail.Compact model ]
        ]


navRail : NavigationRail.Mode -> Model -> Node Msg
navRail railMode model =
    NavigationRail.view
        { items = List.map (railItem model.mailbox) allMailboxes }
        [ NavigationRail.id
            (case railMode of
                NavigationRail.Expanded ->
                    "reply-rail-expanded"

                _ ->
                    "reply-rail-compact"
            )
        , NavigationRail.mode railMode
        ]
        |> Element.toNode


railItem : Mailbox -> Mailbox -> Element { s | navItem : Supported } Msg
railItem selectedMailbox mailbox =
    NavigationRail.item
        { icon = Icon.view { name = mailboxIcon mailbox }, label = mailboxLabel mailbox }
        ([ NavigationRail.itemSelected (mailbox == selectedMailbox)
         , NavigationRail.itemOnClick (SelectMailbox mailbox)
         ]
            ++ (if unreadCount mailbox > 0 then
                    [ NavigationRail.itemBadge (String.fromInt (unreadCount mailbox)) ]

                else
                    []
               )
        )


{-| Compact-only bottom navigation bar. Hidden when the reading pane is open
on compact so the message body owns the full viewport.
-}
viewBottomNav : Model -> Node Msg
viewBottomNav model =
    let
        hideWhenReading =
            case model.selected of
                Just _ ->
                    "hidden"

                Nothing ->
                    ""
    in
    Layout.div ("bg-surface-container-low md:hidden " ++ hideWhenReading)
        [ Divider.view [] |> Element.toNode
        , NavigationBar.view
            { items = List.map (barItem model.mailbox) [ Inbox, Starred, Sent, Drafts ] }
            [ NavigationBar.id "reply-bar" ]
            |> Element.toNode
        ]


barItem : Mailbox -> Mailbox -> Element { navItem : Supported } Msg
barItem selectedMailbox mailbox =
    NavigationBar.item
        { icon = Icon.view { name = mailboxIcon mailbox }, label = mailboxLabel mailbox }
        ([ NavigationBar.itemSelected (mailbox == selectedMailbox)
         , NavigationBar.itemOnClick (SelectMailbox mailbox)
         ]
            ++ (if unreadCount mailbox > 0 then
                    [ NavigationBar.itemBadge (String.fromInt (unreadCount mailbox)) ]

                else
                    []
               )
        )



-- APP BAR


viewAppBar : Model -> Node Msg
viewAppBar model =
    let
        -- Leading: back arrow on compact when reading, otherwise menu
        leadingElem =
            case model.selected of
                Just _ ->
                    Element.element { tag = "div" } []
                        [ Node.element "div"
                            [ Node.attribute "class" "md:hidden" ]
                            [ Element.toNode
                                (IconButton.view { icon = "arrow_back", ariaLabel = "Back to inbox" }
                                    [ IconButton.onClick CloseReadingPane ]
                                )
                            ]
                        , Node.element "div"
                            [ Node.attribute "class" "hidden md:block"
                            , Node.attribute "id" "reply-menu-anchor"
                            ]
                            [ Element.toNode (IconButton.view { icon = "menu", ariaLabel = "Mailboxes" } []) ]
                        ]

                Nothing ->
                    Element.element { tag = "div" }
                        [ Node.attribute "id" "reply-menu-anchor" ]
                        [ Element.toNode (IconButton.view { icon = "menu", ariaLabel = "Mailboxes" } []) ]

        -- Search bar: visible md+
        searchElem =
            Element.element { tag = "div" }
                [ Node.attribute "class" "hidden md:block min-w-0 max-w-md flex-1" ]
                [ searchBar model ]

        -- Search icon button: compact only
        compactSearchElem =
            Element.element { tag = "div" }
                [ Node.attribute "class" "md:hidden" ]
                [ Element.toNode
                    (IconButton.view { icon = "search", ariaLabel = "Search mail" } [])
                ]

        -- Notifications with badge
        total =
            unreadCount Inbox

        notifElem =
            Element.element { tag = "div" }
                [ Node.attribute "class" "relative"
                , Node.attribute "id" "reply-notifications"
                ]
                (Element.toNode (IconButton.view { icon = "notifications", ariaLabel = "Notifications" } [])
                    :: (if total > 0 then
                            [ Element.toNode (Badge.view [ Badge.count total ]) ]

                        else
                            []
                       )
                )

        -- User avatar
        avatarElem =
            Avatar.view { ariaLabel = "Jane Reed" }
                [ Avatar.initials "Jane Reed" ]
    in
    AppBar.view
        [ AppBar.id "reply-appbar"
        , AppBar.size AppBar.Small
        , AppBar.leading leadingElem
        , AppBar.title
            (Heading.view { label = appBarTitle model, variant = Heading.Title } [])
        , AppBar.trailing [ searchElem, compactSearchElem, notifElem, avatarElem ]
        ]
        |> Element.toNode


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


searchBar : Model -> Node Msg
searchBar model =
    Search.view { placeholder = "Search mail" }
        [ Search.onInput SetQuery
        , Search.value model.query
        , Search.clearable True
        ]
        |> Element.toNode



-- MAIN (list ⇄ reading pane)


viewMain : Model -> Node Msg
viewMain model =
    case model.selected of
        Just id ->
            case findMessage id of
                Just message ->
                    Layout.div "h-full"
                        [ -- md+: SplitPane keeps list visible alongside the reading pane.
                          Layout.div "hidden h-full md:block"
                            [ SplitPane.view
                                { start = [ Element.fromNode (messageListPane model) ]
                                , end = [ Element.fromNode (readingPane message) ]
                                }
                                []
                                |> Element.toNode
                            ]
                        , -- Compact: reading pane stacks over the list — single column.
                          Layout.div "h-full md:hidden" [ readingPane message ]
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


messageListPane : Model -> Node Msg
messageListPane model =
    let
        shown =
            visibleMessages model
    in
    ScrollContainer.view
        { content =
            [ Element.fromNode
                (Layout.div "flex flex-col"
                    (if List.isEmpty shown then
                        [ emptyState model.query ]

                     else
                        List.intersperse listDivider (List.map (messageRow model) shown)
                    )
                )
            ]
        }
        [ ScrollContainer.dividers ScrollContainer.Above
        , ScrollContainer.attributes [ Node.rawAttr (class "block h-full") ]
        ]
        |> Element.toNode


listDivider : Node Msg
listDivider =
    Divider.view [ Divider.insetStart True ] |> Element.toNode


emptyState : String -> Node Msg
emptyState query =
    Layout.div "flex flex-col items-center gap-2 px-6 py-16 text-center text-on-surface-variant"
        [ Icon.view { name = "mail" } |> Element.toNode
        , Node.raw
            (p [ class "text-body-md" ]
                [ text
                    (if String.isEmpty (String.trim query) then
                        "No conversations here."

                     else
                        "No conversations match \"" ++ query ++ "\"."
                    )
                ]
            )
        ]


messageRow : Model -> Message -> Node Msg
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
    Layout.div ("flex items-start gap-3 px-3 py-3 transition-colors " ++ rowBg)
        [ Layout.div "pt-1"
            [ Checkbox.view { ariaLabel = "Select " ++ message.subject }
                [ Checkbox.checked isChecked
                , Checkbox.onChange (ToggleChecked message.id)
                ]
                |> Element.toNode
            ]
        , Avatar.view { ariaLabel = message.sender }
            [ Avatar.initials message.sender ]
            |> Element.toNode
        , Node.element "div"
            [ Node.rawAttr (class "min-w-0 flex-1 cursor-pointer")
            , Node.rawAttr (attribute "role" "button")
            , Node.rawAttr (Html.Events.onClick (SelectMessage message.id))
            ]
            [ Node.raw
                (div [ class "flex items-baseline justify-between gap-2" ]
                    [ span
                        [ class
                            ("truncate text-title-sm "
                                ++ (if message.unread then
                                        "font-semibold text-on-surface"

                                    else
                                        "text-on-surface-variant"
                                   )
                            )
                        ]
                        [ text message.sender ]
                    , span [ class "shrink-0 text-label-sm text-on-surface-variant" ] [ text message.time ]
                    ]
                )
            , Node.raw
                (div
                    [ class
                        ("truncate text-body-md "
                            ++ (if message.unread then
                                    "font-medium text-on-surface"

                                else
                                    "text-on-surface-variant"
                               )
                        )
                    ]
                    [ text message.subject ]
                )
            , Node.raw (p [ class "mt-0.5 line-clamp-1 text-body-sm text-on-surface-variant" ] [ text message.preview ])
            ]
        , Layout.div "flex flex-col items-center gap-1"
            [ Node.element "div" [ Node.rawAttr (attribute "id" starId) ]
                [ IconButton.view
                    { icon = "star"
                    , ariaLabel =
                        if message.starred then
                            "Unstar"

                        else
                            "Star"
                    }
                    [ IconButton.size IconButton.Small
                    , IconButton.toggle True
                    , IconButton.selected message.starred
                    , IconButton.onChange (ToggleStar message.id)
                    , IconButton.selectedIcon (Icon.view { name = "star" })
                    ]
                    |> Element.toNode
                ]
            , Tooltip.plain
                { anchorId = starId
                , label =
                    if message.starred then
                        "Remove star"

                    else
                        "Add star"
                }
                []
                |> Element.toNode
            ]
        ]



-- READING PANE


readingPane : Message -> Node Msg
readingPane message =
    ScrollContainer.view
        { content =
            [ Element.fromNode
                (Layout.div "flex flex-col gap-4 p-4 md:p-6"
                    [ Layout.div "flex items-start justify-between gap-3"
                        [ Heading.view { label = message.subject, variant = Heading.Headline }
                            [ Heading.size Heading.Small
                            , Heading.level 2
                            ]
                            |> Element.toNode
                        , readingActions
                        ]
                    , Divider.view [] |> Element.toNode
                    , Layout.row
                        [ Avatar.view { ariaLabel = message.sender }
                            [ Avatar.initials message.sender ]
                            |> Element.toNode
                        , Node.raw
                            (div [ class "min-w-0 flex-1" ]
                                [ div [ class "text-title-sm font-medium text-on-surface" ] [ text message.sender ]
                                , div [ class "text-body-sm text-on-surface-variant" ] [ text ("to me · " ++ message.time) ]
                                ]
                            )
                        ]
                    , Node.raw (p [ class "whitespace-pre-line text-body-lg leading-relaxed text-on-surface" ] [ text message.body ])
                    , Divider.view [] |> Element.toNode
                    , Layout.div "flex flex-wrap gap-2"
                        [ Button.view { label = "Reply", variant = Button.Filled }
                            [ Button.leadingIcon (Icon.view { name = "reply" })
                            , Button.onClick OpenCompose
                            ]
                            |> Element.toNode
                        , Button.view { label = "Forward", variant = Button.Tonal }
                            [ Button.leadingIcon (Icon.view { name = "forward" })
                            , Button.onClick OpenCompose
                            ]
                            |> Element.toNode
                        ]
                    ]
                )
            ]
        }
        [ ScrollContainer.attributes [ Node.rawAttr (class "block h-full") ] ]
        |> Element.toNode


readingActions : Node Msg
readingActions =
    Layout.div "flex shrink-0 items-center gap-1"
        [ -- The compact app bar already has a back arrow; hide the close button there.
          Layout.div "hidden md:block" [ closeReadingButton ]
        , archiveButton
        , overflowMenu
        ]


closeReadingButton : Node Msg
closeReadingButton =
    IconButton.view { icon = "close", ariaLabel = "Close conversation" }
        [ IconButton.onClick CloseReadingPane ]
        |> Element.toNode


archiveButton : Node Msg
archiveButton =
    let
        anchor =
            "reply-archive"
    in
    Layout.div "flex flex-col items-center"
        [ Node.element "div" [ Node.rawAttr (attribute "id" anchor) ]
            [ IconButton.view { icon = "archive", ariaLabel = "Archive" }
                [ IconButton.onClick ArchiveSelected ]
                |> Element.toNode
            ]
        , Tooltip.plain { anchorId = anchor, label = "Archive" } [] |> Element.toNode
        ]


overflowMenu : Node Msg
overflowMenu =
    Node.element "div" [ Node.rawAttr (attribute "id" "reply-overflow"), Node.rawAttr (class "relative") ]
        [ IconButton.view { icon = "more_vert", ariaLabel = "More actions" }
            [ IconButton.extraContent [ Menu.triggerFor "reply-overflow-menu" ] ]
            |> Element.toNode
        , Menu.view
            { items =
                [ Menu.item { label = "Mark as unread", action = Menu.Click NoOp }
                    [ Menu.itemLeadingIcon (Icon.view { name = "mark_email_unread" }) ]
                , Menu.item { label = "Move to", action = Menu.Click NoOp }
                    [ Menu.itemLeadingIcon (Icon.view { name = "drive_file_move" }) ]
                , Menu.item { label = "Report spam", action = Menu.Click NoOp }
                    [ Menu.itemLeadingIcon (Icon.view { name = "report" }) ]
                , Menu.item { label = "Delete", action = Menu.Click ArchiveSelected }
                    [ Menu.itemLeadingIcon (Icon.view { name = "delete" }) ]
                ]
            }
            [ Menu.id "reply-overflow-menu" ]
            |> Element.toNode
        ]



-- COMPOSE


viewComposeFab : Model -> Node Msg
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
    Layout.div ("absolute bottom-20 right-4 z-10 md:bottom-6 md:right-6 " ++ compactHide)
        [ Fab.view { icon = "edit", ariaLabel = "Compose" }
            [ Fab.label "Compose"
            , Fab.variant Fab.Primary
            , Fab.onClick OpenCompose
            ]
            |> Element.toNode
        ]


viewCompose : Model -> Node Msg
viewCompose model =
    -- TODO: The old API's BottomSheet.withAttributes for custom detents
    -- ("detents" = "fit half full", "detent" = "2") has no equivalent in
    -- M3e.BottomSheet options. The sheet opens to its default size.
    BottomSheet.view
        { content = [ Element.fromNode (composeBody model.compose) ] }
        [ BottomSheet.open model.composing
        , BottomSheet.onClose CloseCompose
        , BottomSheet.modal True
        , BottomSheet.handle True
        , BottomSheet.header
            [ Heading.view { label = "New message", variant = Heading.Title }
                [ Heading.size Heading.Large
                , Heading.level 2
                ]
            ]
        ]
        |> Element.toNode


composeBody : ComposeFields -> Node Msg
composeBody fields =
    Layout.div "flex flex-col gap-4 pt-2"
        [ TextField.view { label = "To" }
            [ TextField.id "reply-compose-to"
            , TextField.variant TextField.Outlined
            , TextField.inputType TextField.Email
            , TextField.value fields.to
            , TextField.onInput SetComposeTo
            ]
            |> Element.toNode
        , TextField.view { label = "Subject" }
            [ TextField.id "reply-compose-subject"
            , TextField.variant TextField.Outlined
            , TextField.value fields.subject
            , TextField.onInput SetComposeSubject
            ]
            |> Element.toNode
        , TextField.view { label = "Message" }
            [ TextField.id "reply-compose-body"
            , TextField.variant TextField.Outlined
            , TextField.multiline True
            , TextField.rows 5
            , TextField.value fields.body
            , TextField.onInput SetComposeBody
            ]
            |> Element.toNode
        , Layout.div "flex items-center justify-between gap-2"
            [ Button.view { label = "Discard", variant = Button.Text }
                [ Button.onClick CloseCompose ]
                |> Element.toNode
            , SplitButton.view
                { label = "Send"
                , name = "Schedule send"
                , trailingContent = [ Icon.view { name = "schedule_send" } ]
                , onPrimaryClick = SendMessage
                , onTriggerClick = ScheduleSend
                }
                [ SplitButton.variant SplitButton.Filled ]
                |> Element.toNode
            ]
        ]



-- SNACKBAR


viewSnackbar : Model -> Node Msg
viewSnackbar model =
    case model.toast of
        Just message ->
            Snackbar.view { message = message }
                [ Snackbar.id "reply-snackbar"
                , Snackbar.action "Undo"
                , Snackbar.dismissible True
                ]
                |> Element.toNode

        Nothing ->
            Node.text ""
