module TypedHtml.Text exposing
    ( abbr, b, bdi, bdo, br, cite, code, data, del, dfn, em, i, ins, kbd, mark, meter, progress, q, rp, rt, ruby, s, samp, small, span, strong, sub, sup, time, u, var, wbr
    , AbbrIs, AbbrAttrs, AbbrContent, AbbrChildAdmittedBy, BIs, BAttrs, BContent, BChildAdmittedBy, BdiIs, BdiAttrs, BdiContent, BdiChildAdmittedBy, BdoIs, BdoAttrs, BdoContent, BdoChildAdmittedBy, BrIs, BrAttrs, BrChildAdmittedBy, CiteIs, CiteAttrs, CiteContent, CiteChildAdmittedBy, CodeIs, CodeAttrs, CodeContent, CodeChildAdmittedBy, DataIs, DataAttrs, DataContent, DataChildAdmittedBy, DelAttrs, DelChildAdmittedBy, DfnIs, DfnAttrs, DfnContent, DfnChildAdmittedBy, EmIs, EmAttrs, EmContent, EmChildAdmittedBy, IIs, IAttrs, IContent, IChildAdmittedBy, InsAttrs, InsChildAdmittedBy, KbdIs, KbdAttrs, KbdContent, KbdChildAdmittedBy, MarkIs, MarkAttrs, MarkContent, MarkChildAdmittedBy, MeterIs, MeterAttrs, MeterContent, MeterChildAdmittedBy, ProgressIs, ProgressAttrs, ProgressContent, ProgressChildAdmittedBy, QIs, QAttrs, QContent, QChildAdmittedBy, RpIs, RpAttrs, RpContent, RpChildAdmittedBy, RpAdmittedBy, RtIs, RtAttrs, RtContent, RtChildAdmittedBy, RtAdmittedBy, RubyIs, RubyAttrs, RubyContent, RubyChildAdmittedBy, SIs, SAttrs, SContent, SChildAdmittedBy, SampIs, SampAttrs, SampContent, SampChildAdmittedBy, SmallIs, SmallAttrs, SmallContent, SmallChildAdmittedBy, SpanIs, SpanAttrs, SpanContent, SpanChildAdmittedBy, SpanRoles, StrongIs, StrongAttrs, StrongContent, StrongChildAdmittedBy, SubIs, SubAttrs, SubContent, SubChildAdmittedBy, SupIs, SupAttrs, SupContent, SupChildAdmittedBy, TimeIs, TimeAttrs, TimeContent, TimeChildAdmittedBy, UIs, UAttrs, UContent, UChildAdmittedBy, VarIs, VarAttrs, VarContent, VarChildAdmittedBy, WbrIs, WbrAttrs, WbrChildAdmittedBy
    , datetime, high, low, max, min, optimum, value
    )

