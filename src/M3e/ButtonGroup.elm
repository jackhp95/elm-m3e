module M3e.ButtonGroup exposing
    ( Variant(..), Size(..), Option
    , view
    , variant, size, multi
    )

{-| `<m3e-button-group>` — a connected row of buttons (Material 3 Button
groups, M3 Expressive).

Spec (per docs/CONVENTIONS.md):

  - Required:   { buttons : List (Renderable { button : Supported } msg) }
               (homogeneous list slot — a button-group is meaningless without
               buttons; typed list in the required record)
  - Options:    variant, size, multi
  - Slots:      default slot ← `m3e-button` children (no slot= injection)
  - Properties: multi (Node.property — introspectable)
  - Attrs:      variant/size via Cem.M3e.ButtonGroup.* as rawAttr
  - Escape:     none (strict child kind: { button })
  - Tag:        buttonGroup

-}

import Cem.M3e.ButtonGroup as Cem
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


{-| Group appearance variant. -}
type Variant
    = Standard
    | Connected


{-| Size applied to the whole group. -}
type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


type Option msg
    = VariantOpt Variant
    | SizeOpt Size
    | Multi Bool


variant : Variant -> Option msg
variant =
    VariantOpt


size : Size -> Option msg
size =
    SizeOpt


{-| Allow more than one toggle button in the group to be selected at
once (m3e `multi` property, default false).
-}
multi : Bool -> Option msg
multi =
    Multi


type alias Config =
    { variant : Variant
    , size : Size
    , multi : Bool
    }


apply : Option msg -> Config -> Config
apply opt c =
    case opt of
        VariantOpt v ->
            { c | variant = v }

        SizeOpt s ->
            { c | size = s }

        Multi b ->
            { c | multi = b }


view :
    { buttons : List (Renderable { button : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | buttonGroup : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { variant = Standard, size = Small, multi = False }
                opts
    in
    Internal.fromNode
        (Node.element "m3e-button-group"
            (List.filterMap identity
                [ Just (Node.rawAttr (Cem.variant (toCemVariant c.variant)))
                , Just (Node.rawAttr (Cem.size (toCemSize c.size)))
                , if c.multi then
                    Just (Node.property "multi" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            (List.map Renderable.toNode req.buttons)
        )


toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Standard ->
            Cem.Standard

        Connected ->
            Cem.Connected


toCemSize : Size -> Cem.Size
toCemSize s =
    case s of
        ExtraSmall ->
            Cem.ExtraSmall

        Small ->
            Cem.Small

        Medium ->
            Cem.Medium

        Large ->
            Cem.Large

        ExtraLarge ->
            Cem.ExtraLarge
