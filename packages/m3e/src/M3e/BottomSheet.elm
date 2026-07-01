module M3e.BottomSheet exposing (bottomSheet, child, children, header)

{-| 
@docs bottomSheet, child, header, children
-}


import M3e.Cem.Attr
import M3e.Cem.BottomSheet
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-bottom-sheet>` element (lazy IR). -}
bottomSheet :
    List (M3e.Cem.Attr.Attr { detent : M3e.Value.Supported
    , handle : M3e.Value.Supported
    , handleLabel : M3e.Value.Supported
    , hideable : M3e.Value.Supported
    , hideFriction : M3e.Value.Supported
    , modal : M3e.Value.Supported
    , open : M3e.Value.Supported
    , overshootLimit : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onCancel : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , header : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | bottomSheet : M3e.Value.Supported } msg
bottomSheet attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.BottomSheet.bottomSheet
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | header : M3e.Value.Supported } msg
header el =
    M3e.Content.slot "header" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els