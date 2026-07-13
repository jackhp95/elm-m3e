port module Ports exposing (storeScheme)

{-| Client-side outgoing ports for the docs app. Wired to the browser in
`index.ts`.

@docs storeScheme

-}


{-| Persist the chosen color scheme (`"auto"` | `"light"` | `"dark"`) to
`localStorage` so it survives reloads. `index.ts` subscribes and writes it; the
saved value is read back as a flag and applied in `Shared.init`.
-}
port storeScheme : String -> Cmd msg
