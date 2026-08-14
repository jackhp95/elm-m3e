module M3e.Internal.Types.Stepper exposing (..)

{-| Internal type definitions for Stepper — unexposed so docs.json
shows short qualified references instead of expanded record rows.
-}

import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Kind exposing (Available, Brand, Ctx, Used)


type alias Is s =
    { s | stepper : Brand }


type alias Attrs =
    { class : Supported
    , headerPosition : Supported
    , id : Supported
    , labelPosition : Supported
    , linear : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , orientation : Supported
    , slot : Supported
    , style : Supported
    }


type alias PanelSlot =
    { stepPanel : Brand }


type alias StepSlot =
    { step : Brand }


type alias ChildAdmittedBy childAdm =
    { childAdm | stepper : Ctx }


type alias HeaderPosition =
    { above : Supported
    , below : Supported
    }


type alias LabelPosition =
    { below : Supported
    , end : Supported
    }


type alias Orientation =
    { auto : Supported
    , horizontal : Supported
    , vertical : Supported
    }