{-| The `Text` element home: constructors, per-element rows, and
co-located re-exports of the shared attributes its elements admit.

@docs abbr, b, bdi, bdo, br, cite, code, data, del, dfn, em, i, ins, kbd, mark, meter, progress, q, rp, rt, ruby, s, samp, small, span, strong, sub, sup, time, u, var, wbr
@docs AbbrIs, AbbrAttrs, AbbrContent, AbbrChildAdmittedBy, BIs, BAttrs, BContent, BChildAdmittedBy, BdiIs, BdiAttrs, BdiContent, BdiChildAdmittedBy, BdoIs, BdoAttrs, BdoContent, BdoChildAdmittedBy, BrIs, BrAttrs, BrChildAdmittedBy, CiteIs, CiteAttrs, CiteContent, CiteChildAdmittedBy, CodeIs, CodeAttrs, CodeContent, CodeChildAdmittedBy, DataIs, DataAttrs, DataContent, DataChildAdmittedBy, DelAttrs, DelChildAdmittedBy, DfnIs, DfnAttrs, DfnContent, DfnChildAdmittedBy, EmIs, EmAttrs, EmContent, EmChildAdmittedBy, IIs, IAttrs, IContent, IChildAdmittedBy, InsAttrs, InsChildAdmittedBy, KbdIs, KbdAttrs, KbdContent, KbdChildAdmittedBy, MarkIs, MarkAttrs, MarkContent, MarkChildAdmittedBy, MeterIs, MeterAttrs, MeterContent, MeterChildAdmittedBy, ProgressIs, ProgressAttrs, ProgressContent, ProgressChildAdmittedBy, QIs, QAttrs, QContent, QChildAdmittedBy, RpIs, RpAttrs, RpContent, RpChildAdmittedBy, RpAdmittedBy, RtIs, RtAttrs, RtContent, RtChildAdmittedBy, RtAdmittedBy, RubyIs, RubyAttrs, RubyContent, RubyChildAdmittedBy, SIs, SAttrs, SContent, SChildAdmittedBy, SampIs, SampAttrs, SampContent, SampChildAdmittedBy, SmallIs, SmallAttrs, SmallContent, SmallChildAdmittedBy, SpanIs, SpanAttrs, SpanContent, SpanChildAdmittedBy, SpanRoles, StrongIs, StrongAttrs, StrongContent, StrongChildAdmittedBy, SubIs, SubAttrs, SubContent, SubChildAdmittedBy, SupIs, SupAttrs, SupContent, SupChildAdmittedBy, TimeIs, TimeAttrs, TimeContent, TimeChildAdmittedBy, UIs, UAttrs, UContent, UChildAdmittedBy, VarIs, VarAttrs, VarContent, VarChildAdmittedBy, WbrIs, WbrAttrs, WbrChildAdmittedBy
@docs datetime, high, low, max, min, optimum, value

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import Json.Encode
import TypedHtml.Attributes
import TypedHtml.Kind exposing (Brand, Ctx, Role)


{-| The kind row `abbr` produces.
-}
type alias AbbrIs s =
    { s | abbr : Brand }


{-| `abbr`'s closed attribute-capability row.
-}
type alias AbbrAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `abbr` admits.
-}
type alias AbbrContent =
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


{-| The context demand `abbr` injects into its children.
-}
type alias AbbrChildAdmittedBy childAdm =
    { childAdm | abbr : Ctx }


{-| The `abbr` element.
-}
abbr :
    List (Attr AbbrAttrs msg)
    -> List (Element AbbrContent (AbbrChildAdmittedBy childAdm) msg)
    -> Element (AbbrIs s) admittedBy msg
abbr attrs children =
    Ir.fromNode (Ir.node "abbr" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `b` produces.
-}
type alias BIs s =
    { s | b : Brand }


{-| `b`'s closed attribute-capability row.
-}
type alias BAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `b` admits.
-}
type alias BContent =
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


{-| The context demand `b` injects into its children.
-}
type alias BChildAdmittedBy childAdm =
    { childAdm | b : Ctx }


{-| The `b` element.
-}
b :
    List (Attr BAttrs msg)
    -> List (Element BContent (BChildAdmittedBy childAdm) msg)
    -> Element (BIs s) admittedBy msg
b attrs children =
    Ir.fromNode (Ir.node "b" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `bdi` produces.
-}
type alias BdiIs s =
    { s | bdi : Brand }


{-| `bdi`'s closed attribute-capability row.
-}
type alias BdiAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `bdi` admits.
-}
type alias BdiContent =
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


{-| The context demand `bdi` injects into its children.
-}
type alias BdiChildAdmittedBy childAdm =
    { childAdm | bdi : Ctx }


{-| The `bdi` element.
-}
bdi :
    List (Attr BdiAttrs msg)
    -> List (Element BdiContent (BdiChildAdmittedBy childAdm) msg)
    -> Element (BdiIs s) admittedBy msg
bdi attrs children =
    Ir.fromNode (Ir.node "bdi" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `bdo` produces.
-}
type alias BdoIs s =
    { s | bdo : Brand }


{-| `bdo`'s closed attribute-capability row.
-}
type alias BdoAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `bdo` admits.
-}
type alias BdoContent =
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


{-| The context demand `bdo` injects into its children.
-}
type alias BdoChildAdmittedBy childAdm =
    { childAdm | bdo : Ctx }


