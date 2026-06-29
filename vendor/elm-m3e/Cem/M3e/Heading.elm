module Cem.M3e.Heading exposing (component, emphasized, level, size, variant)

{-| A heading to a page or section.

@docs component, emphasized, level, size, variant

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| A heading to a page or section.

**CSS Custom Properties:**

  - `--md-sys-typescale-display-large-font-size`: Font size for Display Large text, ideal for hero headlines
  - `--md-sys-typescale-display-large-font-weight`: Font weight for Display Large text
  - `--md-sys-typescale-display-large-tracking`: Letter spacing for Display Large text
  - `--md-sys-typescale-display-large-line-height`: Line height for Display Large text
  - `--md-sys-typescale-display-medium-font-size`: Font size for Display Medium text
  - `--md-sys-typescale-display-medium-font-weight`: Font weight for Display Medium text
  - `--md-sys-typescale-display-medium-tracking`: Letter spacing for Display Medium text
  - `--md-sys-typescale-display-medium-line-height`: Line height for Display Medium text
  - `--md-sys-typescale-display-small-font-size`: Font size for Display Small text
  - `--md-sys-typescale-display-small-font-weight`: Font weight for Display Small text
  - `--md-sys-typescale-display-small-tracking`: Letter spacing for Display Small text
  - `--md-sys-typescale-display-small-line-height`: Line height for Display Small text
  - `--md-sys-typescale-headline-large-font-size`: Font size for Headline Large text
  - `--md-sys-typescale-headline-large-font-weight`: Font weight for Headline Large text
  - `--md-sys-typescale-headline-large-tracking`: Letter spacing for Headline Large text
  - `--md-sys-typescale-headline-large-line-height`: Line height for Headline Large text
  - `--md-sys-typescale-headline-medium-font-size`: Font size for Headline Medium text
  - `--md-sys-typescale-headline-medium-font-weight`: Font weight for Headline Medium text
  - `--md-sys-typescale-headline-medium-tracking`: Letter spacing for Headline Medium text
  - `--md-sys-typescale-headline-medium-line-height`: Line height for Headline Medium text
  - `--md-sys-typescale-headline-small-font-size`: Font size for Headline Small text
  - `--md-sys-typescale-headline-small-font-weight`: Font weight for Headline Small text
  - `--md-sys-typescale-headline-small-tracking`: Letter spacing for Headline Small text
  - `--md-sys-typescale-headline-small-line-height`: Line height for Headline Small text
  - `--md-sys-typescale-title-large-font-size`: Font size for Title Large text
  - `--md-sys-typescale-title-large-font-weight`: Font weight for Title Large text
  - `--md-sys-typescale-title-large-tracking`: Letter spacing for Title Large text
  - `--md-sys-typescale-title-large-line-height`: Line height for Title Large text
  - `--md-sys-typescale-title-medium-font-size`: Font size for Title Medium text
  - `--md-sys-typescale-title-medium-font-weight`: Font weight for Title Medium text
  - `--md-sys-typescale-title-medium-tracking`: Letter spacing for Title Medium text
  - `--md-sys-typescale-title-medium-line-height`: Line height for Title Medium text
  - `--md-sys-typescale-title-small-font-size`: Font size for Title Small text
  - `--md-sys-typescale-title-small-font-weight`: Font weight for Title Small text
  - `--md-sys-typescale-title-small-tracking`: Letter spacing for Title Small text
  - `--md-sys-typescale-title-small-line-height`: Line height for Title Small text
  - `--md-sys-typescale-label-large-font-size`: Font size for Label Large text
  - `--md-sys-typescale-label-large-font-weight`: Font weight for Label Large text
  - `--md-sys-typescale-label-large-tracking`: Letter spacing for Label Large text
  - `--md-sys-typescale-label-large-line-height`: Line height for Label Large text
  - `--md-sys-typescale-label-medium-font-size`: Font size for Label Medium text
  - `--md-sys-typescale-label-medium-font-weight`: Font weight for Label Medium text
  - `--md-sys-typescale-label-medium-tracking`: Letter spacing for Label Medium text
  - `--md-sys-typescale-label-medium-line-height`: Line height for Label Medium text
  - `--md-sys-typescale-label-small-font-size`: Font size for Label Small text
  - `--md-sys-typescale-label-small-font-weight`: Font weight for Label Small text
  - `--md-sys-typescale-label-small-tracking`: Letter spacing for Label Small text
  - `--md-sys-typescale-label-small-line-height`: Line height for Label Small text
  - `--md-sys-typescale-emphasized-display-large-font-size`: Font size for emphasized Display Large text
  - `--md-sys-typescale-emphasized-display-large-font-weight`: Font weight for emphasized Display Large text
  - `--md-sys-typescale-emphasized-display-large-tracking`: Letter spacing for emphasized Display Large text
  - `--md-sys-typescale-emphasized-display-large-line-height`: Line height for emphasized Display Large text
  - `--md-sys-typescale-emphasized-display-medium-font-size`: Font size for emphasized Display Medium text
  - `--md-sys-typescale-emphasized-display-medium-font-weight`: Font weight for emphasized Display Medium text
  - `--md-sys-typescale-emphasized-display-medium-tracking`: Letter spacing for emphasized Display Medium text
  - `--md-sys-typescale-emphasized-display-medium-line-height`: Line height for emphasized Display Medium text
  - `--md-sys-typescale-emphasized-display-small-font-size`: Font size for emphasized Display Small text
  - `--md-sys-typescale-emphasized-display-small-font-weight`: Font weight for emphasized Display Small text
  - `--md-sys-typescale-emphasized-display-small-tracking`: Letter spacing for emphasized Display Small text
  - `--md-sys-typescale-emphasized-display-small-line-height`: Line height for emphasized Display Small text
  - `--md-sys-typescale-emphasized-headline-large-font-size`: Font size for emphasized Headline Large text
  - `--md-sys-typescale-emphasized-headline-large-font-weight`: Font weight for emphasized Headline Large text
  - `--md-sys-typescale-emphasized-headline-large-tracking`: Letter spacing for emphasized Headline Large text
  - `--md-sys-typescale-emphasized-headline-large-line-height`: Line height for emphasized Headline Large text
  - `--md-sys-typescale-emphasized-headline-medium-font-size`: Font size for emphasized Headline Medium text
  - `--md-sys-typescale-emphasized-headline-medium-font-weight`: Font weight for emphasized Headline Medium text
  - `--md-sys-typescale-emphasized-headline-medium-tracking`: Letter spacing for emphasized Headline Medium text
  - `--md-sys-typescale-emphasized-headline-medium-line-height`: Line height for emphasized Headline Medium text
  - `--md-sys-typescale-emphasized-headline-small-font-size`: Font size for emphasized Headline Small text
  - `--md-sys-typescale-emphasized-headline-small-font-weight`: Font weight for emphasized Headline Small text
  - `--md-sys-typescale-emphasized-headline-small-tracking`: Letter spacing for emphasized Headline Small text
  - `--md-sys-typescale-emphasized-headline-small-line-height`: Line height for emphasized Headline Small text
  - `--md-sys-typescale-emphasized-title-large-font-size`: Font size for emphasized Title Large text
  - `--md-sys-typescale-emphasized-title-large-font-weight`: Font weight for emphasized Title Large text
  - `--md-sys-typescale-emphasized-title-large-tracking`: Letter spacing for emphasized Title Large text
  - `--md-sys-typescale-emphasized-title-large-line-height`: Line height for emphasized Title Large text
  - `--md-sys-typescale-emphasized-title-medium-font-size`: Font size for emphasized Title Medium text
  - `--md-sys-typescale-emphasized-title-medium-font-weight`: Font weight for emphasized Title Medium text
  - `--md-sys-typescale-emphasized-title-medium-tracking`: Letter spacing for emphasized Title Medium text
  - `--md-sys-typescale-emphasized-title-medium-line-height`: Line height for emphasized Title Medium text
  - `--md-sys-typescale-emphasized-title-small-font-size`: Font size for emphasized Title Small text
  - `--md-sys-typescale-emphasized-title-small-font-weight`: Font weight for emphasized Title Small text
  - `--md-sys-typescale-emphasized-title-small-tracking`: Letter spacing for emphasized Title Small text
  - `--md-sys-typescale-emphasized-title-small-line-height`: Line height for emphasized Title Small text
  - `--md-sys-typescale-emphasized-label-large-font-size`: Font size for emphasized Label Large text
  - `--md-sys-typescale-emphasized-label-large-font-weight`: Font weight for emphasized Label Large text
  - `--md-sys-typescale-emphasized-label-large-tracking`: Letter spacing for emphasized Label Large text
  - `--md-sys-typescale-emphasized-label-large-line-height`: Line height for emphasized Label Large text
  - `--md-sys-typescale-emphasized-label-medium-font-size`: Font size for emphasized Label Medium text
  - `--md-sys-typescale-emphasized-label-medium-font-weight`: Font weight for emphasized Label Medium text
  - `--md-sys-typescale-emphasized-label-medium-tracking`: Letter spacing for emphasized Label Medium text
  - `--md-sys-typescale-emphasized-label-medium-line-height`: Line height for emphasized Label Medium text
  - `--md-sys-typescale-emphasized-label-small-font-size`: Font size for emphasized Label Small text
  - `--md-sys-typescale-emphasized-label-small-font-weight`: Font weight for emphasized Label Small text
  - `--md-sys-typescale-emphasized-label-small-tracking`: Letter spacing for emphasized Label Small text
  - `--md-sys-typescale-emphasized-label-small-line-height`: Line height for emphasized Label Small text

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-heading" attributes children


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
emphasized : Bool -> Html.Attribute msg
emphasized val_ =
    Html.Attributes.property "emphasized" (Json.Encode.bool val_)


{-| The accessibility level of the heading.
-}
level : String -> Html.Attribute msg
level val_ =
    Html.Attributes.attribute "level" val_


{-| The size of the heading. (default: `"medium"`)
-}
size :
    Cem.M3e.Common.Value
        { large : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , small : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
size =
    Cem.M3e.Common.size


{-| The appearance variant of the heading. (default: `"display"`)
-}
variant :
    Cem.M3e.Common.Value
        { display : Cem.M3e.Common.Supported
        , headline : Cem.M3e.Common.Supported
        , label : Cem.M3e.Common.Supported
        , title : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant
