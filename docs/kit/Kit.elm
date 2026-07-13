module Kit exposing
    ( text, link, textLink
    , Size, display, headline, title, body, labelText, code, paragraph
    , colored, overline, tint
    , TextColor, onSurface, onSurfaceVariant, primary, secondary, tertiary, error
    )

{-| The design-system **userland kit**: the sanctioned home for the visual seam.

The single `Seam` boundary discards type guarantees, so it is meant to live only
in a few blessed adapter modules (see `NoSeamOutsideAllowedModules`, allow-list
`["Native", "Layout", "Kit", ...]`). `Layout` owns the _layout_ seam (flex/grid/gap);
`Kit` owns the _visual_ seam — typography, color, and (via `Kit.Surface` /
`Kit.Shape`) surface roles and corner shapes. Feature/route code composes these
named primitives instead of passing raw Tailwind through the seam itself.


## Text producers

`text` and `link` are the **semantic seams** (`docs/DESIGN.md` §4): no longer privileged
bespoke producers, they are thin, feature-facing re-exports of the `Seam` couplers
(`Seam.text`/`Seam.link`), which are in turn built on the generator-emitted
`M3e.Seam` stampers. Feature code calls these named producers; the raw crossing
stays fenced in `Seam`. `textLink` is a _styled_ inline link — a visual-kit concern.

@docs text, link, textLink


## Type scale

Each renders an inline `<span>` (or `<code>`) carrying exactly one M3 type-scale
class plus any color roles, so route code never writes `text-body-lg` by hand.

@docs Size, display, headline, title, body, labelText, code, paragraph


## Color

@docs colored, overline, tint
@docs TextColor, onSurface, onSurfaceVariant, primary, secondary, tertiary, error

-}

import Html exposing (Attribute, Html)
import Html.Attributes
import M3e.Kind
import M3e.Seam exposing (Link, Text)
import M3e.Token as Value exposing (Supported, Value)
import Markup.Element as Element exposing (Element)
import Markup.Html.Attr as Attr exposing (Attr)
import Markup.Kind
import Markup.Node as Node
import Native
import Seam



-- TEXT PRODUCERS --------------------------------------------------------------


{-| Slotted text (the `text` seam) — a feature-facing re-export of `Seam.text`,
built on the generated `M3e.Seam` stamper so it carries the `text` kind.
-}
text : String -> Text s msg
text =
    Seam.text


{-| A plain navigation anchor (the `link` seam) — a feature-facing re-export of
`Seam.link`. The library doesn't opinionate links; swap the coupler in `Seam`.
-}
link : String -> List (Element s msg) -> Link s msg
link =
    Seam.link


{-| An inline text link (`hover:underline`, tinted by the given color roles) —
for links inside prose, as opposed to the unstyled navigation `link`.
-}
textLink : String -> List TextColor -> List (Element s msg) -> Element { k | sharedLink : Markup.Kind.Shared } msg
textLink href colors kids =
    Seam.asElement
        (Node.fromComponent
            (\a c ->
                Html.a
                    (Html.Attributes.href href
                        :: Attr.toAttribute (classAttr [ "hover:underline" ] colors)
                        :: List.map Attr.toAttribute a
                    )
                    c
            )
            []
            (List.map Element.toNode kids)
        )



-- TYPE SCALE ------------------------------------------------------------------


{-| The M3 type-scale size axis: `Value.small` / `Value.medium` / `Value.large`,
mapped to the Tailwind `sm` / `md` / `lg` suffixes.
-}
type alias Size =
    Value { small : Supported, medium : Supported, large : Supported }


sizeSuffix : Size -> String
sizeSuffix size =
    case Value.toString size of
        "large" ->
            "lg"

        "medium" ->
            "md"

        "small" ->
            "sm"

        other ->
            other


{-| An inline text run at a `<role>-<size>` type-scale class, tinted by the given
color roles. Rendered as `tag`.
-}
typescale : (List (Attribute msg) -> List (Html msg) -> Html msg) -> String -> Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
typescale tag role size colors kids =
    Native.node tag
        [ classAttr [ "text-" ++ role ++ "-" ++ sizeSuffix size ] colors ]
        kids


