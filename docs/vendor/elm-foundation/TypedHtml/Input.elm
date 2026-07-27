module TypedHtml.Input exposing
    ( input
    , Is, Attrs, ChildAdmittedBy
    , accept, alpha, alt, autocomplete, checked, colorspace, dirname, disabled, form, formaction, formenctype, formmethod, formnovalidate, formtarget, height, list, max, maxlength, min, minlength, multiple, name, pattern, placeholder, popovertarget, popovertargetaction, readonly, required, size, src, step, value, width
    )

{-| The `Input` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs input
@docs Is, Attrs, ChildAdmittedBy
@docs accept, alpha, alt, autocomplete, checked, colorspace, dirname, disabled, form, formaction, formenctype, formmethod, formnovalidate, formtarget, height, list, max, maxlength, min, minlength, multiple, name, pattern, placeholder, popovertarget, popovertargetaction, readonly, required, size, src, step, value, width

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx)


{-| The kind row `input` produces.
-}
type alias Is s =
    { s | input : Brand }


{-| `input`'s closed attribute-capability row.
-}
type alias Attrs =
    { accept : Supported
    , alpha : Supported
    , alt : Supported
    , autocomplete : Supported
    , checked : Supported
    , class : Supported
    , colorspace : Supported
    , dirname : Supported
    , disabled : Supported
    , form : Supported
    , formaction : Supported
    , formenctype : Supported
    , formmethod : Supported
    , formnovalidate : Supported
    , formtarget : Supported
    , height : Supported
    , id : Supported
    , list : Supported
    , max : Supported
    , maxlength : Supported
    , min : Supported
    , minlength : Supported
    , multiple : Supported
    , name : Supported
    , onClick : Supported
    , pattern : Supported
    , placeholder : Supported
    , popovertarget : Supported
    , popovertargetaction : Supported
    , readonly : Supported
    , required : Supported
    , role : Supported
    , size : Supported
    , slot : Supported
    , src : Supported
    , step : Supported
    , style : Supported
    , value : Supported
    , width : Supported
    }


{-| The context demand `input` injects into its children.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | input : Ctx }


