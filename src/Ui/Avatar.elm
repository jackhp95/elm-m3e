module Ui.Avatar exposing
    ( Avatar, image, initials, icon
    , withAttributes
    , withId
    , view
    , extractInitials
    )

{-| Typed builder for M3 avatars. Wraps `Cem.M3e.Avatar`.

`Cem.M3e.Avatar` has no fallback glyph — it renders only its children — so an
avatar with no content is just an empty colored circle. Content is therefore
required, supplied by one of three explicit constructors matching the M3
"image / icon / initials" framing.


# Construction

@docs Avatar, image, initials, icon


# Host attributes

@docs withAttributes


# Identity

@docs withId


# Render

@docs view


# Internals (exposed for testing)

@docs extractInitials

@figma-code-connect node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70620-97> entry=initials valueProp=Label

-}

import Html exposing (Attribute, Html, text)
import Html.Attributes as Attr
import Html.Extra
import Cem.M3e.Avatar
import Ui.Icon


{-| The avatar opaque type. Build via `image`, `initials`, or `icon`.
-}
type Avatar msg
    = Avatar (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , content : Maybe (Html msg)
    }


{-| An avatar displaying an image (e.g. a profile photo). `alt` is the
accessible text for the image.
-}
image : { url : String, alt : String } -> Avatar msg
image { url, alt } =
    new
        |> withContent (Html.img [ Attr.src url, Attr.alt alt ] [])


{-| An avatar displaying the user's initials. Pass the full name; this
extracts up to two initials.

    Ui.Avatar.initials "Jack Peterson"
        |> Ui.Avatar.withId "user-avatar"
        |> Ui.Avatar.view
    -- renders "JP"

-}
initials : String -> Avatar msg
initials name =
    new
        |> withContent (text (extractInitials name))


{-| An avatar displaying an icon glyph — the generic-identity fallback when
there is no photo or name (e.g. `Ui.Icon.material "person"`).
-}
icon : Ui.Icon.Icon msg -> Avatar msg
icon glyph =
    new
        |> withContent (Ui.Icon.view glyph)


{-| Append attributes to the underlying `<m3e-avatar>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Avatar msg -> Avatar msg
withAttributes attributes (Avatar cfg) =
    Avatar { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Avatar msg -> Avatar msg
withId id (Avatar cfg) =
    Avatar { cfg | id = Just id }


{-| Derive avatar text from a full name.

Takes the first character of each of the first two words, upper-cased — so
`"Jack Peterson"` yields `"JP"`. The characters are kept regardless of class,
so non-letter names still render: `"123"` yields `"12"` (the first character of
its single word, plus the leading characters when there is only one word).

Whenever the result would otherwise be empty — an empty or whitespace-only
name — a safe fallback glyph (`"?"`) is returned instead, so an avatar is
never the empty colored circle this module is designed to avoid.

-}
extractInitials : String -> String
extractInitials name =
    let
        wordsList : List String
        wordsList =
            String.words name

        initialsFromWords : String
        initialsFromWords =
            case wordsList of
                [] ->
                    ""

                [ single ] ->
                    -- A single word (e.g. "123" or "Jack"): take its first two
                    -- characters so single-token labels are not reduced to one
                    -- glyph.
                    String.left 2 single

                _ ->
                    wordsList
                        |> List.take 2
                        |> List.map (String.left 1)
                        |> String.concat
    in
    case String.toUpper initialsFromWords of
        "" ->
            fallbackGlyph

        upper ->
            upper


{-| The glyph used when a name carries no usable characters at all.
-}
fallbackGlyph : String
fallbackGlyph =
    "?"


{-| Render the avatar.
-}
view : Avatar msg -> Html msg
view (Avatar cfg) =
    Cem.M3e.Avatar.component
        (cfg.attributes ++ List.filterMap identity [ Maybe.map Attr.id cfg.id ])
        [ Html.Extra.viewMaybe identity cfg.content ]



-- INTERNAL


new : Avatar msg
new =
    Avatar { id = Nothing, attributes = [], content = Nothing }


{-| Set the avatar's content. Module-internal: the three public constructors
(`image`/`initials`/`icon`) are the only ways to build an avatar, so there is
no meaningless empty default. Exposing this requires design approval.
-}
withContent : Html msg -> Avatar msg -> Avatar msg
withContent content (Avatar cfg) =
    Avatar { cfg | content = Just content }
