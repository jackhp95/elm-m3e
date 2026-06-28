module M3e.SegmentedButton exposing
    ( ParentOption, SegmentOption
    , view, segment
    , disabled, multi, name
    , segmentDisabled, segmentOnClick, segmentValue
    )

{-| `<m3e-segmented-button>` + `<m3e-button-segment>` — a small row of
buttons for choosing one (or several) options (Material 3 Segmented buttons).

Spec (per docs/CONVENTIONS.md):

  - Required (parent): { segments : List (Element { segment : Supported } msg) }
  - Required (child): { label : String, checked : Bool }
  - Options (parent): disabled, multi
  - Options (child): segmentDisabled, segmentOnClick, segmentValue
  - Slots (parent): default slot ← `m3e-button-segment` children (strict)
  - Properties: checked on each segment (Node.property); disabled, multi
    on parent (Node.property)
  - Events: click on each segment
  - Tag: segmentedButton / segment

@docs ParentOption, SegmentOption
@docs view, segment
@docs disabled, multi, name
@docs segmentDisabled, segmentOnClick, segmentValue

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node



-- SEGMENT (child) ---------------------------------------------------------


{-| Configuration option for an individual segment, built by the helpers below.
-}
type SegmentOption msg
    = SegmentDisabled Bool
    | SegmentOnClick msg
    | SegmentValue String


{-| Disable this individual segment.
-}
segmentDisabled : Bool -> SegmentOption msg
segmentDisabled =
    SegmentDisabled


{-| Wire a click handler for this segment.
-}
segmentOnClick : msg -> SegmentOption msg
segmentOnClick =
    SegmentOnClick


{-| Set the DOM form-submission value for this segment (defaults to the
label when omitted).
-}
segmentValue : String -> SegmentOption msg
segmentValue =
    SegmentValue


type alias SegmentConfig msg =
    { disabled : Bool
    , onClick : Maybe msg
    , value : Maybe String
    }


applySegment : SegmentOption msg -> SegmentConfig msg -> SegmentConfig msg
applySegment opt c =
    case opt of
        SegmentDisabled b ->
            { c | disabled = b }

        SegmentOnClick m ->
            { c | onClick = Just m }

        SegmentValue v ->
            { c | value = Just v }


{-| A single `<m3e-button-segment>` child for use inside a segmented
button. The `label` is rendered as text content; `checked` reflects the
Elm-controlled selection state.
-}
segment :
    { label : String, checked : Bool }
    -> List (SegmentOption msg)
    -> Element { s | segment : Supported } msg
segment req opts =
    let
        c : SegmentConfig msg
        c =
            List.foldl applySegment
                { disabled = False, onClick = Nothing, value = Nothing }
                opts

        domValue : String
        domValue =
            Maybe.withDefault req.label c.value
    in
    Internal.fromNode
        (Node.element "m3e-button-segment"
            (List.filterMap identity
                [ Just (Node.property "checked" (Encode.bool req.checked))
                , Just (Node.property "value" (Encode.string domValue))
                , Just (Node.property "disabled" (Encode.bool c.disabled))
                , Maybe.map
                    (\m -> Node.on "click" (Decode.succeed m))
                    c.onClick
                ]
            )
            [ Node.text req.label ]
        )



-- PARENT ------------------------------------------------------------------


{-| Configuration option for the segmented button group, built by the helpers
below.
-}
type ParentOption msg
    = Disabled Bool
    | Multi Bool
    | Name String


{-| Disable the whole segmented button group.
-}
disabled : Bool -> ParentOption msg
disabled =
    Disabled


{-| Allow multiple segments to be selected simultaneously.
-}
multi : Bool -> ParentOption msg
multi =
    Multi


{-| Set the form field name (the `name` attribute on `<m3e-segmented-button>`).
This identifies the segmented button when its containing form is submitted.
Upstream: `FormAssociated` mixin → `name` attribute.
-}
name : String -> ParentOption msg
name =
    Name


type alias ParentConfig =
    { disabled : Bool
    , multi : Bool
    , name : Maybe String
    }


applyParent : ParentOption msg -> ParentConfig -> ParentConfig
applyParent opt c =
    case opt of
        Disabled b ->
            { c | disabled = b }

        Multi b ->
            { c | multi = b }

        Name v ->
            { c | name = Just v }


{-| Render a segmented button group from a list of `segment` children.
-}
view :
    { segments : List (Element { segment : Supported } msg) }
    -> List (ParentOption msg)
    -> Element { s | segmentedButton : Supported } msg
view req opts =
    let
        c : ParentConfig
        c =
            List.foldl applyParent
                { disabled = False, multi = False, name = Nothing }
                opts
    in
    Internal.fromNode
        (Node.element "m3e-segmented-button"
            (List.filterMap identity
                [ Just (Node.property "disabled" (Encode.bool c.disabled))
                , Just (Node.property "multi" (Encode.bool c.multi))
                , Maybe.map (\v -> Node.attribute "name" v) c.name
                ]
            )
            (List.map Element.toNode req.segments)
        )