{-| The `bdo` element.
-}
bdo :
    List (Attr BdoAttrs msg)
    -> List (Element BdoContent (BdoChildAdmittedBy childAdm) msg)
    -> Element (BdoIs s) admittedBy msg
bdo attrs children =
    Ir.fromNode (Ir.node "bdo" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `br` produces.
-}
type alias BrIs s =
    { s | br : Brand }


{-| `br`'s closed attribute-capability row.
-}
type alias BrAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand `br` injects into its children.
-}
type alias BrChildAdmittedBy childAdm =
    { childAdm | br : Ctx }


{-| The `br` element.
-}
br :
    List (Attr BrAttrs msg)
    -> List (Element childAccepts (BrChildAdmittedBy childAdm) msg)
    -> Element (BrIs s) admittedBy msg
br attrs children =
    Ir.fromNode (Ir.node "br" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `cite` produces.
-}
type alias CiteIs s =
    { s | cite : Brand }


{-| `cite`'s closed attribute-capability row.
-}
type alias CiteAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `cite` admits.
-}
type alias CiteContent =
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


{-| The context demand `cite` injects into its children.
-}
type alias CiteChildAdmittedBy childAdm =
    { childAdm | cite : Ctx }


{-| The `cite` element.
-}
cite :
    List (Attr CiteAttrs msg)
    -> List (Element CiteContent (CiteChildAdmittedBy childAdm) msg)
    -> Element (CiteIs s) admittedBy msg
cite attrs children =
    Ir.fromNode (Ir.node "cite" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `code` produces.
-}
type alias CodeIs s =
    { s | code : Brand }


{-| `code`'s closed attribute-capability row.
-}
type alias CodeAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `code` admits.
-}
type alias CodeContent =
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


{-| The context demand `code` injects into its children.
-}
type alias CodeChildAdmittedBy childAdm =
    { childAdm | code : Ctx }


{-| The `code` element.
-}
code :
    List (Attr CodeAttrs msg)
    -> List (Element CodeContent (CodeChildAdmittedBy childAdm) msg)
    -> Element (CodeIs s) admittedBy msg
code attrs children =
    Ir.fromNode (Ir.node "code" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `data` produces.
-}
type alias DataIs s =
    { s | data : Brand }


{-| `data`'s closed attribute-capability row.
-}
type alias DataAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    , value : Supported
    }


{-| The kinds `data` admits.
-}
type alias DataContent =
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


{-| The context demand `data` injects into its children.
-}
type alias DataChildAdmittedBy childAdm =
    { childAdm | data : Ctx }


{-| The `data` element.
-}
data :
    List (Attr DataAttrs msg)
    -> List (Element DataContent (DataChildAdmittedBy childAdm) msg)
    -> Element (DataIs s) admittedBy msg
data attrs children =
    Ir.fromNode (Ir.node "data" attrs (List.map HtmlIr.Element.toNode children))


{-| `del`'s closed attribute-capability row.
-}
type alias DelAttrs =
    { cite : Supported
    , class : Supported
    , datetime : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand `del` injects into its children.
-}
type alias DelChildAdmittedBy childAdm =
    { childAdm | del : Ctx }


{-| The `del` element. Transparent content model: its produced kind row IS its
children's accepts row — it inherits its context's content model.
-}
del :
    List (Attr DelAttrs msg)
    -> List (Element childAccepts (DelChildAdmittedBy childAdm) msg)
    -> Element childAccepts admittedBy msg
del attrs children =
    Ir.fromNode (Ir.node "del" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `dfn` produces.
-}
type alias DfnIs s =
    { s | dfn : Brand }


{-| `dfn`'s closed attribute-capability row.
-}
type alias DfnAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `dfn` admits.
-}
type alias DfnContent =
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


{-| The context demand `dfn` injects into its children.
-}
type alias DfnChildAdmittedBy childAdm =
    { childAdm | dfn : Ctx }


{-| The `dfn` element.
-}
dfn :
    List (Attr DfnAttrs msg)
    -> List (Element DfnContent (DfnChildAdmittedBy childAdm) msg)
    -> Element (DfnIs s) admittedBy msg
dfn attrs children =
    Ir.fromNode (Ir.node "dfn" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `em` produces.
-}
type alias EmIs s =
    { s | em : Brand }


