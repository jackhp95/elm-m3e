module TypedHtml.Scripting exposing
    ( noscript, script, slot, template
    , NoscriptIs, NoscriptAttrs, NoscriptContent, NoscriptChildAdmittedBy, ScriptIs, ScriptAttrs, ScriptContent, ScriptChildAdmittedBy, SlotAttrs, SlotChildAdmittedBy, TemplateIs, TemplateAttrs, TemplateChildAdmittedBy
    , async, blocking, crossorigin, defer, fetchpriority, integrity, name, nomodule, referrerpolicy, shadowrootclonable, shadowrootcustomelementregistry, shadowrootdelegatesfocus, shadowrootmode, shadowrootserializable, shadowrootslotassignment, src
    )

{-| The `Scripting` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs noscript, script, slot, template
@docs NoscriptIs, NoscriptAttrs, NoscriptContent, NoscriptChildAdmittedBy, ScriptIs, ScriptAttrs, ScriptContent, ScriptChildAdmittedBy, SlotAttrs, SlotChildAdmittedBy, TemplateIs, TemplateAttrs, TemplateChildAdmittedBy
@docs async, blocking, crossorigin, defer, fetchpriority, integrity, name, nomodule, referrerpolicy, shadowrootclonable, shadowrootcustomelementregistry, shadowrootdelegatesfocus, shadowrootmode, shadowrootserializable, shadowrootslotassignment, src

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx)


{-| The kind row `noscript` produces.
-}
type alias NoscriptIs s =
    { s | noscript : Brand }


{-| `noscript`'s closed attribute-capability row.
-}
type alias NoscriptAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `noscript` admits.
-}
type alias NoscriptContent =
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
    , sharedText : Shared
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


{-| The context demand `noscript` injects into its children.
-}
type alias NoscriptChildAdmittedBy childAdm =
    { childAdm | noscript : Ctx }


{-| The `noscript` element.
-}
noscript :
    List (Attr NoscriptAttrs msg)
    -> List (Element NoscriptContent (NoscriptChildAdmittedBy childAdm) msg)
    -> Element (NoscriptIs s) admittedBy msg
noscript attrs children =
    Ir.fromNode (Ir.node "noscript" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `script` produces.
-}
type alias ScriptIs s =
    { s | script : Brand }


{-| `script`'s closed attribute-capability row.
-}
type alias ScriptAttrs =
    { async : Supported
    , blocking : Supported
    , class : Supported
    , crossorigin : Supported
    , defer : Supported
    , fetchpriority : Supported
    , id : Supported
    , integrity : Supported
    , nomodule : Supported
    , referrerpolicy : Supported
    , role : Supported
    , slot : Supported
    , src : Supported
    , style : Supported
    }


{-| The kinds `script` admits.
-}
type alias ScriptContent =
    { sharedText : Shared }


{-| The context demand `script` injects into its children.
-}
type alias ScriptChildAdmittedBy childAdm =
    { childAdm | script : Ctx }


{-| The `script` element.
-}
script :
    List (Attr ScriptAttrs msg)
    -> List (Element ScriptContent (ScriptChildAdmittedBy childAdm) msg)
    -> Element (ScriptIs s) admittedBy msg
script attrs children =
    Ir.fromNode (Ir.node "script" attrs (List.map HtmlIr.Element.toNode children))


{-| `slot`'s closed attribute-capability row.
-}
type alias SlotAttrs =
    { class : Supported
    , id : Supported
    , name : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand `slot` injects into its children.
-}
type alias SlotChildAdmittedBy childAdm =
    { childAdm | slot : Ctx }


{-| The `slot` element. Transparent content model: its produced kind row IS its
children's accepts row — it inherits its context's content model.
-}
slot :
    List (Attr SlotAttrs msg)
    -> List (Element childAccepts (SlotChildAdmittedBy childAdm) msg)
    -> Element childAccepts admittedBy msg
slot attrs children =
    Ir.fromNode (Ir.node "slot" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `template` produces.
-}
type alias TemplateIs s =
    { s | template : Brand }


