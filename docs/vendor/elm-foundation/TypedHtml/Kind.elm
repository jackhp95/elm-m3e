module TypedHtml.Kind exposing
    ( Brand, Ctx, Role
    , Available, Used
    , Embedded, Flow, Heading, Interactive, Metadata, Phrasing, Sectioning
    )

{-| The library's private phantom markers and named kind/context sets.

`Brand` marks this library's kind-row fields; `Ctx` marks its context-row
fields. Both are nominal and private to this library — a foreign library's
markers never unify with them, even under the same field name.
`Available`/`Used` are the pipe-builder's write-once capability markers.

@docs Brand, Ctx, Role
@docs Available, Used
@docs Embedded, Flow, Heading, Interactive, Metadata, Phrasing, Sectioning

-}


{-| The private kind marker (never constructed).
-}
type Brand
    = Brand_


{-| The private context marker (never constructed).
-}
type Ctx
    = Ctx_


{-| The private ARIA-role marker (never constructed).
-}
type Role
    = Role_


{-| Pipe-builder capability: still writable.
-}
type Available
    = Available_


{-| Pipe-builder capability: consumed.
-}
type Used
    = Used_


{-| The `embedded` kind set.
-}
type alias Embedded =
    { audio : Brand
    , canvas : Brand
    , embed : Brand
    , iframe : Brand
    , img : Brand
    , object : Brand
    , picture : Brand
    , video : Brand
    }


{-| The `flow` kind set.
-}
type alias Flow =
    { a : Brand
    , abbr : Brand
    , address : Brand
    , area : Brand
    , article : Brand
    , aside : Brand
    , audio : Brand
    , b : Brand
    , bdi : Brand
    , bdo : Brand
    , blockquote : Brand
    , br : Brand
    , button : Brand
    , canvas : Brand
    , cite : Brand
    , code : Brand
    , data : Brand
    , datalist : Brand
    , del : Brand
    , details : Brand
    , dfn : Brand
    , dialog : Brand
    , div : Brand
    , dl : Brand
    , em : Brand
    , embed : Brand
    , fieldset : Brand
    , figure : Brand
    , footer : Brand
    , form : Brand
    , h1 : Brand
    , h2 : Brand
    , h3 : Brand
    , h4 : Brand
    , h5 : Brand
    , h6 : Brand
    , header : Brand
    , hgroup : Brand
    , hr : Brand
    , i : Brand
    , iframe : Brand
    , img : Brand
    , input : Brand
    , ins : Brand
    , kbd : Brand
    , label : Brand
    , link : Brand
    , main_ : Brand
    , map : Brand
    , mark : Brand
    , menu : Brand
    , meta : Brand
    , meter : Brand
    , nav : Brand
    , noscript : Brand
    , object : Brand
    , ol : Brand
    , output : Brand
    , p : Brand
    , picture : Brand
    , pre : Brand
    , progress : Brand
    , q : Brand
    , ruby : Brand
    , s : Brand
    , samp : Brand
    , script : Brand
    , search : Brand
    , section : Brand
    , select : Brand
    , slot : Brand
    , small : Brand
    , span : Brand
    , strong : Brand
    , sub : Brand
    , sup : Brand
    , table : Brand
    , template : Brand
    , textarea : Brand
    , time : Brand
    , u : Brand
    , ul : Brand
    , var : Brand
    , video : Brand
    , wbr : Brand
    }


{-| The `heading` kind set.
-}
type alias Heading =
    { h1 : Brand
    , h2 : Brand
    , h3 : Brand
    , h4 : Brand
    , h5 : Brand
    , h6 : Brand
    }


{-| The `interactive` kind set.
-}
type alias Interactive =
    { a : Brand
    , audio : Brand
    , button : Brand
    , details : Brand
    , embed : Brand
    , iframe : Brand
    , img : Brand
    , input : Brand
    , label : Brand
    , object : Brand
    , select : Brand
    , textarea : Brand
    , th : Brand
    , video : Brand
    }


{-| The `metadata` kind set.
-}
type alias Metadata =
    { base : Brand
    , link : Brand
    , meta : Brand
    , noscript : Brand
    , script : Brand
    , style : Brand
    , template : Brand
    , title : Brand
    }


{-| The `phrasing` kind set.
-}
type alias Phrasing =
    { a : Brand
    , abbr : Brand
    , area : Brand
    , audio : Brand
    , b : Brand
    , bdi : Brand
    , bdo : Brand
    , br : Brand
    , button : Brand
    , canvas : Brand
    , cite : Brand
    , code : Brand
    , data : Brand
    , datalist : Brand
    , del : Brand
    , dfn : Brand
    , em : Brand
    , embed : Brand
    , i : Brand
    , iframe : Brand
    , img : Brand
    , input : Brand
    , ins : Brand
    , kbd : Brand
    , label : Brand
    , link : Brand
    , map : Brand
    , mark : Brand
    , meta : Brand
    , meter : Brand
    , noscript : Brand
    , object : Brand
    , output : Brand
    , picture : Brand
    , progress : Brand
    , q : Brand
    , ruby : Brand
    , s : Brand
    , samp : Brand
    , script : Brand
    , select : Brand
    , slot : Brand
    , small : Brand
    , span : Brand
    , strong : Brand
    , sub : Brand
    , sup : Brand
    , template : Brand
    , textarea : Brand
    , time : Brand
    , u : Brand
    , var : Brand
    , video : Brand
    , wbr : Brand
    }


{-| The `sectioning` kind set.
-}
type alias Sectioning =
    { article : Brand
    , aside : Brand
    , nav : Brand
    , section : Brand
    }
