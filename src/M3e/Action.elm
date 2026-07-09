module M3e.Action exposing
    ( Action, LinkSpec, BottomSheetSpec, none, onClick, link, linkWith, remove, opensMenu, opensDialog, opensFabMenu, togglesNavRail, togglesDrawer, togglesDatepicker, opensBottomSheet, opensBottomSheetWith, dialogAction, bottomSheetAction, richTooltipAction, stepperReset, stepperPrevious, toAttrs, wrapContent
    )

{-| GENERATED (issue #37 C1) — a shared capability-typed behavioural value:
a component's "what happens" when activated, carried as one field so the
behaviours are mutually exclusive by construction. The `capability` row pins which
behaviours a binding site admits. Wrapper behaviours are emitted only for the
trigger components present in this manifest. Do not edit by hand; regenerate via
`bin/elm-cem.js`.

@docs Action, LinkSpec, BottomSheetSpec
@docs none
@docs onClick, link, linkWith, remove
@docs opensMenu, opensDialog, opensFabMenu, togglesNavRail, togglesDrawer, togglesDatepicker, opensBottomSheet, opensBottomSheetWith, dialogAction, bottomSheetAction, richTooltipAction, stepperReset, stepperPrevious
@docs toAttrs, wrapContent

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import M3e.Cem.Attr.Internal as Attr exposing (Attr)
import M3e.Cem.BottomSheetAction
import M3e.Cem.BottomSheetTrigger
import M3e.Cem.DatepickerToggle
import M3e.Cem.DialogAction
import M3e.Cem.DialogTrigger
import M3e.Cem.DrawerToggle
import M3e.Cem.FabMenuTrigger
import M3e.Cem.MenuTrigger
import M3e.Cem.NavRailToggle
import M3e.Cem.RichTooltipAction
import M3e.Cem.StepperPrevious
import M3e.Cem.StepperReset
import M3e.Node as Node exposing (Node)
import M3e.Value exposing (Supported)


{-| An opaque behavioural value: exactly one of the supported behaviours.
-}
type Action capability msg
    = Action (Payload msg)


type Payload msg
    = None
    | OnClick msg
    | Link LinkSpec
    | Remove msg
    | OpensMenu String
    | OpensDialog String
    | OpensFabMenu String
    | TogglesNavRail String
    | TogglesDrawer String
    | TogglesDatepicker String
    | OpensBottomSheet BottomSheetSpec
    | DialogAction String
    | BottomSheetAction
    | RichTooltipAction
    | StepperReset
    | StepperPrevious


{-| The parts of a link action — the `href`, plus optional `target`, `rel`, and `download`.
-}
type alias LinkSpec =
    { href : String, target : Maybe String, rel : Maybe String, download : Maybe String }


{-| The parts of a bottom-sheet trigger — the `for` id, plus optional `detent` and `secondary`.
-}
type alias BottomSheetSpec =
    { for : String, detent : Maybe Float, secondary : Maybe Bool }


{-| No behaviour: emits no host attributes and leaves the label unwrapped.
-}
none : Action capability msg
none =
    Action None


{-| A click action: emit `msg` when the element is activated.
-}
onClick : msg -> Action { c | click : Supported } msg
onClick m =
    Action (OnClick m)


{-| A link action pointing at `url`. For the full set of link attributes use [`linkWith`](#linkWith).
-}
link : String -> Action { c | link : Supported } msg
link url =
    Action (Link { href = url, target = Nothing, rel = Nothing, download = Nothing })


{-| A link action from a full [`LinkSpec`](#LinkSpec).
-}
linkWith : LinkSpec -> Action { c | link : Supported } msg
linkWith spec =
    Action (Link spec)


{-| A remove action: emit `msg` when the element requests removal.
-}
remove : msg -> Action { c | remove : Supported } msg
remove m =
    Action (Remove m)


{-| Open the menu whose id is `for`: wraps the label in `m3e-menu-trigger`.
-}
opensMenu : String -> Action { c | menuTrigger : Supported } msg
opensMenu for =
    Action (OpensMenu for)


{-| Open the dialog whose id is `for`: wraps the label in `m3e-dialog-trigger`.
-}
opensDialog : String -> Action { c | dialogTrigger : Supported } msg
opensDialog for =
    Action (OpensDialog for)


{-| Open the fab-menu whose id is `for`: wraps the label in `m3e-fab-menu-trigger`.
-}
opensFabMenu : String -> Action { c | fabMenuTrigger : Supported } msg
opensFabMenu for =
    Action (OpensFabMenu for)


{-| Toggle the nav-rail whose id is `for`: wraps the label in `m3e-nav-rail-toggle`.
-}
togglesNavRail : String -> Action { c | navRailToggle : Supported } msg
togglesNavRail for =
    Action (TogglesNavRail for)


{-| Toggle the drawer whose id is `for`: wraps the label in `m3e-drawer-toggle`.
-}
togglesDrawer : String -> Action { c | drawerToggle : Supported } msg
togglesDrawer for =
    Action (TogglesDrawer for)


{-| Toggle the datepicker whose id is `for`: wraps the label in `m3e-datepicker-toggle`.
-}
togglesDatepicker : String -> Action { c | datepickerToggle : Supported } msg
togglesDatepicker for =
    Action (TogglesDatepicker for)


{-| Open the bottom-sheet whose id is `for` (no `detent`/`secondary`): wraps the
label in `m3e-bottom-sheet-trigger`. For the full set use [`opensBottomSheetWith`](#opensBottomSheetWith).
-}
opensBottomSheet : String -> Action { c | bottomSheetTrigger : Supported } msg
opensBottomSheet for =
    Action (OpensBottomSheet { for = for, detent = Nothing, secondary = Nothing })


{-| Open a bottom-sheet from a full [`BottomSheetSpec`](#BottomSheetSpec).
-}
opensBottomSheetWith : BottomSheetSpec -> Action { c | bottomSheetTrigger : Supported } msg
opensBottomSheetWith spec =
    Action (OpensBottomSheet spec)


{-| Resolve the enclosing dialog with `returnValue`: wraps the label in `m3e-dialog-action`.
-}
dialogAction : { returnValue : String } -> Action { c | dialogAction : Supported } msg
dialogAction spec =
    Action (DialogAction spec.returnValue)


{-| Dismiss the enclosing bottom-sheet: wraps the label in `m3e-bottom-sheet-action`.
-}
bottomSheetAction : Action { c | bottomSheetAction : Supported } msg
bottomSheetAction =
    Action BottomSheetAction


{-| Dismiss the enclosing rich tooltip: wraps the label in `m3e-rich-tooltip-action`.
-}
richTooltipAction : Action { c | richTooltipAction : Supported } msg
richTooltipAction =
    Action RichTooltipAction


{-| Reset the enclosing stepper: wraps the label in `m3e-stepper-reset`.
-}
stepperReset : Action { c | stepperReset : Supported } msg
stepperReset =
    Action StepperReset


{-| Move the enclosing stepper to the previous step: wraps the label in `m3e-stepper-previous`.
-}
stepperPrevious : Action { c | stepperPrevious : Supported } msg
stepperPrevious =
    Action StepperPrevious


{-| The host-attribute wiring for a behaviour. Attribute behaviours
(`onClick`/`link`/`remove`) produce their attributes here; wrapper behaviours
produce none (their attributes live on the wrapper element).
-}
toAttrs : Action capability msg -> List (Attr c msg)
toAttrs (Action payload) =
    case payload of
        OnClick m ->
            [ Attr.attribute (Html.Events.on "click") (Json.Decode.succeed m) ]

        Remove m ->
            [ Attr.attribute (Html.Events.on "remove") (Json.Decode.succeed m) ]

        Link spec ->
            Attr.attribute (Html.Attributes.attribute "href") spec.href
                :: List.filterMap identity
                    [ Maybe.map (Attr.attribute (Html.Attributes.attribute "target")) spec.target
                    , Maybe.map (Attr.attribute (Html.Attributes.attribute "rel")) spec.rel
                    , Maybe.map (Attr.attribute (Html.Attributes.attribute "download")) spec.download
                    ]

        _ ->
            []


{-| The label-wrapping wiring for a behaviour. Wrapper behaviours nest the given
label node inside their trigger element; attribute behaviours return it unchanged.
-}
wrapContent : Action capability msg -> Node msg -> Node msg
wrapContent (Action payload) label =
    case payload of
        None ->
            label

        OnClick _ ->
            label

        Link _ ->
            label

        Remove _ ->
            label

        OpensMenu for ->
            wrap
                (\erased ch -> M3e.Cem.MenuTrigger.menuTrigger (List.map Attr.forget erased) ch)
                [ Attr.forget (M3e.Cem.MenuTrigger.for for) ]
                label

        OpensDialog for ->
            wrap
                (\erased ch -> M3e.Cem.DialogTrigger.dialogTrigger (List.map Attr.forget erased) ch)
                [ Attr.forget (M3e.Cem.DialogTrigger.for for) ]
                label

        OpensFabMenu for ->
            wrap
                (\erased ch -> M3e.Cem.FabMenuTrigger.fabMenuTrigger (List.map Attr.forget erased) ch)
                [ Attr.forget (M3e.Cem.FabMenuTrigger.for for) ]
                label

        TogglesNavRail for ->
            wrap
                (\erased ch -> M3e.Cem.NavRailToggle.navRailToggle (List.map Attr.forget erased) ch)
                [ Attr.forget (M3e.Cem.NavRailToggle.for for) ]
                label

        TogglesDrawer for ->
            wrap
                (\erased ch -> M3e.Cem.DrawerToggle.drawerToggle (List.map Attr.forget erased) ch)
                [ Attr.forget (M3e.Cem.DrawerToggle.for for) ]
                label

        TogglesDatepicker for ->
            wrap
                (\erased ch -> M3e.Cem.DatepickerToggle.datepickerToggle (List.map Attr.forget erased) ch)
                [ Attr.forget (M3e.Cem.DatepickerToggle.for for) ]
                label

        OpensBottomSheet spec ->
            wrap
                (\erased ch -> M3e.Cem.BottomSheetTrigger.bottomSheetTrigger (List.map Attr.forget erased) ch)
                (Attr.forget (M3e.Cem.BottomSheetTrigger.for spec.for)
                    :: List.filterMap identity
                        [ Maybe.map (\d -> Attr.forget (M3e.Cem.BottomSheetTrigger.detent d)) spec.detent
                        , Maybe.map (\s -> Attr.forget (M3e.Cem.BottomSheetTrigger.secondary s)) spec.secondary
                        ]
                )
                label

        DialogAction returnValue ->
            wrap
                (\erased ch -> M3e.Cem.DialogAction.dialogAction (List.map Attr.forget erased) ch)
                [ Attr.forget (M3e.Cem.DialogAction.returnValue returnValue) ]
                label

        BottomSheetAction ->
            wrap
                (\erased ch -> M3e.Cem.BottomSheetAction.bottomSheetAction (List.map Attr.forget erased) ch)
                []
                label

        RichTooltipAction ->
            wrap
                (\erased ch -> M3e.Cem.RichTooltipAction.richTooltipAction (List.map Attr.forget erased) ch)
                []
                label

        StepperReset ->
            wrap
                (\erased ch -> M3e.Cem.StepperReset.stepperReset (List.map Attr.forget erased) ch)
                []
                label

        StepperPrevious ->
            wrap
                (\erased ch -> M3e.Cem.StepperPrevious.stepperPrevious (List.map Attr.forget erased) ch)
                []
                label


wrap : (List (Attr () msg) -> List (Html.Html msg) -> Html.Html msg) -> List (Attr () msg) -> Node msg -> Node msg
wrap component attrs label =
    Node.fromComponent component attrs [ label ]
