module TypedHtml.Button exposing
    ( button
    , Is, Attrs, Content, ChildAdmittedBy, Roles
    , commandfor, disabled, form, formaction, formenctype, formmethod, formnovalidate, formtarget, name, popovertarget, popovertargetaction, readonly, value
    )

{-| The `Button` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs button
@docs Is, Attrs, Content, ChildAdmittedBy, Roles
@docs commandfor, disabled, form, formaction, formenctype, formmethod, formnovalidate, formtarget, name, popovertarget, popovertargetaction, readonly, value

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx, Role)


{-| The kind row `button` produces.
-}
type alias Is s =
    { s | button : Brand }


{-| `button`'s closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , commandfor : Supported
    , disabled : Supported
    , form : Supported
    , formaction : Supported
    , formenctype : Supported
    , formmethod : Supported
    , formnovalidate : Supported
    , formtarget : Supported
    , id : Supported
    , name : Supported
    , onClick : Supported
    , popovertarget : Supported
    , popovertargetaction : Supported
    , readonly : Supported
    , role : Roles
    , slot : Supported
    , style : Supported
    , value : Supported
    }


{-| The kinds `button` admits.
-}
type alias Content =
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


{-| The context demand `button` injects into its children.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | button : Ctx }


{-| The ARIA roles `button` admits (see `TypedHtml.Aria`).
-}
type alias Roles =
    { checkbox : Role
    , combobox : Role
    , link : Role
    , menuitem : Role
    , menuitemcheckbox : Role
    , menuitemradio : Role
    , none : Role
    , option : Role
    , presentation : Role
    , radio : Role
    , switch : Role
    , tab : Role
    }


{-| The `button` element.
-}
button :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
button attrs children =
    Ir.fromNode (Ir.node "button" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.commandfor`.
-}
commandfor : String -> Attr { c | commandfor : Supported } msg
commandfor =
    TypedHtml.Attributes.commandfor


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


{-| See `TypedHtml.Attributes.name`.
-}
name : String -> Attr { c | name : Supported } msg
name =
    TypedHtml.Attributes.name


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


{-| See `TypedHtml.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    TypedHtml.Attributes.value
