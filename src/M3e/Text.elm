module M3e.Text exposing
    ( view
    , Option, Role(..)
    , inline
    , bodyLarge, bodyMedium, bodySmall, labelLarge, labelMedium, labelSmall
    )

{-| Semantic running-text primitive — emits `<p>` (block) or `<span>` (inline)
carrying the M3 typescale utility class from the `tailwind-m3e-web` bridge.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : String, role : Role }
    (the content and its typescale role are both essential; no
    visible-text a11y concern since this IS the text)
  - Options: inline (switch from block `<p>` to inline `<span>`)
  - Slots: default slot ← text content (Node.text)
  - Properties: none
  - Attrs: class = typescale utility (sanctioned exception to "no baked
    classes" per friction-log F3 — the bridge's `--text-*` `@theme`
    utilities ARE the typography primitive for body/label roles)
  - Escape: html (default-slot; content is a plain string → Node.text)
  - Tag: text

SPECIAL CASE: there is no `m3e-body` / `m3e-label` custom element in the CEM.
The M3 typescale for running text is delivered via the `tailwind-m3e-web` bridge
as Tailwind v4 `--text-*` `@theme` utilities. The class on `<p>`/`<span>` IS the
primitive.

@docs view
@docs Option, Role
@docs inline
@docs bodyLarge, bodyMedium, bodySmall, labelLarge, labelMedium, labelSmall

-}

import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable exposing (Renderable, Supported)


{-| The M3 typescale role this text renders at — the **body** and **label**
roles that `M3e.Heading` (Display/Headline/Title/Label) does not cover.
-}
type Role
    = BodyLarge
    | BodyMedium
    | BodySmall
    | LabelLarge
    | LabelMedium
    | LabelSmall


{-| An option configuring a text node.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Render inline as a `<span>` instead of the default block `<p>` — for text
that flows within a line or sits beside another element.
-}
inline : Option msg
inline =
    Internal.option (\c -> { c | inline = True })


{-| `BodyLarge` block text — the default body-copy size. One-liner preset.
-}
bodyLarge : String -> Renderable { s | text : Supported } msg
bodyLarge content =
    view { content = content, role = BodyLarge } []


{-| `BodyMedium` block text. One-liner preset.
-}
bodyMedium : String -> Renderable { s | text : Supported } msg
bodyMedium content =
    view { content = content, role = BodyMedium } []


{-| `BodySmall` block text — captions and fine print. One-liner preset.
-}
bodySmall : String -> Renderable { s | text : Supported } msg
bodySmall content =
    view { content = content, role = BodySmall } []


{-| `LabelLarge` text — utilitarian UI label. One-liner preset.
-}
labelLarge : String -> Renderable { s | text : Supported } msg
labelLarge content =
    view { content = content, role = LabelLarge } []


{-| `LabelMedium` text. One-liner preset.
-}
labelMedium : String -> Renderable { s | text : Supported } msg
labelMedium content =
    view { content = content, role = LabelMedium } []


{-| `LabelSmall` text — the smallest utilitarian label. One-liner preset.
-}
labelSmall : String -> Renderable { s | text : Supported } msg
labelSmall content =
    view { content = content, role = LabelSmall } []


type alias Config =
    { inline : Bool }


{-| Render the text node.

The `role` drives the typescale utility class (`text-body-lg`, `text-label-md`,
…). The `content` becomes the child `Text` node. Pass `inline` as an option
to switch the element from `<p>` to `<span>`.

-}
view : { content : String, role : Role } -> List (Option msg) -> Renderable { s | text : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts { inline = False }

        tag : String
        tag =
            if c.inline then
                "span"

            else
                "p"
    in
    Internal.fromNode
        (Node.element tag
            [ Node.attribute "class" (roleClass req.role) ]
            [ Node.text req.content ]
        )


{-| The `tailwind-m3e-web` typescale utility class for each role.
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
