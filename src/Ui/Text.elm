module Ui.Text exposing
    ( Text, new
    , withAttributes
    , bodyLarge, bodyMedium, bodySmall, labelLarge, labelMedium, labelSmall
    , withId, withContent
    , Role(..), withRole
    , withInline
    , view
    )

{-| Typed builder for M3 **body / label** running text.

Unlike `Ui.Heading` (which wraps the `<m3e-heading>` element), there is **no
`m3e-body` / `m3e-text` custom element** in the CEM to delegate to. So `Ui.Text`
emits a semantic `<p>` (or `<span>`, via `withInline`) and applies the matching
M3 **typescale** utility class for the chosen role.

Those typescale classes (`text-body-lg`, `text-label-md`, …) are **not**
arbitrary styling: they are the M3 design tokens delivered through the
`tailwind-m3e-web` bridge — the same `--md-sys-typescale-*` values that
`<m3e-heading>` applies internally, surfaced as Tailwind v4 `--text-*` `@theme`
utilities. The bridge bundles font-size, line-height, letter-spacing, and
font-weight under each class. This is the sanctioned mechanism for non-heading
running text per the API-friction log entry **F3** ("no body-text typography
primitive" — the type-scale + color-role utilities _are_ the primitive here).

Kept deliberately distinct from `Ui.Heading`: no `level`, no heading semantics.


# Construction

@docs Text, new


# Host attributes

@docs withAttributes


# Text presets

Terse constructors for the common "styled body copy" case — each sets the
matching role and wraps a plain `String` as the content, so a call site stays a
one-liner (`Ui.Text.bodyLarge "Lorem ipsum…"`) while the M3 typescale still
comes from the bridge token (no baked styling). Refine further with the `with*`
modifiers as needed.

@docs bodyLarge, bodyMedium, bodySmall, labelLarge, labelMedium, labelSmall


# Identity and content

@docs withId, withContent


# Role

@docs Role, withRole


# Inline

@docs withInline


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Extra


{-| The text opaque type. Build via `new` or a preset (`bodyLarge`,
`bodyMedium`, `bodySmall`, `labelLarge`, `labelMedium`, `labelSmall`).
-}
type Text msg
    = Text (Config msg)


{-| The M3 typescale role this text renders at. These are the **body** and
**label** roles — the running-text roles that `Ui.Heading`
(Display/Headline/Title/Label) does not cover.
-}
type Role
    = BodyLarge
    | BodyMedium
    | BodySmall
    | LabelLarge
    | LabelMedium
    | LabelSmall


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , content : Maybe (Html msg)
    , role : Role
    , inline : Bool
    }


{-| A new text node at the given `Role`, rendered as a block `<p>` by default.
-}
new : Role -> Text msg
new role =
    Text
        { id = Nothing
        , attributes = []
        , content = Nothing
        , role = role
        , inline = False
        }


{-| `BodyLarge` running text from a plain string — the default body copy size.
-}
bodyLarge : String -> Text msg
bodyLarge text =
    new BodyLarge |> withContent (Html.text text)


{-| `BodyMedium` running text from a plain string.
-}
bodyMedium : String -> Text msg
bodyMedium text =
    new BodyMedium |> withContent (Html.text text)


{-| `BodySmall` running text from a plain string — captions and fine print.
-}
bodySmall : String -> Text msg
bodySmall text =
    new BodySmall |> withContent (Html.text text)


{-| `LabelLarge` text from a plain string — utilitarian UI label.
-}
labelLarge : String -> Text msg
labelLarge text =
    new LabelLarge |> withContent (Html.text text)


{-| `LabelMedium` text from a plain string.
-}
labelMedium : String -> Text msg
labelMedium text =
    new LabelMedium |> withContent (Html.text text)


{-| `LabelSmall` text from a plain string — the smallest utilitarian label.
-}
labelSmall : String -> Text msg
labelSmall text =
    new LabelSmall |> withContent (Html.text text)


{-| Append attributes to the rendered element — the escape hatch for extra
styling. The structural typescale class is emitted **after** these (matching
`Ui.Heading`), so callers can add their own classes/attributes without
clobbering the role token.
-}
withAttributes : List (Attribute msg) -> Text msg -> Text msg
withAttributes attributes (Text cfg) =
    Text { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Text msg -> Text msg
withId id (Text cfg) =
    Text { cfg | id = Just id }


{-| Set the text's content (arbitrary `Html`).
-}
withContent : Html msg -> Text msg -> Text msg
withContent content (Text cfg) =
    Text { cfg | content = Just content }


{-| Set the typescale role.
-}
withRole : Role -> Text msg -> Text msg
withRole role (Text cfg) =
    Text { cfg | role = role }


{-| Render inline as a `<span>` instead of the default block `<p>` — for text
that flows within a line (a styled run inside a sentence, a label beside an
icon, …).
-}
withInline : Text msg -> Text msg
withInline (Text cfg) =
    Text { cfg | inline = True }


{-| The `tailwind-m3e-web` typescale utility class backing each role. These are
the bridge's `--text-*` `@theme` keys (abbreviated `lg`/`md`/`sm` sizes), each
bundling the four typescale axes for the role.
-}
roleClass : Role -> String
roleClass role =
    case role of
        BodyLarge ->
            "text-body-lg"

        BodyMedium ->
            "text-body-md"

        BodySmall ->
            "text-body-sm"

        LabelLarge ->
            "text-label-lg"

        LabelMedium ->
            "text-label-md"

        LabelSmall ->
            "text-label-sm"


{-| Render the text as a semantic `<p>` (or `<span>` when `withInline` is set),
carrying the role's typescale class.
-}
view : Text msg -> Html msg
view (Text cfg) =
    let
        element : List (Attribute msg) -> List (Html msg) -> Html msg
        element =
            if cfg.inline then
                Html.span

            else
                Html.p
    in
    element
        (cfg.attributes
            ++ List.filterMap identity
                [ Just (Attr.class (roleClass cfg.role))
                , Maybe.map Attr.id cfg.id
                ]
        )
        [ Html.Extra.viewMaybe identity cfg.content ]