{-| The `input` element.
-}
input :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
input attrs children =
    Ir.fromNode (Ir.node "input" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.accept`.
-}
accept : String -> Attr { c | accept : Supported } msg
accept =
    TypedHtml.Attributes.accept


{-| See `TypedHtml.Attributes.alpha`.
-}
alpha : Bool -> Attr { c | alpha : Supported } msg
alpha =
    TypedHtml.Attributes.alpha


{-| See `TypedHtml.Attributes.alt`.
-}
alt : String -> Attr { c | alt : Supported } msg
alt =
    TypedHtml.Attributes.alt


{-| See `TypedHtml.Attributes.autocomplete`.
-}
autocomplete : String -> Attr { c | autocomplete : Supported } msg
autocomplete =
    TypedHtml.Attributes.autocomplete


{-| See `TypedHtml.Attributes.checked`.
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked =
    TypedHtml.Attributes.checked


{-| The `colorspace` attribute (this component's type differs from the shared canonical).
-}
colorspace : String -> Attr { c | colorspace : Supported } msg
colorspace value_ =
    Ir.attribute "colorspace" value_


{-| See `TypedHtml.Attributes.dirname`.
-}
dirname : String -> Attr { c | dirname : Supported } msg
dirname =
    TypedHtml.Attributes.dirname


{-| See `TypedHtml.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    TypedHtml.Attributes.disabled


{-| See `TypedHtml.Attributes.form`.
-}
form : String -> Attr { c | form : Supported } msg
form =
    TypedHtml.Attributes.form


{-| See `TypedHtml.Attributes.formaction`.
-}
formaction : String -> Attr { c | formaction : Supported } msg
formaction =
    TypedHtml.Attributes.formaction


{-| The `formenctype` attribute (this component's type differs from the shared canonical).
-}
formenctype : String -> Attr { c | formenctype : Supported } msg
formenctype value_ =
    Ir.attribute "formenctype" value_


{-| The `formmethod` attribute (this component's type differs from the shared canonical).
-}
formmethod : String -> Attr { c | formmethod : Supported } msg
formmethod value_ =
    Ir.attribute "formmethod" value_


{-| See `TypedHtml.Attributes.formnovalidate`.
-}
formnovalidate : Bool -> Attr { c | formnovalidate : Supported } msg
formnovalidate =
    TypedHtml.Attributes.formnovalidate


{-| See `TypedHtml.Attributes.formtarget`.
-}
formtarget : String -> Attr { c | formtarget : Supported } msg
formtarget =
    TypedHtml.Attributes.formtarget


{-| See `TypedHtml.Attributes.height`.
-}
height : Float -> Attr { c | height : Supported } msg
height =
    TypedHtml.Attributes.height


{-| See `TypedHtml.Attributes.list`.
-}
list : String -> Attr { c | list : Supported } msg
list =
    TypedHtml.Attributes.list


{-| See `TypedHtml.Attributes.max`.
-}
max : String -> Attr { c | max : Supported } msg
max =
    TypedHtml.Attributes.max


{-| See `TypedHtml.Attributes.maxlength`.
-}
maxlength : Float -> Attr { c | maxlength : Supported } msg
maxlength =
    TypedHtml.Attributes.maxlength


{-| See `TypedHtml.Attributes.min`.
-}
min : String -> Attr { c | min : Supported } msg
min =
    TypedHtml.Attributes.min


{-| See `TypedHtml.Attributes.minlength`.
-}
minlength : Float -> Attr { c | minlength : Supported } msg
minlength =
    TypedHtml.Attributes.minlength


{-| See `TypedHtml.Attributes.multiple`.
-}
multiple : Bool -> Attr { c | multiple : Supported } msg
multiple =
    TypedHtml.Attributes.multiple


{-| See `TypedHtml.Attributes.name`.
-}
name : String -> Attr { c | name : Supported } msg
name =
    TypedHtml.Attributes.name


{-| See `TypedHtml.Attributes.pattern`.
-}
pattern : String -> Attr { c | pattern : Supported } msg
pattern =
    TypedHtml.Attributes.pattern


{-| See `TypedHtml.Attributes.placeholder`.
-}
placeholder : String -> Attr { c | placeholder : Supported } msg
placeholder =
    TypedHtml.Attributes.placeholder


{-| See `TypedHtml.Attributes.popovertarget`.
-}
popovertarget : String -> Attr { c | popovertarget : Supported } msg
popovertarget =
    TypedHtml.Attributes.popovertarget


{-| The `popovertargetaction` attribute (this component's type differs from the shared canonical).
-}
popovertargetaction : String -> Attr { c | popovertargetaction : Supported } msg
popovertargetaction value_ =
    Ir.attribute "popovertargetaction" value_


{-| See `TypedHtml.Attributes.readonly`.
-}
readonly : Bool -> Attr { c | readonly : Supported } msg
readonly =
    TypedHtml.Attributes.readonly


{-| See `TypedHtml.Attributes.required`.
-}
required : Bool -> Attr { c | required : Supported } msg
required =
    TypedHtml.Attributes.required


{-| See `TypedHtml.Attributes.size`.
-}
size : Float -> Attr { c | size : Supported } msg
size =
    TypedHtml.Attributes.size


{-| See `TypedHtml.Attributes.src`.
-}
src : String -> Attr { c | src : Supported } msg
src =
    TypedHtml.Attributes.src


{-| See `TypedHtml.Attributes.step`.
-}
step : Float -> Attr { c | step : Supported } msg
step =
    TypedHtml.Attributes.step


{-| See `TypedHtml.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    TypedHtml.Attributes.value


{-| See `TypedHtml.Attributes.width`.
-}
width : Float -> Attr { c | width : Supported } msg
width =
    TypedHtml.Attributes.width
