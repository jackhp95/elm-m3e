module M3e.Record.IconButton exposing
    ( view, disabled, disabledInteractive, name, selected, shape
    , size, toggle, type_, value, variant, width
    , onBeforeinput, onInput, onChange, selectedSlot
    )

{-| An icon button users interact with to perform a supplementary action.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before a toggle button's selected state changes.
  - `input`: Dispatched when a toggle button's selected state changes.
  - `change`: Dispatched when a toggle button's selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `selected`: Renders an icon, when selected.

<!-- elm-cem:docmeta category=Actions -->


## Examples


### Variants

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.outlined ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.standard ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```

<!-- elm-cem:example title="Shapes" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.shape M3e.Token.square ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.shape M3e.Token.square ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.outlined, M3e.IconButton.shape M3e.Token.square ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.standard, M3e.IconButton.shape M3e.Token.square ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```

<!-- elm-cem:example title="Toggle" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.outlined, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.standard, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```


### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.size M3e.Token.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.size M3e.Token.small ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.size M3e.Token.medium ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.size M3e.Token.large ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.size M3e.Token.extraLarge ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```


### Width

<!-- elm-cem:example title="Widths" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.width M3e.Token.narrow ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.width M3e.Token.wide ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```


### Examples

<!-- elm-cem:example title="Toggle (2)" -->
```elm
M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "close" ] [], M3e.IconButton.selectedSlot (M3e.Icon.view [ M3e.Icon.name "check" ] []) ]
```

<!-- elm-cem:example title="Toggle (3)" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.shape M3e.Token.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.shape M3e.Token.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.outlined, M3e.IconButton.shape M3e.Token.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.standard, M3e.IconButton.shape M3e.Token.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    , Native.br
    , Native.br
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.shape M3e.Token.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.shape M3e.Token.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.outlined, M3e.IconButton.shape M3e.Token.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.standard, M3e.IconButton.shape M3e.Token.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.disabled True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.disabledInteractive True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.IconButton.view [ M3e.IconButton.variant M3e.Token.tonal, M3e.IconButton.href "https://www.google.com", M3e.IconButton.target "_blank" ] [ M3e.Icon.view [ M3e.Icon.name "open_in_new_window" ] [] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.IconButton.view [ M3e.Attributes.class "density-3", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.Attributes.class "density-2", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.Attributes.class "density-1", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.Attributes.class "density-0", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.IconButton.view [ M3e.Attributes.class "density-3", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.Attributes.class "density-2", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.Attributes.class "density-1", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.Attributes.class "density-0", M3e.IconButton.variant M3e.Token.filled, M3e.IconButton.size M3e.Token.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    ]
```

@docs view, disabled, disabledInteractive, name, selected, shape
@docs size, toggle, type_, value, variant, width
@docs onBeforeinput, onInput, onChange, selectedSlot

-}

import M3e.Action
import M3e.Html.IconButton
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-icon-button>` element (lazy IR).
-}
view :
    { content :
        Markup.Element.Element
            { icon : Markup.Kind.Shared
            , menuTrigger : M3e.Kind.Brand
            , dialogTrigger : M3e.Kind.Brand
            , fabMenuTrigger : M3e.Kind.Brand
            , bottomSheetTrigger : M3e.Kind.Brand
            , navRailToggle : M3e.Kind.Brand
            , drawerToggle : M3e.Kind.Brand
            , datepickerToggle : M3e.Kind.Brand
            , dialogAction : M3e.Kind.Brand
            , bottomSheetAction : M3e.Kind.Brand
            , richTooltipAction : M3e.Kind.Brand
            , stepperReset : M3e.Kind.Brand
            , stepperPrevious : M3e.Kind.Brand
            , stepperNext : M3e.Kind.Brand
            }
            msg
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
            , stepperNext : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , disabledInteractive : M3e.Token.Supported
                , name : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , shape : M3e.Token.Supported
                , size : M3e.Token.Supported
                , toggle : M3e.Token.Supported
                , type_ : M3e.Token.Supported
                , value : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , width : M3e.Token.Supported
                , onBeforeinput : M3e.Token.Supported
                , onInput : M3e.Token.Supported
                , onChange : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | iconButton : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.IconButton.iconButton
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
    M3e.Html.IconButton.disabled


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
    M3e.Html.IconButton.disabledInteractive


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.IconButton.name


{-| Whether the toggle button is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.IconButton.selected


{-| The shape of the button. (default: `"rounded"`)
-}
shape :
    M3e.Token.Value
        { rounded : M3e.Token.Supported
        , square : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | shape : M3e.Token.Supported } msg
shape =
    M3e.Html.IconButton.shape


{-| The size of the button. (default: `"small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size =
    M3e.Html.IconButton.size


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
toggle : Bool -> Markup.Html.Attr.Attr { c | toggle : M3e.Token.Supported } msg
toggle =
    M3e.Html.IconButton.toggle


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
    M3e.Html.IconButton.type_


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Markup.Html.Attr.Attr { c | value : M3e.Token.Supported } msg
value =
    M3e.Html.IconButton.value


{-| The appearance variant of the button. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        , standard : M3e.Token.Supported
        , tonal : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.IconButton.variant


{-| The width of the button. (default: `"default"`)
-}
width :
    M3e.Token.Value
        { default : M3e.Token.Supported
        , narrow : M3e.Token.Supported
        , wide : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | width : M3e.Token.Supported } msg
width =
    M3e.Html.IconButton.width


{-| Listen for `beforeinput` events.
-}
onBeforeinput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.IconButton.onBeforeinput


{-| Listen for `input` events.
-}
onInput :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.IconButton.onInput


{-| Listen for `change` events.
-}
onChange :
    (Bool -> msg)
    -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.IconButton.onChange


{-| Place content in the `selected` slot.
-}
selectedSlot :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
selectedSlot el =
    Markup.Element.Internal.placeSlot "selected" el
