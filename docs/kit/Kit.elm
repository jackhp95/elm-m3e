module Kit exposing
    ( text, link, textLink
    , Size, display, headline, title, body, labelText, code, paragraph
    , colored, overline, tint
    , TextColor, onSurface, onSurfaceVariant, primary, secondary, tertiary, error
    )

{-| The design-system **userland kit**: the sanctioned home for the visual seam.

Migrated to the phantom substrate: `M3e.Seam`/`Markup.*` replaced by
`HtmlIr.*` and `Seam`.

## Text producers

@docs text, link, textLink


## Type scale

@docs Size, display, headline, title, body, labelText, code, paragraph


## Color

@docs colored, overline, tint
@docs TextColor, onSurface, onSurfaceVariant, primary, secondary, tertiary, error

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value
import HtmlIr.Value exposing (Value)
import M3e.Kind
import Native
import Seam



-- TEXT PRODUCERS --------------------------------------------------------------


{-| Slotted text (the `text` seam) — carries the `sharedText` kind so it
type-checks in any `sharedText` slot.
-}
text : String -> Element { s | sharedText : Shared } admittedBy msg
text =
    Seam.text


{-| A plain navigation anchor (the `link` seam) — carries the `sharedLink` kind.
-}
link : String -> List (Element s admittedBy msg) -> Element { k | sharedLink : Shared } linkAdm msg
link =
    Seam.link


{-| An inline text link (`hover:underline`, tinted by the given color roles).
-}
textLink : String -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
textLink href colors kids =
    Native.node "a"
        [ Seam.asAttribute (Html.Attributes.href href)
        , classAttr [ "hover:underline" ] colors
        ]
        kids



-- TYPE SCALE ------------------------------------------------------------------


{-| The M3 type-scale size axis: `M3e.Values.small` / `M3e.Values.medium` / `M3e.Values.large`.
Compatible with Value tokens from `M3e.Values` (or any aliased import).
-}
type alias Size =
    Value { small : Supported, medium : Supported, large : Supported }


sizeSuffix : Size -> String
sizeSuffix size =
    case HtmlIr.Value.toString size of
        "large" ->
            "lg"

        "medium" ->
            "md"

        "small" ->
            "sm"

        other ->
            other


{-| An inline text run at a `<role>-<size>` type-scale class. Rendered as `tag`.
-}
typescale : String -> String -> Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
typescale tagName role size colors kids =
    Native.node tagName
        [ classAttr [ "text-" ++ role ++ "-" ++ sizeSuffix size ] colors ]
        kids


{-| Display type scale (`text-display-{lg|md|sm}`), rendered `<span>`.
-}
display : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
display =
    typescale "span" "display"


{-| Headline type scale (`text-headline-{lg|md|sm}`), rendered `<span>`.
-}
headline : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
headline =
    typescale "span" "headline"


{-| Title type scale (`text-title-{lg|md|sm}`), rendered `<span>`.
-}
title : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
title =
    typescale "span" "title"


{-| Body type scale (`text-body-{lg|md|sm}`), rendered `<span>`.
-}
body : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
body =
    typescale "span" "body"


{-| Label type scale (`text-label-{lg|md|sm}`), rendered `<span>`.
-}
labelText : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
labelText =
    typescale "span" "label"


{-| Inline code at the body type scale, rendered `<code>`.
-}
code : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
code =
    typescale "code" "body"


{-| A prose paragraph at the body type scale, rendered as a block `<p>`.
-}
paragraph : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
paragraph =
    typescale "p" "body"


{-| An M3 "overline" eyebrow: label-large, uppercase, letter-spaced.
-}
overline : List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
overline colors kids =
    Native.node "p"
        [ classAttr [ "text-label-lg uppercase tracking-wide" ] colors ]
        kids



-- COLOR -----------------------------------------------------------------------


{-| A text color role.
-}
type TextColor
    = TextColor String


textColorClass : TextColor -> String
textColorClass (TextColor cls) =
    cls


{-| Build a class `Attr` from leading literal class tokens plus color roles.
-}
classAttr : List String -> List TextColor -> Attr c msg
classAttr extras colors =
    Seam.asAttribute
        (Html.Attributes.class
            (String.join " " (extras ++ List.map textColorClass colors))
        )


{-| Tint arbitrary content with the given color roles, wrapped in a `<span>`.
-}
colored : List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
colored colors kids =
    Native.span [ classAttr [] colors ] kids


{-| Color roles as a composable attribute.
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
