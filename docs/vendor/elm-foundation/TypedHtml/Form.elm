module TypedHtml.Form exposing
    ( fieldset, form, label, legend, output
    , FieldsetIs, FieldsetAttrs, FieldsetChildAdmittedBy, FormIs, FormAttrs, FormChildAdmittedBy, LabelIs, LabelAttrs, LabelContent, LabelChildAdmittedBy, LegendIs, LegendAttrs, LegendContent, LegendChildAdmittedBy, LegendAdmittedBy, OutputIs, OutputAttrs, OutputContent, OutputChildAdmittedBy
    , acceptCharset, action, autocomplete, disabled, enctype, for, method, name, novalidate, readonly, target
    )

{-| The `Form` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs fieldset, form, label, legend, output
@docs FieldsetIs, FieldsetAttrs, FieldsetChildAdmittedBy, FormIs, FormAttrs, FormChildAdmittedBy, LabelIs, LabelAttrs, LabelContent, LabelChildAdmittedBy, LegendIs, LegendAttrs, LegendContent, LegendChildAdmittedBy, LegendAdmittedBy, OutputIs, OutputAttrs, OutputContent, OutputChildAdmittedBy
@docs acceptCharset, action, autocomplete, disabled, enctype, for, method, name, novalidate, readonly, target

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx)


{-| The kind row `fieldset` produces.
-}
type alias FieldsetIs s =
    { s | fieldset : Brand }


{-| `fieldset`'s closed attribute-capability row.
-}
type alias FieldsetAttrs =
    { accesskey : Supported
    , autocapitalize : Supported
    , autocorrect : Supported
    , autofocus : Supported
    , class : Supported
    , contenteditable : Supported
    , dir : Supported
    , disabled : Supported
    , draggable : Supported
    , enterkeyhint : Supported
    , form : Supported
    , hidden : Supported
    , id : Supported
    , inert : Supported
    , inputmode : Supported
    , itemid : Supported
    , itemprop : Supported
    , itemref : Supported
    , itemscope : Supported
    , itemtype : Supported
    , lang : Supported
    , name : Supported
    , nonce : Supported
    , popover : Supported
    , readonly : Supported
    , role : Supported
    , slot : Supported
    , spellcheck : Supported
    , style : Supported
    , tabindex : Supported
    , title : Supported
    , translate : Supported
    , writingsuggestions : Supported
    }


{-| The context demand `fieldset` injects into its children.
-}
type alias FieldsetChildAdmittedBy childAdm =
    { childAdm | fieldset : Ctx }


{-| The `fieldset` element.
-}
fieldset :
    List (Attr FieldsetAttrs msg)
    -> List (Element childAccepts (FieldsetChildAdmittedBy childAdm) msg)
    -> Element (FieldsetIs s) admittedBy msg
fieldset attrs children =
    Ir.fromNode (Ir.node "fieldset" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `form` produces.
-}
type alias FormIs s =
    { s | form : Brand }


{-| `form`'s closed attribute-capability row.
-}
type alias FormAttrs =
    { acceptCharset : Supported
    , accesskey : Supported
    , action : Supported
    , autocapitalize : Supported
    , autocomplete : Supported
    , autocorrect : Supported
    , autofocus : Supported
    , class : Supported
    , contenteditable : Supported
    , dir : Supported
    , draggable : Supported
    , enctype : Supported
    , enterkeyhint : Supported
    , hidden : Supported
    , id : Supported
    , inert : Supported
    , inputmode : Supported
    , itemid : Supported
    , itemprop : Supported
    , itemref : Supported
    , itemscope : Supported
    , itemtype : Supported
    , lang : Supported
    , method : Supported
    , name : Supported
    , nonce : Supported
    , novalidate : Supported
    , popover : Supported
    , role : Supported
    , slot : Supported
    , spellcheck : Supported
    , style : Supported
    , tabindex : Supported
    , target : Supported
    , title : Supported
    , translate : Supported
    , writingsuggestions : Supported
    }


{-| The context demand `form` injects into its children.
-}
type alias FormChildAdmittedBy childAdm =
    { childAdm | form : Ctx }


{-| The `form` element.
-}
form :
    List (Attr FormAttrs msg)
    -> List (Element childAccepts (FormChildAdmittedBy childAdm) msg)
    -> Element (FormIs s) admittedBy msg
form attrs children =
    Ir.fromNode (Ir.node "form" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `label` produces.
-}
type alias LabelIs s =
    { s | label : Brand }


{-| `label`'s closed attribute-capability row.
-}
type alias LabelAttrs =
    { accesskey : Supported
    , autocapitalize : Supported
    , autocorrect : Supported
    , autofocus : Supported
    , class : Supported
    , contenteditable : Supported
    , dir : Supported
    , draggable : Supported
    , enterkeyhint : Supported
    , for : Supported
    , hidden : Supported
    , id : Supported
    , inert : Supported
    , inputmode : Supported
    , itemid : Supported
    , itemprop : Supported
    , itemref : Supported
    , itemscope : Supported
    , itemtype : Supported
    , lang : Supported
    , nonce : Supported
    , onClick : Supported
    , popover : Supported
    , role : Supported
    , slot : Supported
    , spellcheck : Supported
    , style : Supported
    , tabindex : Supported
    , title : Supported
    , translate : Supported
    , writingsuggestions : Supported
    }


