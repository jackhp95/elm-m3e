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

import M3e.Html.Snackbar
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-snackbar>` element (lazy IR).
-}
view :
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | snackbar : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Snackbar.snackbar
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode req_.content ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| The label of the snackbar's action. (default: `""`)
-}
action : String -> Markup.Html.Attr.Attr { c | action : M3e.Token.Supported } msg
action =
    M3e.Html.Snackbar.action


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`)
-}
closeLabel : String -> Markup.Html.Attr.Attr { c | closeLabel : M3e.Token.Supported } msg
closeLabel =
    M3e.Html.Snackbar.closeLabel


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`)
-}
dismissible : Bool -> Markup.Html.Attr.Attr { c | dismissible : M3e.Token.Supported } msg
dismissible =
    M3e.Html.Snackbar.dismissible


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`)
-}
duration : Float -> Markup.Html.Attr.Attr { c | duration : M3e.Token.Supported } msg
duration =
    M3e.Html.Snackbar.duration


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.Snackbar.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.Snackbar.onToggle


{-| Place content in the `close-icon` slot.
-}
closeIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
closeIcon el =
    Markup.Element.Internal.placeSlot "close-icon" el
