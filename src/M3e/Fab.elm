module M3e.Fab exposing
    ( view, disabled, disabledInteractive, extended, lowered, name
    , size, type_, value, variant, onClick, href
    , target, rel, download, label, closeIcon
    )

{-| A floating action button (FAB) used to present important actions.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of an extended button.
  - `close-icon`: Renders the close icon when used to open a FAB menu.

<!-- elm-cem:docmeta category=Actions -->


## Examples


### Variants

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.Fab.view [ M3e.Fab.variant M3e.Token.primary ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Token.primaryContainer ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Token.secondary ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Token.secondaryContainer ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Token.tertiary ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Token.tertiaryContainer ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.variant M3e.Token.surface ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```

<!-- elm-cem:example title="Lowering" -->
```elm
[ M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Token.primary ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Token.primaryContainer ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Token.secondary ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Token.secondaryContainer ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Token.tertiary ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Token.tertiaryContainer ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.lowered True, M3e.Fab.variant M3e.Token.surface ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```


### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.Fab.view [ M3e.Fab.size M3e.Token.small ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.medium ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.large ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```


### Examples

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.Fab.view [ M3e.Fab.disabled True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.disabledInteractive True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Fab.view [ M3e.Fab.size M3e.Token.small, M3e.Attributes.class "density-3" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.small, M3e.Attributes.class "density-2" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.small, M3e.Attributes.class "density-1" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.small, M3e.Attributes.class "density-0" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.Fab.view [ M3e.Fab.size M3e.Token.medium, M3e.Attributes.class "density-3" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.medium, M3e.Attributes.class "density-2" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.medium, M3e.Attributes.class "density-1" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.Fab.view [ M3e.Fab.size M3e.Token.medium, M3e.Attributes.class "density-0" ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```

@docs view, disabled, disabledInteractive, extended, lowered, name
@docs size, type_, value, variant, onClick, href
@docs target, rel, download, label, closeIcon

-}

import M3e.Html.Fab
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-fab>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , disabledInteractive : M3e.Token.Supported
            , download : M3e.Token.Supported
            , extended : M3e.Token.Supported
            , href : M3e.Token.Supported
            , lowered : M3e.Token.Supported
            , name : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , size : M3e.Token.Supported
            , target : M3e.Token.Supported
            , type_ : M3e.Token.Supported
            , value : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | fab : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Fab.fab
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Fab.disabled


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disabledInteractive : M3e.Token.Supported
            }
            msg
disabledInteractive =
    M3e.Html.Fab.disabledInteractive


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended : Bool -> Markup.Html.Attr.Attr { c | extended : M3e.Token.Supported } msg
extended =
    M3e.Html.Fab.extended


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered : Bool -> Markup.Html.Attr.Attr { c | lowered : M3e.Token.Supported } msg
lowered =
    M3e.Html.Fab.lowered


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Fab.name


{-| The size of the button. (default: `"medium"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size =
    M3e.Html.Fab.size


{-| The type of the element. (default: `"button"`)
-}
type_ :
    M3e.Token.Value
        { button : M3e.Token.Supported
        , reset : M3e.Token.Supported
        , submit : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | type_ : M3e.Token.Supported } msg
type_ =
    M3e.Html.Fab.type_


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.Fab.value


{-| The appearance variant of the button. (default: `"primary-container"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , primaryContainer : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        , secondaryContainer : M3e.Token.Supported
        , surface : M3e.Token.Supported
        , tertiary : M3e.Token.Supported
        , tertiaryContainer : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.Fab.variant


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.Fab.onClick


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.Fab.href


{-| The target of the link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.Fab.target


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.Fab.rel


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.Fab.download


{-| Place content in the `label` slot.
-}
label :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
label el =
    Markup.Element.Internal.placeSlot "label" el


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
closeIcon el =
    Markup.Element.Internal.placeSlot "close-icon" el
