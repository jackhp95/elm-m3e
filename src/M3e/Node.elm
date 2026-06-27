module M3e.Node exposing
    ( Node(..), Attr(..)
    , element, text, raw
    , attribute, property, rawAttr, on, withSlot
    , map, toHtml
    , childrenOf, tagOf, findAttribute, findProperty, setAttribute
    )

{-| The introspectable IR. Relational attrs (`id`/`for`/`slot`/`aria-*`) and
web-component properties are modeled explicitly so parents can inject/inspect
them and tests can read them; everything else (codegen attrs, ALL events incl
custom) rides opaquely in `RawAttr`. We build on `elm/html`; the only vdom touch
is `VirtualDom.mapAttribute` for `map`.

@docs Node, Attr
@docs element, text, raw
@docs attribute, property, rawAttr, on, withSlot
@docs map, toHtml
@docs childrenOf, tagOf, findAttribute, findProperty, setAttribute

-}

import Html exposing (Html)
import Html.Attributes as A
import Html.Events as E
import Json.Decode as Decode
import Json.Encode as Encode
import VirtualDom


type Node msg
    = Element { tag : String, attrs : List (Attr msg), children : List (Node msg) }
    | Text String
    | Raw (Html msg)


type Attr msg
    = Attribute String String -- introspectable: relational attrs
    | Property String Encode.Value -- introspectable: web-component props (testable)
    | RawAttr (Html.Attribute msg) -- opaque passthrough: codegen attrs + events


element : String -> List (Attr msg) -> List (Node msg) -> Node msg
element tag attrs children =
    Element { tag = tag, attrs = attrs, children = children }


text : String -> Node msg
text =
    Text


raw : Html msg -> Node msg
raw =
    Raw


attribute : String -> String -> Attr msg
attribute =
    Attribute


property : String -> Encode.Value -> Attr msg
property =
    Property


rawAttr : Html.Attribute msg -> Attr msg
rawAttr =
    RawAttr


on : String -> Decode.Decoder msg -> Attr msg
on name decoder =
    RawAttr (E.on name decoder)


withSlot : String -> Node msg -> Node msg
withSlot name node =
    setAttribute "slot" name node


setAttribute : String -> String -> Node msg -> Node msg
setAttribute key value node =
    case node of
        Element el ->
            Element
                { el | attrs = Attribute key value :: List.filter (\a -> attrKey a /= Just key) el.attrs }

        _ ->
            node


attrKey : Attr msg -> Maybe String
attrKey attr =
    case attr of
        Attribute k _ ->
            Just k

        Property k _ ->
            Just k

        RawAttr _ ->
            Nothing


map : (a -> b) -> Node a -> Node b
map f node =
    case node of
        Text s ->
            Text s

        Raw h ->
            Raw (Html.map f h)

        Element el ->
            Element
                { tag = el.tag
                , attrs = List.map (mapAttr f) el.attrs
                , children = List.map (map f) el.children
                }


mapAttr : (a -> b) -> Attr a -> Attr b
mapAttr f attr =
    case attr of
        Attribute k v ->
            Attribute k v

        Property k v ->
            Property k v

        RawAttr a ->
            RawAttr (VirtualDom.mapAttribute f a)


toHtml : Node msg -> Html msg
toHtml node =
    case node of
        Text s ->
            Html.text s

        Raw h ->
            h

        Element el ->
            Html.node el.tag (List.map attrToHtml el.attrs) (List.map toHtml el.children)


attrToHtml : Attr msg -> Html.Attribute msg
attrToHtml attr =
    case attr of
        Attribute k v ->
            A.attribute k v

        Property k v ->
            A.property k v

        RawAttr a ->
            a


findAttribute : String -> Node msg -> Maybe String
findAttribute key node =
    attrsOf node
        |> List.filterMap
            (\a ->
                case a of
                    Attribute k v ->
                        if k == key then
                            Just v

                        else
                            Nothing

                    _ ->
                        Nothing
            )
        |> List.head


findProperty : String -> Node msg -> Maybe Encode.Value
findProperty key node =
    attrsOf node
        |> List.filterMap
            (\a ->
                case a of
                    Property k v ->
                        if k == key then
                            Just v

                        else
                            Nothing

                    _ ->
                        Nothing
            )
        |> List.head


tagOf : Node msg -> Maybe String
tagOf node =
    case node of
        Element el ->
            Just el.tag

        _ ->
            Nothing


childrenOf : Node msg -> List (Node msg)
childrenOf node =
    case node of
        Element el ->
            el.children

        _ ->
            []


attrsOf : Node msg -> List (Attr msg)
attrsOf node =
    case node of
        Element el ->
            el.attrs

        _ ->
            []
