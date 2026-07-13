module M3e.SegmentedButton exposing
    ( view, disabled, hideSelectionIndicator, multi, name, onChange
    , onBeforeinput, onInput
    )

{-| A button that allows a user to select from a limited set of options.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the checked state of a segment changes.
  - `beforeinput`: Dispatched before the checked state of a segment changes.
  - `input`: Dispatched when the checked state of a segment changes.

<!-- elm-cem:docmeta category=Actions -->


## Examples


### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.SegmentedButton.view [] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
```

<!-- elm-cem:example title="Icons" -->
```elm
M3e.SegmentedButton.view [] [ M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "palette" ] []), Kit.text "Design" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "accessibility_new" ] []), Kit.text "Accessibility" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.SegmentedButton.view [ M3e.SegmentedButton.multi True ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.SegmentedButton.view [] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.disabled True ] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "palette" ] []), Kit.text "Design" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "accessibility_new" ] []), Kit.text "Accessibility" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.SegmentedButton.view [ M3e.SegmentedButton.disabled True ] [ M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "palette" ] []), Kit.text "Design" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "accessibility_new" ] []), Kit.text "Accessibility" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Hiding the selection indicator" -->
```elm
M3e.SegmentedButton.view [ M3e.SegmentedButton.hideSelectionIndicator True ] [ M3e.ButtonSegment.view [] [ Kit.text "Design" ], M3e.ButtonSegment.view [] [ Kit.text "Accessibility" ], M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "motion_photos_on" ] []), Kit.text "Motion" ], M3e.ButtonSegment.view [] [ M3e.ButtonSegment.icon (M3e.Icon.view [ M3e.Icon.name "description" ] []), Kit.text "Documentation" ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.SegmentedButton.view [ M3e.Attributes.class "density-3" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    , Native.br
    , Native.br
    , M3e.SegmentedButton.view [ M3e.Attributes.class "density-2" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    , Native.br
    , Native.br
    , M3e.SegmentedButton.view [ M3e.Attributes.class "density-1" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    , Native.br
    , Native.br
    , M3e.SegmentedButton.view [ M3e.Attributes.class "density-0" ] [ M3e.ButtonSegment.view [ M3e.ButtonSegment.checked True ] [ Kit.text "8 oz" ], M3e.ButtonSegment.view [] [ Kit.text "12 oz" ], M3e.ButtonSegment.view [] [ Kit.text "16 oz" ], M3e.ButtonSegment.view [] [ Kit.text "20 oz" ] ]
    ]
```

@docs view, disabled, hideSelectionIndicator, multi, name, onChange
@docs onBeforeinput, onInput

-}

import M3e.Html.SegmentedButton
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-segmented-button>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , hideSelectionIndicator : M3e.Token.Supported
            , multi : M3e.Token.Supported
            , name : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { buttonSegment : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | segmentedButton : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.SegmentedButton.segmentedButton
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
    M3e.Html.SegmentedButton.disabled


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideSelectionIndicator : M3e.Token.Supported
            }
            msg
hideSelectionIndicator =
    M3e.Html.SegmentedButton.hideSelectionIndicator


{-| Whether multiple options can be selected. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.SegmentedButton.multi


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.SegmentedButton.name


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.SegmentedButton.onChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.SegmentedButton.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.SegmentedButton.onInput
