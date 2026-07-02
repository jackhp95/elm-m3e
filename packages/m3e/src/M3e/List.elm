module M3e.List exposing ( view, variant, child, children )

{-|
A list of items.

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Action list of navigable links" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Value.segmented ] (M3e.ActionList.children [ M3e.ListAction.view [ M3e.ListAction.href "/account" ] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "manage_accounts" ] []), M3e.ListAction.trailing (M3e.Icon.view [ M3e.Icon.name "open_in_new" ] []), M3e.ListAction.child (Kit.text "Account") ], M3e.ListAction.view [ M3e.ListAction.href "/billing" ] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "payments" ] []), M3e.ListAction.child (Kit.text "Billing") ], M3e.ListAction.view [ M3e.ListAction.disabled True ] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "lock" ] []), M3e.ListAction.child (Kit.text "Admin tools") ] ])
```

@docs view, variant, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.List
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-list>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | list : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.List.list (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.List.variant


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { listItem : M3e.Value.Supported
    , listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , listOption : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { listItem : M3e.Value.Supported
    , listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , listOption : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els