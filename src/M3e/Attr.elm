module M3e.Attr exposing
    ( disabled, onClick
    , href, target, rel, download
    , id
    , size, sizeExtraSmall, sizeSmall, sizeMedium, sizeLarge, sizeExtraLarge
    )

{-| Universal, polymorphic attribute builders for the M3e component library.

Each function here is a **single** definition that unifies with _any_ component
whose `Config` has the matching field name and type via Elm's extensible-record
row-polymorphism.

    import M3e.Attr as Attr
    import M3e.Button as Button
    import M3e.Checkbox as Checkbox
    import M3e.Value as Value


    -- The SAME value is valid for Button AND Checkbox:
    isDisabled : Bool
    isDisabled =
        True

    buttonNode =
        Button.view { label = "Save", variant = Value.filled }
            [ Attr.disabled isDisabled, Attr.onClick Saved ]

    checkboxNode =
        Checkbox.view { ariaLabel = "Accept terms" }
            [ Attr.disabled isDisabled ]

Components keep their own concrete `Option msg` type aliases and re-delegate
their trivial option helpers here, so existing call sites continue to compile
unchanged.


## Interactivity

@docs disabled, onClick


## Link attributes

@docs href, target, rel, download


## Identity

@docs id


## Size axis

The `size` axis is set explicitly: pass a shared [`M3e.Value`](M3e-Value) token
(`Attr.size Value.medium`) or use a combined shorthand (`Attr.sizeMedium`). A
bare value alone cannot assert the axis — the builder is what names it. Each
component publishes a closed supported-row, so a size it does not offer is a
compile error.

@docs size, sizeExtraSmall, sizeSmall, sizeMedium, sizeLarge, sizeExtraLarge

-}

import M3e.Element exposing (Supported)
import M3e.Internal as Internal exposing (Option)
import M3e.Value as Value exposing (AxisSupports, Value)


{-| Disable a component. Sets the `disabled : Bool` field in the Config.

Compatible with any component whose `Config` row contains `disabled : Bool`:
Button, Checkbox, Chip, ExtendedFab, Fab, IconButton, Paginator, RadioButton,
Select, Slide (slideGroup), Slider, SplitButton, SplitPane, Switch,
TextHighlight, TextField, TimePicker, and the item / section / step / tab
variants in Autocomplete, Breadcrumb, Disclosure, List, Menu, NavigationBar,
NavigationRail, Stepper, Tabs, and Tree.

Note: `M3e.SegmentedButton.disabled` and `M3e.SegmentedButton.segmentDisabled`
use a custom ADT (`ParentOption` / `SegmentOption`), not `Internal.Option`, so
they cannot accept this builder.

-}
disabled : Bool -> Option { c | disabled : Bool } msg
disabled v =
    Internal.option (\c -> { c | disabled = v })


{-| Wire a click handler. Sets `onClick : Maybe msg` in the Config.

Compatible with any component whose `Config` row contains `onClick : Maybe msg`:
Button, Chip, ExtendedFab, Fab, IconButton, and the item / tab / action variants
in Breadcrumb, List, NavigationBar, NavigationRail, Tabs, and Tree.

-}
onClick : msg -> Option { c | onClick : Maybe msg } msg
onClick m =
    Internal.option (\c -> { c | onClick = Just m })


{-| Render as a link to the given URL. Sets `href : Maybe String` in the Config.

Compatible with any component whose `Config` row contains `href : Maybe String`:
Button, Card, Chip, ExtendedFab, Fab, IconButton, and item variants in
Breadcrumb, List, NavigationBar, and NavigationRail.

-}
href : String -> Option { c | href : Maybe String } msg
href v =
    Internal.option (\c -> { c | href = Just v })


{-| Set the link target (e.g. `"_blank"`). Sets `target : Maybe String` in the Config.

Only meaningful alongside [`href`](#href). Compatible with any component whose
`Config` row contains `target : Maybe String`: Button, Card, ExtendedFab, Fab,
IconButton, and link / item variants in Breadcrumb, List, and NavigationDrawer.

-}
target : String -> Option { c | target : Maybe String } msg
target v =
    Internal.option (\c -> { c | target = Just v })


{-| Set the link rel (e.g. `"noreferrer noopener"`). Sets `rel : Maybe String` in the Config.

Only meaningful alongside [`href`](#href). Compatible with any component whose
`Config` row contains `rel : Maybe String`: Button, Card, ExtendedFab, Fab,
IconButton, and item variants in Breadcrumb and List.

-}
rel : String -> Option { c | rel : Maybe String } msg
rel v =
    Internal.option (\c -> { c | rel = Just v })


{-| Request the link target be downloaded. Sets `download : Maybe String` in the Config.

Only meaningful alongside [`href`](#href). Compatible with any component whose
`Config` row contains `download : Maybe String`: Button, Card, ExtendedFab, Fab,
IconButton, and item variants in Breadcrumb and List.

-}
download : String -> Option { c | download : Maybe String } msg
download v =
    Internal.option (\c -> { c | download = Just v })


{-| Set the element id. Sets `id : Maybe String` in the Config.

Compatible with any component whose `Config` row contains `id : Maybe String`:
AppBar, Calendar, DatePicker, List, Menu, NavigationBar, NavigationDrawer,
NavigationRail, Select, Snackbar, TextField, TimePicker, and the step / panel
variants in Stepper and Tabs.

-}
id : String -> Option { c | id : Maybe String } msg
id v =
    Internal.option (\c -> { c | id = Just v })


{-| Set the `size` axis to a shared [`M3e.Value`](M3e-Value) token. Sets the
`size : AxisSupports values` field in the Config.

Compatible with any component whose `Config` has a `size : AxisSupports values`
field: AppBar, Button, ButtonGroup, ExtendedFab, Fab, Heading, IconButton, and
SplitButton. The token's row must be one the component lists, so passing a size
it does not support is a compile error.

    Button.view { label = "Save", variant = Value.filled }
        [ Attr.size Value.large ]

-}
size : Value values -> Option { c | size : AxisSupports values } msg
size v =
    Internal.option (\c -> { c | size = Value.toAxis v })


{-| `size Value.extraSmall` — the combined `extra-small` shorthand.
-}
sizeExtraSmall : Option { c | size : AxisSupports { v | extraSmall : Supported } } msg
sizeExtraSmall =
    size Value.extraSmall


{-| `size Value.small` — the combined `small` shorthand.
-}
sizeSmall : Option { c | size : AxisSupports { v | small : Supported } } msg
sizeSmall =
    size Value.small


{-| `size Value.medium` — the combined `medium` shorthand.
-}
sizeMedium : Option { c | size : AxisSupports { v | medium : Supported } } msg
sizeMedium =
    size Value.medium


{-| `size Value.large` — the combined `large` shorthand.
-}
sizeLarge : Option { c | size : AxisSupports { v | large : Supported } } msg
sizeLarge =
    size Value.large


{-| `size Value.extraLarge` — the combined `extra-large` shorthand.
-}
sizeExtraLarge : Option { c | size : AxisSupports { v | extraLarge : Supported } } msg
sizeExtraLarge =
    size Value.extraLarge