{-| `em`'s closed attribute-capability row.
-}
type alias EmAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `em` admits.
-}
type alias EmContent =
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


{-| The context demand `em` injects into its children.
-}
type alias EmChildAdmittedBy childAdm =
    { childAdm | em : Ctx }


{-| The `em` element.
-}
em :
    List (Attr EmAttrs msg)
    -> List (Element EmContent (EmChildAdmittedBy childAdm) msg)
    -> Element (EmIs s) admittedBy msg
em attrs children =
    Ir.fromNode (Ir.node "em" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `i` produces.
-}
type alias IIs s =
    { s | i : Brand }


{-| `i`'s closed attribute-capability row.
-}
type alias IAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `i` admits.
-}
type alias IContent =
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


{-| The context demand `i` injects into its children.
-}
type alias IChildAdmittedBy childAdm =
    { childAdm | i : Ctx }


{-| The `i` element.
-}
i :
    List (Attr IAttrs msg)
    -> List (Element IContent (IChildAdmittedBy childAdm) msg)
    -> Element (IIs s) admittedBy msg
i attrs children =
    Ir.fromNode (Ir.node "i" attrs (List.map HtmlIr.Element.toNode children))


{-| `ins`'s closed attribute-capability row.
-}
type alias InsAttrs =
    { cite : Supported
    , class : Supported
    , datetime : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand `ins` injects into its children.
-}
type alias InsChildAdmittedBy childAdm =
    { childAdm | ins : Ctx }


{-| The `ins` element. Transparent content model: its produced kind row IS its
children's accepts row — it inherits its context's content model.
-}
ins :
    List (Attr InsAttrs msg)
    -> List (Element childAccepts (InsChildAdmittedBy childAdm) msg)
    -> Element childAccepts admittedBy msg
ins attrs children =
    Ir.fromNode (Ir.node "ins" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `kbd` produces.
-}
type alias KbdIs s =
    { s | kbd : Brand }


{-| `kbd`'s closed attribute-capability row.
-}
type alias KbdAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `kbd` admits.
-}
type alias KbdContent =
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


{-| The context demand `kbd` injects into its children.
-}
type alias KbdChildAdmittedBy childAdm =
    { childAdm | kbd : Ctx }


{-| The `kbd` element.
-}
kbd :
    List (Attr KbdAttrs msg)
    -> List (Element KbdContent (KbdChildAdmittedBy childAdm) msg)
    -> Element (KbdIs s) admittedBy msg
kbd attrs children =
    Ir.fromNode (Ir.node "kbd" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `mark` produces.
-}
type alias MarkIs s =
    { s | mark : Brand }


{-| `mark`'s closed attribute-capability row.
-}
type alias MarkAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `mark` admits.
-}
type alias MarkContent =
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


{-| The context demand `mark` injects into its children.
-}
type alias MarkChildAdmittedBy childAdm =
    { childAdm | mark : Ctx }


{-| The `mark` element.
-}
mark :
    List (Attr MarkAttrs msg)
    -> List (Element MarkContent (MarkChildAdmittedBy childAdm) msg)
    -> Element (MarkIs s) admittedBy msg
mark attrs children =
    Ir.fromNode (Ir.node "mark" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `meter` produces.
-}
type alias MeterIs s =
    { s | meter : Brand }


{-| `meter`'s closed attribute-capability row.
-}
type alias MeterAttrs =
    { class : Supported
    , high : Supported
    , id : Supported
    , low : Supported
    , max : Supported
    , min : Supported
    , optimum : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    , value : Supported
    }


{-| The kinds `meter` admits.
-}
type alias MeterContent =
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


{-| The context demand `meter` injects into its children.
-}
type alias MeterChildAdmittedBy childAdm =
    { childAdm | meter : Ctx }


{-| The `meter` element.
-}
meter :
    List (Attr MeterAttrs msg)
    -> List (Element MeterContent (MeterChildAdmittedBy childAdm) msg)
    -> Element (MeterIs s) admittedBy msg
meter attrs children =
    Ir.fromNode (Ir.node "meter" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `progress` produces.
-}
type alias ProgressIs s =
    { s | progress : Brand }


{-| `progress`'s closed attribute-capability row.
-}
type alias ProgressAttrs =
    { class : Supported
    , id : Supported
    , max : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    , value : Supported
    }


{-| The kinds `progress` admits.
-}
type alias ProgressContent =
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


{-| The context demand `progress` injects into its children.
-}
type alias ProgressChildAdmittedBy childAdm =
    { childAdm | progress : Ctx }


{-| The `progress` element.
-}
progress :
    List (Attr ProgressAttrs msg)
    -> List (Element ProgressContent (ProgressChildAdmittedBy childAdm) msg)
    -> Element (ProgressIs s) admittedBy msg
progress attrs children =
    Ir.fromNode (Ir.node "progress" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `q` produces.
-}
type alias QIs s =
    { s | q : Brand }


{-| `q`'s closed attribute-capability row.
-}
type alias QAttrs =
    { cite : Supported
    , class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `q` admits.
-}
type alias QContent =
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


{-| The context demand `q` injects into its children.
-}
type alias QChildAdmittedBy childAdm =
    { childAdm | q : Ctx }


{-| The `q` element.
-}
q :
    List (Attr QAttrs msg)
    -> List (Element QContent (QChildAdmittedBy childAdm) msg)
    -> Element (QIs s) admittedBy msg
q attrs children =
    Ir.fromNode (Ir.node "q" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `rp` produces.
-}
type alias RpIs s =
    { s | rp : Brand }


{-| `rp`'s closed attribute-capability row.
-}
type alias RpAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `rp` admits.
-}
type alias RpContent =
    { sharedText : Shared }


{-| The context demand `rp` injects into its children.
-}
type alias RpChildAdmittedBy childAdm =
    { childAdm | rp : Ctx }


{-| The CLOSED parent contexts `rp` is valid inside.
-}
type alias RpAdmittedBy =
    { ruby : Ctx }


{-| The `rp` element.
-}
rp :
    List (Attr RpAttrs msg)
    -> List (Element RpContent (RpChildAdmittedBy childAdm) msg)
    -> Element (RpIs s) RpAdmittedBy msg
rp attrs children =
    Ir.fromNode (Ir.node "rp" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `rt` produces.
-}
type alias RtIs s =
    { s | rt : Brand }


{-| `rt`'s closed attribute-capability row.
-}
type alias RtAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `rt` admits.
-}
type alias RtContent =
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


{-| The context demand `rt` injects into its children.
-}
type alias RtChildAdmittedBy childAdm =
    { childAdm | rt : Ctx }


{-| The CLOSED parent contexts `rt` is valid inside.
-}
type alias RtAdmittedBy =
    { ruby : Ctx }


{-| The `rt` element.
-}
rt :
    List (Attr RtAttrs msg)
    -> List (Element RtContent (RtChildAdmittedBy childAdm) msg)
    -> Element (RtIs s) RtAdmittedBy msg
rt attrs children =
    Ir.fromNode (Ir.node "rt" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `ruby` produces.
-}
type alias RubyIs s =
    { s | ruby : Brand }


{-| `ruby`'s closed attribute-capability row.
-}
type alias RubyAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `ruby` admits.
-}
type alias RubyContent =
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
    , rp : Brand
    , rt : Brand
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


{-| The context demand `ruby` injects into its children.
-}
type alias RubyChildAdmittedBy childAdm =
    { childAdm | ruby : Ctx }


{-| The `ruby` element.
-}
ruby :
    List (Attr RubyAttrs msg)
    -> List (Element RubyContent (RubyChildAdmittedBy childAdm) msg)
    -> Element (RubyIs s) admittedBy msg
ruby attrs children =
    Ir.fromNode (Ir.node "ruby" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `s` produces.
-}
type alias SIs s =
    { s | s : Brand }


{-| `s`'s closed attribute-capability row.
-}
type alias SAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `s` admits.
-}
type alias SContent =
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


{-| The context demand `s` injects into its children.
-}
type alias SChildAdmittedBy childAdm =
    { childAdm | s : Ctx }


