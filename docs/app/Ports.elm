port module Ports exposing (onOpenSearchRequested, storeScheme)

{-| Client-side ports for the docs app. Wired to the browser in `index.ts`.

@docs onOpenSearchRequested, storeScheme

-}


{-| Persist the chosen color scheme (`"auto"` | `"light"` | `"dark"`) to
`localStorage` so it survives reloads. `index.ts` subscribes and writes it; the
saved value is read back as a flag and applied in `Shared.init`.
-}
port storeScheme : String -> Cmd msg


{-| Fired when the user presses Cmd/Ctrl+K anywhere in the app. `index.ts`
registers a real `document.addEventListener("keydown", ...)` and calls
`event.preventDefault()` before sending on this port -- Chrome and Edge bind
that shortcut to focusing the address bar, and `Browser.Events.onKeyDown`
cannot call `preventDefault` (it only decodes event data), so without this
port our shortcut would fire ALONGSIDE the browser's, not instead of it.
-}
port onOpenSearchRequested : (() -> msg) -> Sub msg
