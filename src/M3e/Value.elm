module M3e.Value exposing
    ( Value, toString
    , extraSmall, small, medium, large, extraLarge
    )

{-| Shared, phantom-tagged enum values for the M3e component library.

A `Value` is an opaque token carrying the string a component emits (e.g.
`"small"`), tagged at the type level with an **open row** advertising which
member it is. Each component publishes a **closed** supported-row for its
`variant` / `size` / `shape` field; row unification then accepts the members a
component supports and rejects everything else at compile time.

    import M3e.Value as Value
    import M3e.Button as Button
    import M3e.Fab as Fab


    -- The SAME value is valid for Button AND Fab (both support `large`):
    Button.view { label = "Save", variant = Button.Filled }
        [ Button.size Value.large ]

    Fab.view { icon = "add", ariaLabel = "Add" }
        [ Fab.size Value.large ]

The single `Value` type spans the variant / size / shape axes deliberately: a
member is admitted purely by which component **field** it is passed to (each
field carries its own closed row), so the same token name never needs an
axis-specific spelling and cross-axis names (e.g. `rounded`) cannot collide.


## Type

@docs Value, toString


## Sizes

@docs extraSmall, small, medium, large, extraLarge

-}

import M3e.Element exposing (Supported)


{-| An opaque, phantom-tagged enum value. The `tags` row records which members
this value satisfies; it has no runtime representation beyond the carried
string.
-}
type Value tags
    = Value String


{-| The string a component emits for this value (e.g. `Value.toString small`
is `"small"`). Used internally by component `view` functions.
-}
toString : Value tags -> String
toString (Value s) =
    s


{-| The smallest size step. Emits `"extra-small"`.
-}
extraSmall : Value { a | extraSmall : Supported }
extraSmall =
    Value "extra-small"


{-| A small size. Emits `"small"`.
-}
small : Value { a | small : Supported }
small =
    Value "small"


{-| A medium size. Emits `"medium"`.
-}
medium : Value { a | medium : Supported }
medium =
    Value "medium"


{-| A large size. Emits `"large"`.
-}
large : Value { a | large : Supported }
large =
    Value "large"


{-| The largest size step. Emits `"extra-large"`.
-}
extraLarge : Value { a | extraLarge : Supported }
extraLarge =
    Value "extra-large"
