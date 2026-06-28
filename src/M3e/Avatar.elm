module M3e.Avatar exposing
    ( Option
    , view
    , image, initials, iconChild
    )

{-| `<m3e-avatar>` — an image, initials, or icon representing a user.

Spec (per docs/CONVENTIONS.md):

  - Required: { ariaLabel : String } (→ aria-label on m3e-avatar; also →
    img[alt] for the image variant — upstream m3e-avatar has no attributes
    of its own, so `ariaLabel` is the single string that serves both roles)
  - Options: image (src String), initials (text String),
    iconChild (icon Element)
  - Slots: default (the content child — img, text, or icon)
  - Properties: none (CEM Avatar has no attributes)
  - Attrs: aria-label (from required `ariaLabel`)
  - Escape: none (leaf)
  - Tag: avatar

`Cem.M3e.Avatar` renders only its children (no fallback glyph), so content is
supplied by exactly one of `image` / `initials` / `iconChild` (last-write-wins).
An avatar with no content option renders an empty circle.

**Note on naming:** the upstream `m3e-avatar` element declares no `alt` or
`aria-label` attribute in its CEM — it relies on the host setting `aria-label`.
The old `alt` field was renamed to `ariaLabel` to make the intent unambiguous;
the same string still flows to the `<img alt>` attribute in the image variant.


# Types

@docs Option

@docs view


# Options

@docs image, initials, iconChild

-}

import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- OPTIONS ----------------------------------------------------------------


type Content msg
    = ImgContent String
    | TextContent String
    | IconContent (Element { icon : Supported } msg)
    | NoContent


{-| An avatar configuration option — chooses the avatar's content.
-}
type alias Option msg =
    Internal.Option (Content msg) msg


{-| Display an image (e.g. a profile photo) — rendered as an `<img>` child
carrying `src` and the required `alt`.
-}
image : String -> Option msg
image src =
    Internal.option (\_ -> ImgContent src)


{-| Display textual initials — rendered as a text child.
-}
initials : String -> Option msg
initials text =
    Internal.option (\_ -> TextContent text)


{-| Display an icon glyph — the generic-identity fallback.
-}
iconChild : Element { icon : Supported } msg -> Option msg
iconChild icon =
    Internal.option (\_ -> IconContent icon)



-- VIEW -------------------------------------------------------------------


{-| Render the avatar. The required `ariaLabel` becomes the `aria-label`
attribute on the host element (and the `<img alt>` for the image variant).
-}
view : { ariaLabel : String } -> List (Option msg) -> Element { s | avatar : Supported } msg
view req opts =
    let
        content : Content msg
        content =
            Internal.applyOptions opts NoContent

        children : List (Node msg)
        children =
            case content of
                ImgContent src ->
                    [ Node.element "img"
                        [ Node.attribute "src" src
                        , Node.attribute "alt" req.ariaLabel
                        ]
                        []
                    ]

                TextContent text ->
                    [ Node.text text ]

                IconContent icon ->
                    [ Element.toNode icon ]

                NoContent ->
                    []
    in
    Internal.fromNode
        (Node.element "m3e-avatar"
            [ Node.attribute "aria-label" req.ariaLabel ]
            children
        )
