module Ui.Avatar exposing
    ( Avatar, image, initials, icon
    , withId
    , view
    )

{-| Typed builder for M3 avatars. Wraps `M3e.Avatar`.

`M3e.Avatar` has no fallback glyph — it renders only its children — so an
avatar with no content is just an empty colored circle. Content is therefore
required, supplied by one of three explicit constructors matching the M3
"image / icon / initials" framing.


# Construction

@docs Avatar, image, initials, icon


# Identity

@docs withId


# Render

@docs view

@figma-code-connect node=<https://www.figma.com/design/cbhz1J779WAI7gYkjCQwS0/Avetta---ADS-Material-Rebrand?node-id=70620-97> entry=initials valueProp=Label

-}

import Html exposing (Html, text)
import Html.Attributes as Attr
import Html.Extra
import M3e.Avatar
import Ui.Icon


type Avatar msg
    = Avatar (Config msg)


type alias Config msg =
    { id : Maybe String
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


{-| An avatar displaying an icon.
-}
icon : Ui.Icon.Icon msg -> Avatar msg
icon glyph =
    new
        |> withContent (Ui.Icon.view glyph)


withId : String -> Avatar msg -> Avatar msg
withId id (Avatar cfg) =
    Avatar { cfg | id = Just id }


extractInitials : String -> String
extractInitials name =
    name
        |> String.words
        |> List.take 2
        |> List.filterMap (String.left 1 >> stringToMaybe)
        |> String.concat
        |> String.toUpper


stringToMaybe : String -> Maybe String
stringToMaybe s =
    if String.isEmpty s then
        Nothing

    else
        Just s


view : Avatar msg -> Html msg
view (Avatar cfg) =
    M3e.Avatar.component
        (List.filterMap identity [ Maybe.map Attr.id cfg.id ])
        [ Html.Extra.viewMaybe identity cfg.content ]



-- INTERNAL


new : Avatar msg
new =
    Avatar { id = Nothing, content = Nothing }


{-| Set the avatar's content. Module-internal: the three public constructors
(`image`/`initials`/`icon`) are the only ways to build an avatar, so there is
no meaningless empty default. Exposing this requires design approval.
-}
withContent : Html msg -> Avatar msg -> Avatar msg
withContent content (Avatar cfg) =
    Avatar { cfg | content = Just content }
