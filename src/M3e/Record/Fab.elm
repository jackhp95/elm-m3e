module M3e.Record.Fab exposing
    ( view, disabled, disabledInteractive, extended, lowered, name
    , size, type_, value, variant, label, closeIcon
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
@docs size, type_, value, variant, label, closeIcon

-}

import M3e.Action
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
    { content : Markup.Element.Element { icon : Markup.Kind.Shared } msg
    , action :
        M3e.Action.Action
            { click : M3e.Token.Supported
            , link : M3e.Token.Supported
            , menuTrigger : M3e.Token.Supported
            , dialogTrigger : M3e.Token.Supported
            , fabMenuTrigger : M3e.Token.Supported
            , bottomSheetTrigger : M3e.Token.Supported
            , navRailToggle : M3e.Token.Supported
            , drawerToggle : M3e.Token.Supported
            , datepickerToggle : M3e.Token.Supported
            , dialogAction : M3e.Token.Supported
            , bottomSheetAction : M3e.Token.Supported
            , richTooltipAction : M3e.Token.Supported
            , stepperReset : M3e.Token.Supported
            , stepperPrevious : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , extended : M3e.Token.Supported
                , lowered : M3e.Token.Supported
                , name : M3e.Token.Supported
                , size : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | fab : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Fab.fab
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.append
                (List.map
                    Markup.Html.Attr.Internal.forget
                    (M3e.Action.toAttrs req_.action)
                )
                (List.map Markup.Html.Attr.Internal.forget attributes)
            )
            (List.append
                [ M3e.Action.wrapContent
                    req_.action
                    (Markup.Element.toNode req_.content)
                ]
                (List.map Markup.Element.toNode content_)
            )
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


{-| Place content in the `label` slot.
-}
label :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
label el =
    Markup.Element.Internal.placeSlot "label" el


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
closeIcon el =
    Markup.Element.Internal.placeSlot "close-icon" el