{-| The kinds `label` admits.
-}
type alias LabelContent =
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


{-| The context demand `label` injects into its children.
-}
type alias LabelChildAdmittedBy childAdm =
    { childAdm | label : Ctx }


{-| The `label` element.
-}
label :
    List (Attr LabelAttrs msg)
    -> List (Element LabelContent (LabelChildAdmittedBy childAdm) msg)
    -> Element (LabelIs s) admittedBy msg
label attrs children =
    Ir.fromNode (Ir.node "label" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `legend` produces.
-}
type alias LegendIs s =
    { s | legend : Brand }


{-| `legend`'s closed attribute-capability row.
-}
type alias LegendAttrs =
    { accesskey : Supported
    , autocapitalize : Supported
    , autocorrect : Supported
    , autofocus : Supported
    , class : Supported
    , contenteditable : Supported
    , dir : Supported
    , draggable : Supported
    , enterkeyhint : Supported
    , hidden : Supported
    , id : Supported
    , inert : Supported
    , inputmode : Supported
    , itemid : Supported
    , itemprop : Supported
    , itemref : Supported
    , itemscope : Supported
    , itemtype : Supported
    , lang : Supported
    , nonce : Supported
    , popover : Supported
    , role : Supported
    , slot : Supported
    , spellcheck : Supported
    , style : Supported
    , tabindex : Supported
    , title : Supported
    , translate : Supported
    , writingsuggestions : Supported
    }


{-| The kinds `legend` admits.
-}
type alias LegendContent =
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


{-| The context demand `legend` injects into its children.
-}
type alias LegendChildAdmittedBy childAdm =
    { childAdm | legend : Ctx }


{-| The CLOSED parent contexts `legend` is valid inside.
-}
type alias LegendAdmittedBy =
    { fieldset : Ctx }


{-| The `legend` element.
-}
legend :
    List (Attr LegendAttrs msg)
    -> List (Element LegendContent (LegendChildAdmittedBy childAdm) msg)
    -> Element (LegendIs s) LegendAdmittedBy msg
legend attrs children =
    Ir.fromNode (Ir.node "legend" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `output` produces.
-}
type alias OutputIs s =
    { s | output : Brand }


{-| `output`'s closed attribute-capability row.
-}
type alias OutputAttrs =
    { accesskey : Supported
    , autocapitalize : Supported
    , autocorrect : Supported
    , autofocus : Supported
    , class : Supported
    , contenteditable : Supported
    , dir : Supported
    , disabled : Supported
    , draggable : Supported
    , enterkeyhint : Supported
    , for : Supported
    , form : Supported
    , hidden : Supported
    , id : Supported
    , inert : Supported
    , inputmode : Supported
    , itemid : Supported
    , itemprop : Supported
    , itemref : Supported
    , itemscope : Supported
    , itemtype : Supported
    , lang : Supported
    , name : Supported
    , nonce : Supported
    , popover : Supported
    , readonly : Supported
    , role : Supported
    , slot : Supported
    , spellcheck : Supported
    , style : Supported
    , tabindex : Supported
    , title : Supported
    , translate : Supported
    , writingsuggestions : Supported
    }


{-| The kinds `output` admits.
-}
type alias OutputContent =
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


{-| The context demand `output` injects into its children.
-}
type alias OutputChildAdmittedBy childAdm =
    { childAdm | output : Ctx }


{-| The `output` element.
-}
output :
    List (Attr OutputAttrs msg)
    -> List (Element OutputContent (OutputChildAdmittedBy childAdm) msg)
    -> Element (OutputIs s) admittedBy msg
output attrs children =
    Ir.fromNode (Ir.node "output" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.acceptCharset`.
-}
acceptCharset : String -> Attr { c | acceptCharset : Supported } msg
acceptCharset =
    TypedHtml.Attributes.acceptCharset


{-| See `TypedHtml.Attributes.action`.
-}
action : String -> Attr { c | action : Supported } msg
action =
    TypedHtml.Attributes.action


{-| See `TypedHtml.Attributes.autocomplete`.
-}
autocomplete : String -> Attr { c | autocomplete : Supported } msg
autocomplete =
    TypedHtml.Attributes.autocomplete


{-| See `TypedHtml.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    TypedHtml.Attributes.disabled


{-| Entry list encoding type to use for form submission
-}
enctype : String -> Attr { c | enctype : Supported } msg
enctype value_ =
    Ir.attribute "enctype" value_


{-| See `TypedHtml.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    TypedHtml.Attributes.for


{-| Variant to use for form submission
-}
method : String -> Attr { c | method : Supported } msg
method value_ =
    Ir.attribute "method" value_


{-| See `TypedHtml.Attributes.name`.
-}
name : String -> Attr { c | name : Supported } msg
name =
    TypedHtml.Attributes.name


{-| See `TypedHtml.Attributes.novalidate`.
-}
novalidate : Bool -> Attr { c | novalidate : Supported } msg
novalidate =
    TypedHtml.Attributes.novalidate


{-| See `TypedHtml.Attributes.readonly`.
-}
readonly : Bool -> Attr { c | readonly : Supported } msg
readonly =
    TypedHtml.Attributes.readonly


{-| See `TypedHtml.Attributes.target`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    TypedHtml.Attributes.target