{-| The `s` element.
-}
s :
    List (Attr SAttrs msg)
    -> List (Element SContent (SChildAdmittedBy childAdm) msg)
    -> Element (SIs s) admittedBy msg
s attrs children =
    Ir.fromNode (Ir.node "s" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `samp` produces.
-}
type alias SampIs s =
    { s | samp : Brand }


{-| `samp`'s closed attribute-capability row.
-}
type alias SampAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `samp` admits.
-}
type alias SampContent =
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


{-| The context demand `samp` injects into its children.
-}
type alias SampChildAdmittedBy childAdm =
    { childAdm | samp : Ctx }


{-| The `samp` element.
-}
samp :
    List (Attr SampAttrs msg)
    -> List (Element SampContent (SampChildAdmittedBy childAdm) msg)
    -> Element (SampIs s) admittedBy msg
samp attrs children =
    Ir.fromNode (Ir.node "samp" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `small` produces.
-}
type alias SmallIs s =
    { s | small : Brand }


{-| `small`'s closed attribute-capability row.
-}
type alias SmallAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `small` admits.
-}
type alias SmallContent =
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


{-| The context demand `small` injects into its children.
-}
type alias SmallChildAdmittedBy childAdm =
    { childAdm | small : Ctx }


{-| The `small` element.
-}
small :
    List (Attr SmallAttrs msg)
    -> List (Element SmallContent (SmallChildAdmittedBy childAdm) msg)
    -> Element (SmallIs s) admittedBy msg
small attrs children =
    Ir.fromNode (Ir.node "small" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `span` produces.
-}
type alias SpanIs s =
    { s | span : Brand }


{-| `span`'s closed attribute-capability row.
-}
type alias SpanAttrs =
    { class : Supported
    , id : Supported
    , role : SpanRoles
    , slot : Supported
    , style : Supported
    }


{-| The kinds `span` admits.
-}
type alias SpanContent =
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


{-| The context demand `span` injects into its children.
-}
type alias SpanChildAdmittedBy childAdm =
    { childAdm | span : Ctx }


{-| The ARIA roles `span` admits (see `TypedHtml.Aria`).
-}
type alias SpanRoles =
    { generic : Role
    , group : Role
    , listitem : Role
    , none : Role
    , note : Role
    , presentation : Role
    , tooltip : Role
    }


{-| The `span` element.
-}
span :
    List (Attr SpanAttrs msg)
    -> List (Element SpanContent (SpanChildAdmittedBy childAdm) msg)
    -> Element (SpanIs s) admittedBy msg
span attrs children =
    Ir.fromNode (Ir.node "span" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `strong` produces.
-}
type alias StrongIs s =
    { s | strong : Brand }


{-| `strong`'s closed attribute-capability row.
-}
type alias StrongAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `strong` admits.
-}
type alias StrongContent =
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


{-| The context demand `strong` injects into its children.
-}
type alias StrongChildAdmittedBy childAdm =
    { childAdm | strong : Ctx }


{-| The `strong` element.
-}
strong :
    List (Attr StrongAttrs msg)
    -> List (Element StrongContent (StrongChildAdmittedBy childAdm) msg)
    -> Element (StrongIs s) admittedBy msg
strong attrs children =
    Ir.fromNode (Ir.node "strong" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `sub` produces.
-}
type alias SubIs s =
    { s | sub : Brand }


{-| `sub`'s closed attribute-capability row.
-}
type alias SubAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `sub` admits.
-}
type alias SubContent =
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


{-| The context demand `sub` injects into its children.
-}
type alias SubChildAdmittedBy childAdm =
    { childAdm | sub : Ctx }


{-| The `sub` element.
-}
sub :
    List (Attr SubAttrs msg)
    -> List (Element SubContent (SubChildAdmittedBy childAdm) msg)
    -> Element (SubIs s) admittedBy msg
sub attrs children =
    Ir.fromNode (Ir.node "sub" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `sup` produces.
-}
type alias SupIs s =
    { s | sup : Brand }


{-| `sup`'s closed attribute-capability row.
-}
type alias SupAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `sup` admits.
-}
type alias SupContent =
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


{-| The context demand `sup` injects into its children.
-}
type alias SupChildAdmittedBy childAdm =
    { childAdm | sup : Ctx }


