module M3e.Record.Snackbar exposing
    ( view, action, closeLabel, dismissible, duration, onBeforetoggle
    , onToggle, closeIcon
    )

{-| Presents short updates about application processes at the bottom of the screen.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**Slots:**

  - `close-icon`: Renders the icon of the button used to close the snackbar.

<!-- elm-cem:docmeta category=Communication -->


## Examples


### Examples

<!-- elm-cem:example title="Snackbar service" -->
```elm
M3e.Button.view [ M3e.Attributes.id "example1" ] [ Kit.text "Delete file" ]
```

<!-- elm-cem:example title="Actions" -->
```elm
M3e.Button.view [ M3e.Attributes.id "example2" ] [ Kit.text "Delete file" ]
```

<!-- elm-cem:example title="Dismissal" -->
```elm
M3e.Button.view [ M3e.Attributes.id "example3" ] [ Kit.text "Delete file" ]
```

@docs view, action, closeLabel, dismissible, duration, onBeforetoggle
@docs onToggle, closeIcon

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Snackbar
import M3e.Node
import M3e.Token


{-| Build the `<m3e-snackbar>` element (lazy IR).
-}
view :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { action : M3e.Token.Supported
                , closeLabel : M3e.Token.Supported
                , dismissible : M3e.Token.Supported
                , duration : M3e.Token.Supported
                , onBeforetoggle : M3e.Token.Supported
                , onToggle : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | snackbar : M3e.Token.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Snackbar.snackbar
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.append
                [ M3e.Element.toNode req_.content ]
                (List.map M3e.Element.toNode content_)
            )
        )


{-| The label of the snackbar's action. (default: `""`)
-}
action : String -> M3e.Html.Attr.Attr { c | action : M3e.Token.Supported } msg
action =
    M3e.Html.Snackbar.action


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel : String -> M3e.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.Snackbar.closeLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible : Bool -> M3e.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
dismissible =
    M3e.Html.Snackbar.dismissible


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
duration : Float -> M3e.Html.Attr.Attr { c | duration : M3e.Token.Supported } msg
duration =
    M3e.Html.Snackbar.duration


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle : msg -> M3e.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.Snackbar.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> M3e.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.Snackbar.onToggle


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
closeIcon el =
    M3e.Element.Internal.placeSlot "close-icon" el
