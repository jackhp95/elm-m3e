module M3e.Build.Paginator exposing
    ( Builder, AttrCaps, SlotCaps, paginator, disabled, firstPageLabel
    , hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel, pageIndex, pageSize
    , pageSizes, pageSizeVariant, previousPageLabel, showFirstLastButtons, onPage, firstPageIcon, previousPageIcon
    , nextPageIcon, lastPageIcon, build
    )

{-|
The ⑤ Build shape for `<m3e-paginator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Paginator as Paginator`.

@docs Builder, AttrCaps, SlotCaps, paginator, disabled, firstPageLabel
@docs hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel, pageIndex
@docs pageSize, pageSizes, pageSizeVariant, previousPageLabel, showFirstLastButtons, onPage
@docs firstPageIcon, previousPageIcon, nextPageIcon, lastPageIcon, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Paginator
import M3e.Cem.Paginator
import M3e.Element
import M3e.Node
import M3e.Value


{-| Opaque builder for `<m3e-paginator>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , firstPageLabel : M3e.Build.Internal.Available
    , hidePageSize : M3e.Build.Internal.Available
    , itemsPerPageLabel : M3e.Build.Internal.Available
    , lastPageLabel : M3e.Build.Internal.Available
    , length : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , pageIndex : M3e.Build.Internal.Available
    , pageSize : M3e.Build.Internal.Available
    , pageSizes : M3e.Build.Internal.Available
    , pageSizeVariant : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , showFirstLastButtons : M3e.Build.Internal.Available
    , onPage : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { firstPageIcon : M3e.Build.Internal.Available
    , previousPageIcon : M3e.Build.Internal.Available
    , nextPageIcon : M3e.Build.Internal.Available
    , lastPageIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { disabled : Maybe Bool
    , firstPageLabel : Maybe String
    , hidePageSize : Maybe Bool
    , itemsPerPageLabel : Maybe String
    , lastPageLabel : Maybe String
    , length : Maybe Float
    , nextPageLabel : Maybe String
    , pageIndex : Maybe Float
    , pageSize :
        Maybe (M3e.Value.Value { number : M3e.Value.Supported
        , all : M3e.Value.Supported
        })
    , pageSizes : Maybe String
    , pageSizeVariant :
        Maybe (M3e.Value.Value { filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , previousPageLabel : Maybe String
    , showFirstLastButtons : Maybe Bool
    , onPage : Maybe (Json.Decode.Decoder msg)
    , firstPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , previousPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , nextPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , lastPageIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-paginator>`. -}
paginator : Builder AttrCaps SlotCaps msg
paginator =
    Builder
        { disabled = Nothing
        , firstPageLabel = Nothing
        , hidePageSize = Nothing
        , itemsPerPageLabel = Nothing
        , lastPageLabel = Nothing
        , length = Nothing
        , nextPageLabel = Nothing
        , pageIndex = Nothing
        , pageSize = Nothing
        , pageSizes = Nothing
        , pageSizeVariant = Nothing
        , previousPageLabel = Nothing
        , showFirstLastButtons = Nothing
        , onPage = Nothing
        , firstPageIcon = Nothing
        , previousPageIcon = Nothing
        , nextPageIcon = Nothing
        , lastPageIcon = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel :
    String
    -> Builder { a | firstPageLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | firstPageLabel : M3e.Build.Internal.Used } s msg
firstPageLabel v_ (Builder f_) =
    Builder { f_ | firstPageLabel = Just v_ }


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize :
    Bool
    -> Builder { a | hidePageSize : M3e.Build.Internal.Available } s msg
    -> Builder { a | hidePageSize : M3e.Build.Internal.Used } s msg
hidePageSize v_ (Builder f_) =
    Builder { f_ | hidePageSize = Just v_ }


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel :
    String
    -> Builder { a | itemsPerPageLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | itemsPerPageLabel : M3e.Build.Internal.Used } s msg
itemsPerPageLabel v_ (Builder f_) =
    Builder { f_ | itemsPerPageLabel = Just v_ }


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel :
    String
    -> Builder { a | lastPageLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | lastPageLabel : M3e.Build.Internal.Used } s msg
lastPageLabel v_ (Builder f_) =
    Builder { f_ | lastPageLabel = Just v_ }


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length :
    Float
    -> Builder { a | length : M3e.Build.Internal.Available } s msg
    -> Builder { a | length : M3e.Build.Internal.Used } s msg
length v_ (Builder f_) =
    Builder { f_ | length = Just v_ }


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Used } s msg
nextPageLabel v_ (Builder f_) =
    Builder { f_ | nextPageLabel = Just v_ }


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex :
    Float
    -> Builder { a | pageIndex : M3e.Build.Internal.Available } s msg
    -> Builder { a | pageIndex : M3e.Build.Internal.Used } s msg
pageIndex v_ (Builder f_) =
    Builder { f_ | pageIndex = Just v_ }


{-| The number of items to display in a page. (default: `50`) -}
pageSize :
    M3e.Value.Value { number : M3e.Value.Supported, all : M3e.Value.Supported }
    -> Builder { a | pageSize : M3e.Build.Internal.Available } s msg
    -> Builder { a | pageSize : M3e.Build.Internal.Used } s msg
pageSize v_ (Builder f_) =
    Builder { f_ | pageSize = Just v_ }


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes :
    String
    -> Builder { a | pageSizes : M3e.Build.Internal.Available } s msg
    -> Builder { a | pageSizes : M3e.Build.Internal.Used } s msg
pageSizes v_ (Builder f_) =
    Builder { f_ | pageSizes = Just v_ }


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | pageSizeVariant : M3e.Build.Internal.Available } s msg
    -> Builder { a | pageSizeVariant : M3e.Build.Internal.Used } s msg
