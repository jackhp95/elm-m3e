module TypedHtml.Details exposing
    ( details, summary
    , DetailsIs, DetailsAttrs, DetailsChildAdmittedBy, SummaryIs, SummaryAttrs, SummaryContent, SummaryChildAdmittedBy, SummaryAdmittedBy
    , name, open
    )

{-| The `Details` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs details, summary
@docs DetailsIs, DetailsAttrs, DetailsChildAdmittedBy, SummaryIs, SummaryAttrs, SummaryContent, SummaryChildAdmittedBy, SummaryAdmittedBy
@docs name, open

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx)


{-| The kind row `details` produces.
-}
type alias DetailsIs s =
    { s | details : Brand }


{-| `details`'s closed attribute-capability row.
-}
type alias DetailsAttrs =
    { class : Supported
    , id : Supported
    , name : Supported
    , onClick : Supported
    , open : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand `details` injects into its children.
-}
type alias DetailsChildAdmittedBy childAdm =
    { childAdm | details : Ctx }


{-| The `details` element.
-}
details :
    List (Attr DetailsAttrs msg)
    -> List (Element childAccepts (DetailsChildAdmittedBy childAdm) msg)
    -> Element (DetailsIs s) admittedBy msg
details attrs children =
    Ir.fromNode (Ir.node "details" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `summary` produces.
-}
type alias SummaryIs s =
    { s | summary : Brand }


{-| `summary`'s closed attribute-capability row.
-}
type alias SummaryAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `summary` admits.
-}
type alias SummaryContent =
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
    , sharedText : Shared
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


{-| The context demand `summary` injects into its children.
-}
type alias SummaryChildAdmittedBy childAdm =
    { childAdm | summary : Ctx }


{-| The CLOSED parent contexts `summary` is valid inside.
-}
type alias SummaryAdmittedBy =
    { details : Ctx }


{-| The `summary` element.
-}
summary :
    List (Attr SummaryAttrs msg)
    -> List (Element SummaryContent (SummaryChildAdmittedBy childAdm) msg)
    -> Element (SummaryIs s) SummaryAdmittedBy msg
summary attrs children =
    Ir.fromNode (Ir.node "summary" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.name`.
-}
name : String -> Attr { c | name : Supported } msg
name =
    TypedHtml.Attributes.name


{-| See `TypedHtml.Attributes.open`.
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    TypedHtml.Attributes.open
