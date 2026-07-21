module Kit.Surface exposing
    ( Surface, view, asAttribute, outlined
    , surface, surfaceContainer, surfaceContainerHigh, inverseSurface
    , primary, primaryContainer, secondary, secondaryContainer
    , tertiary, tertiaryContainer, error, errorContainer
    )

{-| M3 **surface roles** — the visual seam for background + paired on-color.

A `Surface` bundles a `bg-*` role with its matching `text-on-*` color, so route
code paints an M3 surface by naming the role (`Kit.Surface.primary`) instead of
writing `bg-primary text-on-primary` through the seam. This is the sanctioned
home for those classes (see `Kit`).

@docs Surface, view, asAttribute, outlined
@docs surface, surfaceContainer, surfaceContainerHigh, inverseSurface
@docs primary, primaryContainer, secondary, secondaryContainer
@docs tertiary, tertiaryContainer, error, errorContainer

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Kind
import Native
import Seam


{-| An M3 surface role: a `bg-*` background paired with its `text-on-*` color.
-}
type Surface
    = Surface { bg : String, on : String }


{-| Paint a `<div>` with the surface role's background + on-color. Extra `attrs`
(layout, shape, `dir`, …) compose onto the same element so the background fills it.
-}
view : Surface -> List (Attr c msg) -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
view (Surface roles) attrs kids =
    Native.div
        (Seam.asAttribute (Html.Attributes.class (roles.bg ++ " " ++ roles.on)) :: attrs)
        kids


{-| Paint the surface role's background + on-color onto an existing element via
its attribute list, instead of wrapping it in a `<div>`. Use this when the target
already exists and must keep its own kind (e.g. painting a selected `ListItem`
without demoting it to an `html` wrapper the parent list would ignore).
-}
asAttribute : Surface -> Attr c msg
asAttribute (Surface roles) =
    Seam.asAttribute (Html.Attributes.class (roles.bg ++ " " ++ roles.on))


outlined : Attr c msg
outlined =
    Seam.asAttribute (Html.Attributes.class "border border-outline-variant")


{-| `bg-surface` / `text-on-surface` — the base app surface.
-}
surface : Surface
surface =
    Surface { bg = "bg-surface", on = "text-on-surface" }


{-| `bg-surface-container` / `text-on-surface`.
-}
surfaceContainer : Surface
surfaceContainer =
    Surface { bg = "bg-surface-container", on = "text-on-surface" }


{-| `bg-surface-container-high` / `text-on-surface`.
-}
surfaceContainerHigh : Surface
surfaceContainerHigh =
    Surface { bg = "bg-surface-container-high", on = "text-on-surface" }


{-| `bg-inverse-surface` / `text-inverse-on-surface`.
-}
inverseSurface : Surface
inverseSurface =
    Surface { bg = "bg-inverse-surface", on = "text-inverse-on-surface" }


{-| `bg-primary` / `text-on-primary`.
-}
primary : Surface
primary =
    Surface { bg = "bg-primary", on = "text-on-primary" }


{-| `bg-primary-container` / `text-on-primary-container`.
-}
primaryContainer : Surface
primaryContainer =
    Surface { bg = "bg-primary-container", on = "text-on-primary-container" }


{-| `bg-secondary` / `text-on-secondary`.
-}
secondary : Surface
secondary =
    Surface { bg = "bg-secondary", on = "text-on-secondary" }


{-| `bg-secondary-container` / `text-on-secondary-container`.
-}
secondaryContainer : Surface
secondaryContainer =
    Surface { bg = "bg-secondary-container", on = "text-on-secondary-container" }


{-| `bg-tertiary` / `text-on-tertiary`.
-}
tertiary : Surface
tertiary =
    Surface { bg = "bg-tertiary", on = "text-on-tertiary" }


{-| `bg-tertiary-container` / `text-on-tertiary-container`.
-}
tertiaryContainer : Surface
tertiaryContainer =
    Surface { bg = "bg-tertiary-container", on = "text-on-tertiary-container" }


{-| `bg-error` / `text-on-error`.
-}
error : Surface
error =
    Surface { bg = "bg-error", on = "text-on-error" }


{-| `bg-error-container` / `text-on-error-container`.
-}
errorContainer : Surface
errorContainer =
    Surface { bg = "bg-error-container", on = "text-on-error-container" }