{-| `template`'s closed attribute-capability row.
-}
type alias TemplateAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , shadowrootclonable : Supported
    , shadowrootcustomelementregistry : Supported
    , shadowrootdelegatesfocus : Supported
    , shadowrootmode : Supported
    , shadowrootserializable : Supported
    , shadowrootslotassignment : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand `template` injects into its children.
-}
type alias TemplateChildAdmittedBy childAdm =
    { childAdm | template : Ctx }


{-| The `template` element.
-}
template :
    List (Attr TemplateAttrs msg)
    -> List (Element childAccepts (TemplateChildAdmittedBy childAdm) msg)
    -> Element (TemplateIs s) admittedBy msg
template attrs children =
    Ir.fromNode (Ir.node "template" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.async`.
-}
async : Bool -> Attr { c | async : Supported } msg
async =
    TypedHtml.Attributes.async


{-| The `blocking` attribute (this component's type differs from the shared canonical).
-}
blocking : String -> Attr { c | blocking : Supported } msg
blocking value_ =
    Ir.attribute "blocking" value_


{-| The `crossorigin` attribute (this component's type differs from the shared canonical).
-}
crossorigin : String -> Attr { c | crossorigin : Supported } msg
crossorigin value_ =
    Ir.attribute "crossorigin" value_


{-| See `TypedHtml.Attributes.defer`.
-}
defer : Bool -> Attr { c | defer : Supported } msg
defer =
    TypedHtml.Attributes.defer


{-| The `fetchpriority` attribute (this component's type differs from the shared canonical).
-}
fetchpriority : String -> Attr { c | fetchpriority : Supported } msg
fetchpriority value_ =
    Ir.attribute "fetchpriority" value_


{-| See `TypedHtml.Attributes.integrity`.
-}
integrity : String -> Attr { c | integrity : Supported } msg
integrity =
    TypedHtml.Attributes.integrity


{-| See `TypedHtml.Attributes.name`.
-}
name : String -> Attr { c | name : Supported } msg
name =
    TypedHtml.Attributes.name


{-| See `TypedHtml.Attributes.nomodule`.
-}
nomodule : Bool -> Attr { c | nomodule : Supported } msg
nomodule =
    TypedHtml.Attributes.nomodule


{-| The `referrerpolicy` attribute (this component's type differs from the shared canonical).
-}
referrerpolicy : String -> Attr { c | referrerpolicy : Supported } msg
referrerpolicy value_ =
    Ir.attribute "referrerpolicy" value_


{-| See `TypedHtml.Attributes.shadowrootclonable`.
-}
shadowrootclonable : Bool -> Attr { c | shadowrootclonable : Supported } msg
shadowrootclonable =
    TypedHtml.Attributes.shadowrootclonable


{-| See `TypedHtml.Attributes.shadowrootcustomelementregistry`.
-}
shadowrootcustomelementregistry : Bool -> Attr { c | shadowrootcustomelementregistry : Supported } msg
shadowrootcustomelementregistry =
    TypedHtml.Attributes.shadowrootcustomelementregistry


{-| See `TypedHtml.Attributes.shadowrootdelegatesfocus`.
-}
shadowrootdelegatesfocus : Bool -> Attr { c | shadowrootdelegatesfocus : Supported } msg
shadowrootdelegatesfocus =
    TypedHtml.Attributes.shadowrootdelegatesfocus


{-| The `shadowrootmode` attribute (this component's type differs from the shared canonical).
-}
shadowrootmode : String -> Attr { c | shadowrootmode : Supported } msg
shadowrootmode value_ =
    Ir.attribute "shadowrootmode" value_


{-| See `TypedHtml.Attributes.shadowrootserializable`.
-}
shadowrootserializable : Bool -> Attr { c | shadowrootserializable : Supported } msg
shadowrootserializable =
    TypedHtml.Attributes.shadowrootserializable


{-| The `shadowrootslotassignment` attribute (this component's type differs from the shared canonical).
-}
shadowrootslotassignment : String -> Attr { c | shadowrootslotassignment : Supported } msg
shadowrootslotassignment value_ =
    Ir.attribute "shadowrootslotassignment" value_


{-| See `TypedHtml.Attributes.src`.
-}
src : String -> Attr { c | src : Supported } msg
src =
    TypedHtml.Attributes.src
