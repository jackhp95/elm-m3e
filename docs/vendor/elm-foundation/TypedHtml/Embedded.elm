module TypedHtml.Embedded exposing
    ( area, canvas, embed, iframe, map, object
    , AreaIs, AreaAttrs, AreaChildAdmittedBy, CanvasAttrs, CanvasChildAdmittedBy, EmbedIs, EmbedAttrs, EmbedChildAdmittedBy, IframeIs, IframeAttrs, IframeChildAdmittedBy, MapAttrs, MapContent, MapChildAdmittedBy, ObjectAttrs, ObjectChildAdmittedBy
    , allow, allowfullscreen, alt, coords, data, download, form, height, href, loading, name, ping, referrerpolicy, rel, sandbox, shape, src, srcdoc, target, width
    )

{-| The `Embedded` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs area, canvas, embed, iframe, map, object
@docs AreaIs, AreaAttrs, AreaChildAdmittedBy, CanvasAttrs, CanvasChildAdmittedBy, EmbedIs, EmbedAttrs, EmbedChildAdmittedBy, IframeIs, IframeAttrs, IframeChildAdmittedBy, MapAttrs, MapContent, MapChildAdmittedBy, ObjectAttrs, ObjectChildAdmittedBy
@docs allow, allowfullscreen, alt, coords, data, download, form, height, href, loading, name, ping, referrerpolicy, rel, sandbox, shape, src, srcdoc, target, width

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx)


{-| The kind row `area` produces.
-}
type alias AreaIs s =
    { s | area : Brand }


{-| `area`'s closed attribute-capability row.
-}
type alias AreaAttrs =
    { alt : Supported
    , class : Supported
    , coords : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , ping : Supported
    , referrerpolicy : Supported
    , rel : Supported
    , role : Supported
    , shape : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    }


{-| The context demand `area` injects into its children.
-}
type alias AreaChildAdmittedBy childAdm =
    { childAdm | area : Ctx }


{-| The `area` element.
-}
area :
    List (Attr AreaAttrs msg)
    -> List (Element childAccepts (AreaChildAdmittedBy childAdm) msg)
    -> Element (AreaIs s) admittedBy msg
area attrs children =
    Ir.fromNode (Ir.node "area" attrs (List.map HtmlIr.Element.toNode children))


{-| `canvas`'s closed attribute-capability row.
-}
type alias CanvasAttrs =
    { class : Supported
    , height : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    , width : Supported
    }


{-| The context demand `canvas` injects into its children.
-}
type alias CanvasChildAdmittedBy childAdm =
    { childAdm | canvas : Ctx }


{-| The `canvas` element. Transparent content model: its produced kind row IS its
children's accepts row — it inherits its context's content model.
-}
canvas :
    List (Attr CanvasAttrs msg)
    -> List (Element childAccepts (CanvasChildAdmittedBy childAdm) msg)
    -> Element childAccepts admittedBy msg
canvas attrs children =
    Ir.fromNode (Ir.node "canvas" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `embed` produces.
-}
type alias EmbedIs s =
    { s | embed : Brand }


{-| `embed`'s closed attribute-capability row.
-}
type alias EmbedAttrs =
    { class : Supported
    , height : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , src : Supported
    , style : Supported
    , width : Supported
    }


{-| The context demand `embed` injects into its children.
-}
type alias EmbedChildAdmittedBy childAdm =
    { childAdm | embed : Ctx }


{-| The `embed` element.
-}
embed :
    List (Attr EmbedAttrs msg)
    -> List (Element childAccepts (EmbedChildAdmittedBy childAdm) msg)
    -> Element (EmbedIs s) admittedBy msg
embed attrs children =
    Ir.fromNode (Ir.node "embed" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `iframe` produces.
-}
type alias IframeIs s =
    { s | iframe : Brand }


{-| `iframe`'s closed attribute-capability row.
-}
type alias IframeAttrs =
    { allow : Supported
    , allowfullscreen : Supported
    , class : Supported
    , height : Supported
    , id : Supported
    , loading : Supported
    , name : Supported
    , referrerpolicy : Supported
    , role : Supported
    , sandbox : Supported
    , slot : Supported
    , src : Supported
    , srcdoc : Supported
    , style : Supported
    , width : Supported
    }


{-| The context demand `iframe` injects into its children.
-}
type alias IframeChildAdmittedBy childAdm =
    { childAdm | iframe : Ctx }


{-| The `iframe` element.
-}
iframe :
    List (Attr IframeAttrs msg)
    -> List (Element childAccepts (IframeChildAdmittedBy childAdm) msg)
    -> Element (IframeIs s) admittedBy msg
iframe attrs children =
    Ir.fromNode (Ir.node "iframe" attrs (List.map HtmlIr.Element.toNode children))


