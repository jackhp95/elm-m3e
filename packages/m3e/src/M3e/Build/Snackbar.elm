module M3e.Build.Snackbar exposing
    ( Builder, AttrCaps, SlotCaps, snackbar, action, closeLabel
    , dismissible, duration, onBeforetoggle, onToggle, closeIcon, build
    )

{-|
The ⑤ Build shape for `<m3e-snackbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Snackbar as Snackbar`.

@docs Builder, AttrCaps, SlotCaps, snackbar, action, closeLabel
@docs dismissible, duration, onBeforetoggle, onToggle, closeIcon, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Snackbar
import M3e.Cem.Snackbar
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-snackbar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { action : M3e.Build.Internal.Available
    , closeLabel : M3e.Build.Internal.Available
    , dismissible : M3e.Build.Internal.Available
    , duration : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { closeIcon : M3e.Build.Internal.Available }


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , action : Maybe String
    , closeLabel : Maybe String
    , dismissible : Maybe Bool
    , duration : Maybe Float
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , closeIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-snackbar>` with the required fields. -}
snackbar :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
snackbar req_ =
    Builder
        { content = req_.content
        , action = Nothing
        , closeLabel = Nothing
        , dismissible = Nothing
        , duration = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , closeIcon = Nothing
        , phantomMsg_ = Nothing
        }


{-| The label of the snackbar's action. (default: `""`) -}
action :
    String
    -> Builder { a | action : M3e.Build.Internal.Available } s msg
    -> Builder { a | action : M3e.Build.Internal.Used } s msg
action v_ (Builder f_) =
    Builder { f_ | action = Just v_ }


{-| The accessible label given to the button used to dismiss the snackbar. (default: `"Close"`) -}
closeLabel :
    String
    -> Builder { a | closeLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | closeLabel : M3e.Build.Internal.Used } s msg
closeLabel v_ (Builder f_) =
    Builder { f_ | closeLabel = Just v_ }


{-| Whether a button is presented that can be used to close the snackbar. (default: `false`) -}
dismissible :
    Bool
    -> Builder { a | dismissible : M3e.Build.Internal.Available } s msg
    -> Builder { a | dismissible : M3e.Build.Internal.Used } s msg
dismissible v_ (Builder f_) =
    Builder { f_ | dismissible = Just v_ }


{-| The length of time, in milliseconds, to wait before automatically dismissing the snackbar. (default: `3000`) -}
duration :
    Float
    -> Builder { a | duration : M3e.Build.Internal.Available } s msg
    -> Builder { a | duration : M3e.Build.Internal.Used } s msg
duration v_ (Builder f_) =
    Builder { f_ | duration = Just v_ }


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg
onBeforetoggle v_ (Builder f_) =
    Builder { f_ | onBeforetoggle = Just v_ }


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg
onToggle v_ (Builder f_) =
    Builder { f_ | onToggle = Just v_ }


{-| Set the `close-icon` slot. Consumes the `closeIcon` slot capability. -}
closeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | closeIcon : M3e.Build.Internal.Used } msg
closeIcon v_ (Builder f_) =
    Builder { f_ | closeIcon = Just v_ }


{-| Build the `<m3e-snackbar>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | snackbar : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Snackbar.snackbar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Snackbar.action v_) ]
                         )
                         f_.action
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Snackbar.closeLabel v_)
                            ]
                         )
                         f_.closeLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Snackbar.dismissible v_)
                            ]
                         )
                         f_.dismissible
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Snackbar.duration v_)
                            ]
                         )
                         f_.duration
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Snackbar.onBeforetoggle
                                   v_
                                )
                            ]
                         )
                         f_.onBeforetoggle
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Snackbar.onToggle
                                   v_
                                )
                            ]
                         )
                         f_.onToggle
                      )
                  ]
             )
             (List.concat
                  [ [ M3e.Element.toNode f_.content ]
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "close-icon" v_)
                            ]
                         )
                         f_.closeIcon
                      )
                  ]
             )
        )