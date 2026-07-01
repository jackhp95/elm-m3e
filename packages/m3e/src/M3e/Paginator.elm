module M3e.Paginator exposing (firstPageIcon, lastPageIcon, nextPageIcon, paginator, previousPageIcon)

{-| 
@docs paginator, firstPageIcon, previousPageIcon, nextPageIcon, lastPageIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Paginator
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-paginator>` element (lazy IR). -}
paginator :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , firstPageLabel : M3e.Value.Supported
    , hidePageSize : M3e.Value.Supported
    , itemsPerPageLabel : M3e.Value.Supported
    , lastPageLabel : M3e.Value.Supported
    , length : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , pageIndex : M3e.Value.Supported
    , pageSize : M3e.Value.Supported
    , pageSizes : M3e.Value.Supported
    , pageSizeVariant : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , showFirstLastButtons : M3e.Value.Supported
    , onPage : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { firstPageIcon : M3e.Value.Supported
    , previousPageIcon : M3e.Value.Supported
    , nextPageIcon : M3e.Value.Supported
    , lastPageIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | paginator : M3e.Value.Supported } msg
paginator attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Paginator.paginator
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `first-page-icon` slot. -}
firstPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | firstPageIcon : M3e.Value.Supported } msg
firstPageIcon el =
    M3e.Content.slot "first-page-icon" el


{-| Place content in the `previous-page-icon` slot. -}
previousPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | previousPageIcon : M3e.Value.Supported } msg
previousPageIcon el =
    M3e.Content.slot "previous-page-icon" el


{-| Place content in the `next-page-icon` slot. -}
nextPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextPageIcon : M3e.Value.Supported } msg
nextPageIcon el =
    M3e.Content.slot "next-page-icon" el


{-| Place content in the `last-page-icon` slot. -}
lastPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | lastPageIcon : M3e.Value.Supported } msg
lastPageIcon el =
    M3e.Content.slot "last-page-icon" el