{-| The `sup` element.
-}
sup :
    List (Attr SupAttrs msg)
    -> List (Element SupContent (SupChildAdmittedBy childAdm) msg)
    -> Element (SupIs s) admittedBy msg
sup attrs children =
    Ir.fromNode (Ir.node "sup" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `time` produces.
-}
type alias TimeIs s =
    { s | time : Brand }


{-| `time`'s closed attribute-capability row.
-}
type alias TimeAttrs =
    { class : Supported
    , datetime : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `time` admits.
-}
type alias TimeContent =
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


{-| The context demand `time` injects into its children.
-}
type alias TimeChildAdmittedBy childAdm =
    { childAdm | time : Ctx }


{-| The `time` element.
-}
time :
    List (Attr TimeAttrs msg)
    -> List (Element TimeContent (TimeChildAdmittedBy childAdm) msg)
    -> Element (TimeIs s) admittedBy msg
time attrs children =
    Ir.fromNode (Ir.node "time" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `u` produces.
-}
type alias UIs s =
    { s | u : Brand }


{-| `u`'s closed attribute-capability row.
-}
type alias UAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `u` admits.
-}
type alias UContent =
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


{-| The context demand `u` injects into its children.
-}
type alias UChildAdmittedBy childAdm =
    { childAdm | u : Ctx }


{-| The `u` element.
-}
u :
    List (Attr UAttrs msg)
    -> List (Element UContent (UChildAdmittedBy childAdm) msg)
    -> Element (UIs s) admittedBy msg
u attrs children =
    Ir.fromNode (Ir.node "u" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `var` produces.
-}
type alias VarIs s =
    { s | var : Brand }


{-| `var`'s closed attribute-capability row.
-}
type alias VarAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds `var` admits.
-}
type alias VarContent =
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


{-| The context demand `var` injects into its children.
-}
type alias VarChildAdmittedBy childAdm =
    { childAdm | var : Ctx }


{-| The `var` element.
-}
var :
    List (Attr VarAttrs msg)
    -> List (Element VarContent (VarChildAdmittedBy childAdm) msg)
    -> Element (VarIs s) admittedBy msg
var attrs children =
    Ir.fromNode (Ir.node "var" attrs (List.map HtmlIr.Element.toNode children))


{-| The kind row `wbr` produces.
-}
type alias WbrIs s =
    { s | wbr : Brand }


{-| `wbr`'s closed attribute-capability row.
-}
type alias WbrAttrs =
    { class : Supported
    , id : Supported
    , role : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand `wbr` injects into its children.
-}
type alias WbrChildAdmittedBy childAdm =
    { childAdm | wbr : Ctx }


{-| The `wbr` element.
-}
wbr :
    List (Attr WbrAttrs msg)
    -> List (Element childAccepts (WbrChildAdmittedBy childAdm) msg)
    -> Element (WbrIs s) admittedBy msg
wbr attrs children =
    Ir.fromNode (Ir.node "wbr" attrs (List.map HtmlIr.Element.toNode children))


{-| See `TypedHtml.Attributes.datetime`.
-}
datetime : Float -> Attr { c | datetime : Supported } msg
datetime =
    TypedHtml.Attributes.datetime


{-| See `TypedHtml.Attributes.high`.
-}
high : Float -> Attr { c | high : Supported } msg
high =
    TypedHtml.Attributes.high


{-| See `TypedHtml.Attributes.low`.
-}
low : Float -> Attr { c | low : Supported } msg
low =
    TypedHtml.Attributes.low


{-| See `TypedHtml.Attributes.max`.
-}
max : String -> Attr { c | max : Supported } msg
max =
    TypedHtml.Attributes.max


{-| See `TypedHtml.Attributes.min`.
-}
min : String -> Attr { c | min : Supported } msg
min =
    TypedHtml.Attributes.min


{-| See `TypedHtml.Attributes.optimum`.
-}
optimum : Float -> Attr { c | optimum : Supported } msg
optimum =
    TypedHtml.Attributes.optimum


{-| See `TypedHtml.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    TypedHtml.Attributes.value