pageSizeVariant v_ (Builder f_) =
    Builder { f_ | pageSizeVariant = Just v_ }


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Used } s msg
previousPageLabel v_ (Builder f_) =
    Builder { f_ | previousPageLabel = Just v_ }


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons :
    Bool
    -> Builder { a | showFirstLastButtons : M3e.Build.Internal.Available } s msg
    -> Builder { a | showFirstLastButtons : M3e.Build.Internal.Used } s msg
showFirstLastButtons v_ (Builder f_) =
    Builder { f_ | showFirstLastButtons = Just v_ }


{-| Dispatched when a user selects a different page size or navigates to another page. -}
onPage :
    Json.Decode.Decoder msg
    -> Builder { a | onPage : M3e.Build.Internal.Available } s msg
    -> Builder { a | onPage : M3e.Build.Internal.Used } s msg
onPage v_ (Builder f_) =
    Builder { f_ | onPage = Just v_ }


{-| Set the `first-page-icon` slot. Consumes the `firstPageIcon` slot capability. -}
firstPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | firstPageIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | firstPageIcon : M3e.Build.Internal.Used } msg
firstPageIcon v_ (Builder f_) =
    Builder { f_ | firstPageIcon = Just v_ }


{-| Set the `previous-page-icon` slot. Consumes the `previousPageIcon` slot capability. -}
previousPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | previousPageIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | previousPageIcon : M3e.Build.Internal.Used } msg
previousPageIcon v_ (Builder f_) =
    Builder { f_ | previousPageIcon = Just v_ }


{-| Set the `next-page-icon` slot. Consumes the `nextPageIcon` slot capability. -}
nextPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | nextPageIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | nextPageIcon : M3e.Build.Internal.Used } msg
nextPageIcon v_ (Builder f_) =
    Builder { f_ | nextPageIcon = Just v_ }


{-| Set the `last-page-icon` slot. Consumes the `lastPageIcon` slot capability. -}
lastPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | lastPageIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | lastPageIcon : M3e.Build.Internal.Used } msg
lastPageIcon v_ (Builder f_) =
    Builder { f_ | lastPageIcon = Just v_ }


{-| Build the `<m3e-paginator>` element from a `Builder`. -}
build :
    Builder a {} msg
    -> M3e.Element.Element { kind | paginator : M3e.Value.Supported } msg
build (Builder f_) =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Paginator.paginator
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.disabled v_)
                            ]
                         )
                         f_.disabled
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.firstPageLabel v_)
                            ]
                         )
                         f_.firstPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.hidePageSize v_)
                            ]
                         )
                         f_.hidePageSize
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.itemsPerPageLabel v_)
                            ]
                         )
                         f_.itemsPerPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.lastPageLabel v_)
                            ]
                         )
                         f_.lastPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget (M3e.Cem.Paginator.length v_)
                            ]
                         )
                         f_.length
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.nextPageLabel v_)
                            ]
                         )
                         f_.nextPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.pageIndex v_)
                            ]
                         )
                         f_.pageIndex
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.pageSize v_)
                            ]
                         )
                         f_.pageSize
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.pageSizes v_)
                            ]
                         )
                         f_.pageSizes
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.pageSizeVariant v_)
                            ]
                         )
                         f_.pageSizeVariant
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.previousPageLabel v_)
                            ]
                         )
                         f_.previousPageLabel
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Paginator.showFirstLastButtons v_)
                            ]
                         )
                         f_.showFirstLastButtons
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Cem.Attr.forget
                                (M3e.Cem.Attr.attribute
                                   M3e.Cem.Html.Paginator.onPage
                                   v_
                                )
                            ]
                         )
                         f_.onPage
                      )
                  ]
             )
             (List.concat
                  [ Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "first-page-icon" v_)
                            ]
                         )
                         f_.firstPageIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "previous-page-icon" v_)
                            ]
                         )
                         f_.previousPageIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "next-page-icon" v_)
                            ]
                         )
                         f_.nextPageIcon
                      )
                  , Maybe.withDefault
                      []
                      (Maybe.map
                         (\v_ ->
                            [ M3e.Element.toNode
                                (M3e.Element.withSlot "last-page-icon" v_)
                            ]
                         )
                         f_.lastPageIcon
                      )
                  ]
             )
        )