{-| Display type scale (`text-display-{lg|md|sm}`), rendered `<span>`.
-}
display : Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
display =
    typescale Html.span "display"


{-| Headline type scale (`text-headline-{lg|md|sm}`), rendered `<span>`.
-}
headline : Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
headline =
    typescale Html.span "headline"


{-| Title type scale (`text-title-{lg|md|sm}`), rendered `<span>`.
-}
title : Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
title =
    typescale Html.span "title"


{-| Body type scale (`text-body-{lg|md|sm}`), rendered `<span>`.
-}
body : Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
body =
    typescale Html.span "body"


{-| Label type scale (`text-label-{lg|md|sm}`), rendered `<span>`. Named
`labelText` (not `label`) so it doesn't collide with the `<label>`-element
producers `Native.label` / `Seam.label`, which feature code commonly imports.
-}
labelText : Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
labelText =
    typescale Html.span "label"


{-| Inline code at the body type scale, rendered `<code>` (monospace via the tag).
-}
code : Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
code =
    typescale (Html.node "code") "body"


{-| A prose paragraph at the body type scale, rendered as a block `<p>`. This is
the block counterpart to `body`; wrap it in a `Layout` helper for a `max-w-*`
readable measure where you want one.
-}
paragraph : Size -> List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
paragraph =
    typescale (Html.node "p") "body"


{-| An M3 "overline" eyebrow: label-large, uppercase, letter-spaced. Rendered as a
block `<p>` so it sits on its own line above a heading.
-}
overline : List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
overline colors kids =
    Native.node (Html.node "p")
        [ classAttr [ "text-label-lg uppercase tracking-wide" ] colors ]
        kids



-- COLOR -----------------------------------------------------------------------


{-| A text color role (the `on-*` / accent side of the M3 palette). Opaque so
route code names roles (`Kit.onSurfaceVariant`) instead of writing class strings.
-}
type TextColor
    = TextColor String


textColorClass : TextColor -> String
textColorClass (TextColor cls) =
    cls


{-| The one place the `class="<leading tokens> <color roles>"` idiom lives: compose
a class `Attr` from leading literal class tokens plus a list of color roles. Every
typography/color producer (`textLink`/`typescale`/`overline`/`colored`/`tint`)
builds its class list through here so the join/order is identical.
-}
classAttr : List String -> List TextColor -> Attr c msg
classAttr extras colors =
    Seam.asAttribute
        (Html.Attributes.class
            (String.join " " (extras ++ List.map textColorClass colors))
        )


{-| Tint arbitrary content (e.g. an icon) with the given color roles, without
imposing a type scale. Rendered `<span>`.
-}
colored : List TextColor -> List (Element s msg) -> Element { k | html : M3e.Kind.Brand } msg
colored colors kids =
    Native.span
        [ classAttr [] colors ]
        kids


{-| Color roles as a composable attribute — to tint a specific semantic element
(`Native.node (Html.node "code") [ Kit.tint [ Kit.primary ] ] …`) without wrapping
it in a `<span>` or overriding its type scale. The attribute form of `colored`.
-}
tint : List TextColor -> Attr c msg
tint colors =
    classAttr [] colors


{-| `text-on-surface`.
-}
onSurface : TextColor
onSurface =
    TextColor "text-on-surface"


{-| `text-on-surface-variant`.
-}
onSurfaceVariant : TextColor
onSurfaceVariant =
    TextColor "text-on-surface-variant"


{-| `text-primary`.
-}
primary : TextColor
primary =
    TextColor "text-primary"


{-| `text-secondary`.
-}
secondary : TextColor
secondary =
    TextColor "text-secondary"


{-| `text-tertiary`.
-}
tertiary : TextColor
tertiary =
    TextColor "text-tertiary"


{-| `text-error`.
-}
error : TextColor
error =
    TextColor "text-error"