{-| `map`'s closed attribute-capability row.
-}
type alias MapAttrs =
    { class : Supported
    , id : Supported
    , name : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `map` admits.
-}
type alias MapContent =
    { area : Brand }


{-| The context demand `map` injects into its children.
-}
type alias MapChildAdmittedBy childAdm =
    { childAdm | map : Ctx }


{-| The `map` element. Transparent content model: its produced kind row IS its
children's accepts row — it inherits its context's content model.
-}
map :
    List (Attr MapAttrs msg)
    -> List (Element childAccepts (MapChildAdmittedBy childAdm) msg)
    -> Element childAccepts admittedBy msg
map attrs children =
    Ir.fromNode (Ir.node "map" attrs (List.map HtmlIr.Element.toNode children))


{-| `object`'s closed attribute-capability row.
-}
type alias ObjectAttrs =
    { class : Supported
    , data : Supported
    , form : Supported
    , height : Supported
    , id : Supported
    , name : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    , width : Supported
    }


{-| The context demand `object` injects into its children.
-}
type alias ObjectChildAdmittedBy childAdm =
    { childAdm | object : Ctx }


{-| The `object` element. Transparent content model: its produced kind row IS its
children's accepts row — it inherits its context's content model.
-}
object :
    List (Attr ObjectAttrs msg)
    -> List (Element childAccepts (ObjectChildAdmittedBy childAdm) msg)
    -> Element childAccepts admittedBy msg
object attrs children =
    Ir.fromNode (Ir.node "object" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.allow`.
-}
allow : String -> Attr { c | allow : Supported } msg
allow =
    TypedHtml.Attributes.allow


{-| See `TypedHtml.Attributes.allowfullscreen`.
-}
allowfullscreen : Bool -> Attr { c | allowfullscreen : Supported } msg
allowfullscreen =
    TypedHtml.Attributes.allowfullscreen


{-| See `TypedHtml.Attributes.alt`.
-}
alt : String -> Attr { c | alt : Supported } msg
alt =
    TypedHtml.Attributes.alt


{-| See `TypedHtml.Attributes.coords`.
-}
coords : Float -> Attr { c | coords : Supported } msg
coords =
    TypedHtml.Attributes.coords


{-| See `TypedHtml.Attributes.data`.
-}
data : String -> Attr { c | data : Supported } msg
data =
    TypedHtml.Attributes.data


{-| See `TypedHtml.Attributes.download`.
-}
download : String -> Attr { c | download : Supported } msg
download =
    TypedHtml.Attributes.download


{-| See `TypedHtml.Attributes.form`.
-}
form : String -> Attr { c | form : Supported } msg
form =
    TypedHtml.Attributes.form


{-| See `TypedHtml.Attributes.height`.
-}
height : Float -> Attr { c | height : Supported } msg
height =
    TypedHtml.Attributes.height


{-| See `TypedHtml.Attributes.href`.
-}
href : String -> Attr { c | href : Supported } msg
href =
    TypedHtml.Attributes.href


{-| The `loading` attribute (this component's type differs from the shared canonical).
-}
loading : String -> Attr { c | loading : Supported } msg
loading value_ =
    Ir.attribute "loading" value_


{-| See `TypedHtml.Attributes.name`.
-}
name : String -> Attr { c | name : Supported } msg
name =
    TypedHtml.Attributes.name


{-| See `TypedHtml.Attributes.ping`.
-}
ping : String -> Attr { c | ping : Supported } msg
ping =
    TypedHtml.Attributes.ping


{-| The `referrerpolicy` attribute (this component's type differs from the shared canonical).
-}
referrerpolicy : String -> Attr { c | referrerpolicy : Supported } msg
referrerpolicy value_ =
    Ir.attribute "referrerpolicy" value_


{-| See `TypedHtml.Attributes.rel`.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    TypedHtml.Attributes.rel


{-| The `sandbox` attribute (this component's type differs from the shared canonical).
-}
sandbox : String -> Attr { c | sandbox : Supported } msg
sandbox value_ =
    Ir.attribute "sandbox" value_


{-| The `shape` attribute (this component's type differs from the shared canonical).
-}
shape : String -> Attr { c | shape : Supported } msg
shape value_ =
    Ir.attribute "shape" value_


{-| See `TypedHtml.Attributes.src`.
-}
src : String -> Attr { c | src : Supported } msg
src =
    TypedHtml.Attributes.src


{-| See `TypedHtml.Attributes.srcdoc`.
-}
srcdoc : String -> Attr { c | srcdoc : Supported } msg
srcdoc =
    TypedHtml.Attributes.srcdoc


{-| See `TypedHtml.Attributes.target`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    TypedHtml.Attributes.target


{-| See `TypedHtml.Attributes.width`.
-}
width : Float -> Attr { c | width : Supported } msg
width =
    TypedHtml.Attributes.width
