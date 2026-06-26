module Cem.M3e.Shape exposing (Name(..), component, name)

{-| 
A shape used to add emphasis and decorative flair.

## Component

@docs component

### Attributes

@docs Name, name
-}


import Html
import Html.Attributes


{-| A shape used to add emphasis and decorative flair. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-shape" attributes children


{-| Values for the `name` attribute. -}
type Name
    = V12SidedCookie
    | V4LeafClover
    | V4SidedCookie
    | V6SidedCookie
    | V7SidedCookie
    | V8LeafClover
    | V9SidedCookie
    | Arch
    | Arrow
    | Boom
    | Bun
    | Burst
    | Circle
    | Diamond
    | Fan
    | Flower
    | Gem
    | GhostIsh
    | Heart
    | Hexagon
    | Oval
    | Pentagon
    | Pill
    | PixelCircle
    | PixelTriangle
    | Puffy
    | PuffyDiamond
    | Semicircle
    | Slanted
    | SoftBoom
    | SoftBurst
    | Square
    | Sunny
    | Triangle
    | VerySunny


{-| The name of the shape. (default: `null`) -}
name : Name -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" (nameToString val_)


nameToString : Name -> String
nameToString val_ =
    case val_ of
        V12SidedCookie ->
            "12-sided-cookie"
    
        V4LeafClover ->
            "4-leaf-clover"
    
        V4SidedCookie ->
            "4-sided-cookie"
    
        V6SidedCookie ->
            "6-sided-cookie"
    
        V7SidedCookie ->
            "7-sided-cookie"
    
        V8LeafClover ->
            "8-leaf-clover"
    
        V9SidedCookie ->
            "9-sided-cookie"
    
        Arch ->
            "arch"
    
        Arrow ->
            "arrow"
    
        Boom ->
            "boom"
    
        Bun ->
            "bun"
    
        Burst ->
            "burst"
    
        Circle ->
            "circle"
    
        Diamond ->
            "diamond"
    
        Fan ->
            "fan"
    
        Flower ->
            "flower"
    
        Gem ->
            "gem"
    
        GhostIsh ->
            "ghost-ish"
    
        Heart ->
            "heart"
    
        Hexagon ->
            "hexagon"
    
        Oval ->
            "oval"
    
        Pentagon ->
            "pentagon"
    
        Pill ->
            "pill"
    
        PixelCircle ->
            "pixel-circle"
    
        PixelTriangle ->
            "pixel-triangle"
    
        Puffy ->
            "puffy"
    
        PuffyDiamond ->
            "puffy-diamond"
    
        Semicircle ->
            "semicircle"
    
        Slanted ->
            "slanted"
    
        SoftBoom ->
            "soft-boom"
    
        SoftBurst ->
            "soft-burst"
    
        Square ->
            "square"
    
        Sunny ->
            "sunny"
    
        Triangle ->
            "triangle"
    
        VerySunny ->
            "very-sunny"