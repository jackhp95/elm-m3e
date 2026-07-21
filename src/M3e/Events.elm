module M3e.Events exposing
    ( onActiveChange, onBeforeinput, onBeforetoggle, onCancel, onChange, onClear, onClick, onClosed, onClosing, onHighlight, onInput, onInvalid, onOpened, onOpening, onPage, onQuery, onRemove, onToggle, onValueChange
    , delegate
    )

{-| Events as capabilities: each setter is an open producer admitted only by
elements whose closed `Attrs` row lists the event — `onClick` on a
non-interactive element is a compile error.

`delegate` is the ONE loud escape for bubbling: it forgets an event's
capability so it can be placed on a container and rely on DOM bubbling from an
interactive descendant. Pair it with a real interactive child and a keyboard
path (lint-checked).

@docs onActiveChange, onBeforeinput, onBeforetoggle, onCancel, onChange, onClear, onClick, onClosed, onClosing, onHighlight, onInput, onInvalid, onOpened, onOpening, onPage, onQuery, onRemove, onToggle, onValueChange
@docs delegate

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import Json.Decode


{-| The `active-change` event.
-}
onActiveChange : msg -> Attr { c | onActiveChange : Supported } msg
onActiveChange msg =
    Ir.on "active-change" (Json.Decode.succeed msg)


{-| The `beforeinput` event.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput msg =
    Ir.on "beforeinput" (Json.Decode.succeed msg)


{-| The `beforetoggle` event.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle msg =
    Ir.on "beforetoggle" (Json.Decode.succeed msg)


{-| The `cancel` event.
-}
onCancel : msg -> Attr { c | onCancel : Supported } msg
onCancel msg =
    Ir.on "cancel" (Json.Decode.succeed msg)


{-| The `change` event.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange msg =
    Ir.on "change" (Json.Decode.succeed msg)


{-| The `clear` event.
-}
onClear : msg -> Attr { c | onClear : Supported } msg
onClear msg =
    Ir.on "clear" (Json.Decode.succeed msg)


{-| The `click` event.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick msg =
    Ir.on "click" (Json.Decode.succeed msg)


{-| The `closed` event.
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed msg =
    Ir.on "closed" (Json.Decode.succeed msg)


{-| The `closing` event.
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing msg =
    Ir.on "closing" (Json.Decode.succeed msg)


{-| The `highlight` event.
-}
onHighlight : msg -> Attr { c | onHighlight : Supported } msg
onHighlight msg =
    Ir.on "highlight" (Json.Decode.succeed msg)


{-| The `input` event.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput msg =
    Ir.on "input" (Json.Decode.succeed msg)


{-| The `invalid` event.
-}
onInvalid : msg -> Attr { c | onInvalid : Supported } msg
onInvalid msg =
    Ir.on "invalid" (Json.Decode.succeed msg)


{-| The `opened` event.
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened msg =
    Ir.on "opened" (Json.Decode.succeed msg)


{-| The `opening` event.
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening msg =
    Ir.on "opening" (Json.Decode.succeed msg)


{-| The `page` event.
-}
onPage : msg -> Attr { c | onPage : Supported } msg
onPage msg =
    Ir.on "page" (Json.Decode.succeed msg)


{-| The `query` event.
-}
onQuery : msg -> Attr { c | onQuery : Supported } msg
onQuery msg =
    Ir.on "query" (Json.Decode.succeed msg)


{-| The `remove` event.
-}
onRemove : msg -> Attr { c | onRemove : Supported } msg
onRemove msg =
    Ir.on "remove" (Json.Decode.succeed msg)


{-| The `toggle` event.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle msg =
    Ir.on "toggle" (Json.Decode.succeed msg)


{-| The `value-change` event.
-}
onValueChange : msg -> Attr { c | onValueChange : Supported } msg
onValueChange msg =
    Ir.on "value-change" (Json.Decode.succeed msg)


{-| Forget an event's capability row (the bubbling escape).
-}
delegate : Attr capability msg -> Attr anyCapability msg
delegate attr =
    Ir.fromHtmlAttribute (HtmlIr.Attribute.toHtmlAttribute attr)
