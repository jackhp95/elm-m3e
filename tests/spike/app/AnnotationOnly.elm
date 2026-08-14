module AnnotationOnly exposing (buttonList)

{-| Slim-import property, post `el`-unification: naming a component's phantom
`Is` type needs only that ONE component-module import — no separate "skin"
module. (Pre-unification this exercised the slim `M3e.Build` annotation-only
alias skin, distinct from the full component/builder modules; that skin was
deleted along with `M3e.Build.*` — the property it demonstrated is now just
"the component module IS already minimal", so a plain `M3e.Component.Button`
import suffices.)

-}

import HtmlIr.Element exposing (Element)
import M3e.Component.Button exposing (Is)


buttonList : List (Element (Is s) admittedBy msg)
buttonList =
    []
