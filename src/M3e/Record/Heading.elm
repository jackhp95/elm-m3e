module M3e.Record.Heading exposing (view, emphasized, level, size, variant, tocIgnore)

{-| A heading to a page or section.

**Component Info:**

  - **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->


## Examples


### Examples

<!-- elm-cem:example title="Typescale variants and sizes" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.large ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.medium ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.small ] [ Kit.text "Display Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.headline, M3e.Heading.size M3e.Token.large ] [ Kit.text "Headline Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.headline, M3e.Heading.size M3e.Token.medium ] [ Kit.text "Headline Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.headline, M3e.Heading.size M3e.Token.small ] [ Kit.text "Headline Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.large ] [ Kit.text "Title Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.medium ] [ Kit.text "Title Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.small ] [ Kit.text "Title Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.label, M3e.Heading.size M3e.Token.large ] [ Kit.text "Label Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.label, M3e.Heading.size M3e.Token.medium ] [ Kit.text "Label Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.label, M3e.Heading.size M3e.Token.small ] [ Kit.text "Label Small" ]
    ]
```

<!-- elm-cem:example title="Emphasized typescale" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.large, M3e.Heading.emphasized True ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.medium, M3e.Heading.emphasized True ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.small, M3e.Heading.emphasized True ] [ Kit.text "Display Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.headline, M3e.Heading.size M3e.Token.large, M3e.Heading.emphasized True ] [ Kit.text "Headline Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.headline, M3e.Heading.size M3e.Token.medium, M3e.Heading.emphasized True ] [ Kit.text "Headline Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.headline, M3e.Heading.size M3e.Token.small, M3e.Heading.emphasized True ] [ Kit.text "Headline Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.large, M3e.Heading.emphasized True ] [ Kit.text "Title Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.medium, M3e.Heading.emphasized True ] [ Kit.text "Title Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.small, M3e.Heading.emphasized True ] [ Kit.text "Title Small" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.label, M3e.Heading.size M3e.Token.large, M3e.Heading.emphasized True ] [ Kit.text "Label Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.label, M3e.Heading.size M3e.Token.medium, M3e.Heading.emphasized True ] [ Kit.text "Label Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.label, M3e.Heading.size M3e.Token.small, M3e.Heading.emphasized True ] [ Kit.text "Label Small" ]
    ]
```


### Sizes

<!-- elm-cem:example title="Label Small" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.large ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.medium ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.small ] [ Kit.text "Display Small" ]
    ]
```

<!-- elm-cem:example title="Label Small (2)" -->
```elm
[ M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.large, M3e.Heading.emphasized True ] [ Kit.text "Display Large" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.medium, M3e.Heading.emphasized True ] [ Kit.text "Display Medium" ]
    , M3e.Heading.view [ M3e.Heading.variant M3e.Token.display, M3e.Heading.size M3e.Token.small, M3e.Heading.emphasized True ] [ Kit.text "Display Small" ]
    ]
```

@docs view, emphasized, level, size, variant, tocIgnore

-}

import M3e.Html.Heading
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-heading>` element (lazy IR).
-}
view :
    { content : Markup.Element.Element { text : Markup.Kind.Shared } msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { emphasized : M3e.Token.Supported
                , level : M3e.Token.Supported
                , size : M3e.Token.Supported
                , variant : M3e.Token.Supported
                , tocIgnore : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | heading : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Heading.heading
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode req_.content ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
emphasized : Bool -> Markup.Html.Attr.Attr { c | emphasized : M3e.Token.Supported } msg
emphasized =
    M3e.Html.Heading.emphasized


{-| The accessibility level of the heading.
-}
level : Int -> Markup.Html.Attr.Attr { c | level : M3e.Token.Supported } msg
level =
    M3e.Html.Heading.level


{-| The size of the heading. (default: `"medium"`)
-}
size :
    M3e.Token.Value
        { large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size =
    M3e.Html.Heading.size


{-| The appearance variant of the heading. (default: `"display"`)
-}
variant :
    M3e.Token.Value
        { display : M3e.Token.Supported
        , headline : M3e.Token.Supported
        , label : M3e.Token.Supported
        , title : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.Heading.variant


{-| Exclude this heading from the table of contents generated by an `m3e-toc` component. `m3e-toc-ignore` is a valueless presence marker the `m3e-toc` reads from heading elements; it is not an `m3e-heading` CEM attribute, so it is injected here as a heading-scoped synthetic capability.
-}
tocIgnore : Bool -> Markup.Html.Attr.Attr { c | tocIgnore : M3e.Token.Supported } msg
tocIgnore =
    M3e.Html.Heading.tocIgnore
