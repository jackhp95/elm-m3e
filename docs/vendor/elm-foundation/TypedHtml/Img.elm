module TypedHtml.Img exposing
    ( img
    , Is, Attrs, ChildAdmittedBy
    , alt, crossorigin, decoding, fetchpriority, height, ismap, loading, referrerpolicy, sizes, src, srcset, usemap, width
    )

{-| The `Img` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs img
@docs Is, Attrs, ChildAdmittedBy
@docs alt, crossorigin, decoding, fetchpriority, height, ismap, loading, referrerpolicy, sizes, src, srcset, usemap, width

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx)


{-| The kind row `img` produces.
-}
type alias Is s =
    { s | img : Brand }


{-| `img`'s closed attribute-capability row.
-}
type alias Attrs =
    { alt : Supported
    , class : Supported
    , crossorigin : Supported
    , decoding : Supported
    , fetchpriority : Supported
    , height : Supported
    , id : Supported
    , ismap : Supported
    , loading : Supported
    , referrerpolicy : Supported
    , role : Supported
    , sizes : Supported
    , slot : Supported
    , src : Supported
    , srcset : Supported
    , style : Supported
    , usemap : Supported
    , width : Supported
    }


{-| The context demand `img` injects into its children.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | img : Ctx }


{-| The `img` element.
-}
img :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
img attrs children =
    Ir.fromNode (Ir.node "img" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.alt`.
-}
alt : String -> Attr { c | alt : Supported } msg
alt =
    TypedHtml.Attributes.alt


{-| The `crossorigin` attribute (this component's type differs from the shared canonical).
-}
crossorigin : String -> Attr { c | crossorigin : Supported } msg
crossorigin value_ =
    Ir.attribute "crossorigin" value_


{-| The `decoding` attribute (this component's type differs from the shared canonical).
-}
decoding : String -> Attr { c | decoding : Supported } msg
decoding value_ =
    Ir.attribute "decoding" value_


{-| The `fetchpriority` attribute (this component's type differs from the shared canonical).
-}
fetchpriority : String -> Attr { c | fetchpriority : Supported } msg
fetchpriority value_ =
    Ir.attribute "fetchpriority" value_


{-| See `TypedHtml.Attributes.height`.
-}
height : Float -> Attr { c | height : Supported } msg
height =
    TypedHtml.Attributes.height


{-| See `TypedHtml.Attributes.ismap`.
-}
ismap : Bool -> Attr { c | ismap : Supported } msg
ismap =
    TypedHtml.Attributes.ismap


{-| The `loading` attribute (this component's type differs from the shared canonical).
-}
loading : String -> Attr { c | loading : Supported } msg
loading value_ =
    Ir.attribute "loading" value_


{-| The `referrerpolicy` attribute (this component's type differs from the shared canonical).
-}
referrerpolicy : String -> Attr { c | referrerpolicy : Supported } msg
referrerpolicy value_ =
    Ir.attribute "referrerpolicy" value_


{-| See `TypedHtml.Attributes.sizes`.
-}
sizes : String -> Attr { c | sizes : Supported } msg
sizes =
    TypedHtml.Attributes.sizes


{-| See `TypedHtml.Attributes.src`.
-}
src : String -> Attr { c | src : Supported } msg
src =
    TypedHtml.Attributes.src


{-| See `TypedHtml.Attributes.srcset`.
-}
srcset : String -> Attr { c | srcset : Supported } msg
srcset =
    TypedHtml.Attributes.srcset


{-| See `TypedHtml.Attributes.usemap`.
-}
usemap : String -> Attr { c | usemap : Supported } msg
usemap =
    TypedHtml.Attributes.usemap


{-| See `TypedHtml.Attributes.width`.
-}
width : Float -> Attr { c | width : Supported } msg
width =
    TypedHtml.Attributes.width
