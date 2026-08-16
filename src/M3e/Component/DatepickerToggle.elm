module M3e.Component.DatepickerToggle exposing
    ( component
    , Is, Attrs, ChildAdmittedBy
    )

{-| The `m3e-datepicker-toggle` component — strict per-component surface.

An element, nested within a clickable element, used to toggle a datepicker.

@docs component
@docs Is, Attrs, ChildAdmittedBy

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Html as H
import M3e.Internal.Types.DatepickerToggle
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-datepicker-toggle` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.DatepickerToggle.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.DatepickerToggle.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.DatepickerToggle.ChildAdmittedBy childAdm


{-| Required-content (and action) constructor — omissions are unwritable.
-}
component :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
component required_ attrs children =
    H.datepickerToggle (Ir.attribute "for" required_.for :: attrs) children
