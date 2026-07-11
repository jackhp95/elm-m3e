module M3e.BottomSheet exposing
    ( view, detent, detents, handle, handleLabel, hideable
    , hideFriction, modal, open, overshootLimit, onOpening, onClosing
    , onCancel, onOpened, onClosed, header
    )

{-| A sheet used to show secondary content anchored to the bottom of the screen.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `opening`: Dispatched when the sheet begins to open.
  - `closing`: Dispatched when the sheet begins to close.
  - `cancel`: Dispatched when the sheet is cancelled.
  - `opened`: Dispatched when the sheet has opened.
  - `closed`: Dispatched when the sheet has closed.

**Slots:**

  - `header`: Renders the header of the sheet.

<!-- elm-cem:docmeta category=Containment -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet" ] [ Kit.text "Open bottom sheet" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet" ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet2" ] [ Kit.text "Open modal bottom sheet" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet2", M3e.BottomSheet.modal True ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Drag handles" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet3" ] [ Kit.text "Open draggable modal bottom sheet" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet3", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Detents" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet4" ] [ Kit.text "Open draggable modal bottom sheet with detents" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet4", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.detents "fit half full" ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Initial height" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet7" ] [ Kit.text "Open draggable modal bottom sheet with detents at half" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet7", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.detents "fit half full", M3e.BottomSheet.detent 1 ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Initial height (2)" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet8", M3e.BottomSheetTrigger.detent 1 ] [ Kit.text "Open draggable modal bottom sheet with detents at half via trigger" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet8", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.detents "fit half full" ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Collapsed height" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet9" ] [ Kit.text "Open draggable modal bottom sheet with detents at collapsed with custom peek" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet9", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.detents "collapsed fit half full", M3e.Attributes.style [ ( "--m3e-bottom-sheet-peek-height", "36px" ) ] ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Hideability" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet5" ] [ Kit.text "Open hideable modal bottom sheet" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet5", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.hideable True ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Hideability (2)" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet6" ] [ Kit.text "Open hideable modal bottom sheet with detents" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet6", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.hideable True, M3e.BottomSheet.detents "fit half full" ] [ M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Headers" -->
```elm
[ M3e.Button.view [] [ M3e.BottomSheetTrigger.view [ M3e.BottomSheetTrigger.for "bottomSheet10" ] [ Kit.text "Open hideable modal bottom sheet with detents and header" ] ]
    , M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet10", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.hideable True, M3e.BottomSheet.detents "collapsed fit half full", M3e.Aria.labelledby "sheetTitle" ] [ M3e.BottomSheet.header (M3e.Heading.view [ M3e.Attributes.id "sheetTitle", M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.large ] [ Kit.text "Choose a destination" ]), M3e.ActionList.view [] [ M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Keep" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Add to a note" ]) ], M3e.ListAction.view [] [ M3e.BottomSheetAction.view [] [ Kit.text "Google Docs" ], M3e.ListAction.supportingText (Native.span [] [ Kit.text "Embed in a document" ]) ] ] ]
    ]
```

<!-- elm-cem:example title="Choose a destination" -->
```elm
M3e.BottomSheet.view [ M3e.Attributes.id "bottomSheet", M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.hideable True, M3e.BottomSheet.detents "collapsed fit half full" ] [ M3e.BottomSheet.header (M3e.Heading.view [ M3e.Attributes.id "sheetTitle", M3e.Heading.variant M3e.Token.title, M3e.Heading.size M3e.Token.large ] [ Kit.text "Choose a destination" ]) ]
```

@docs view, detent, detents, handle, handleLabel, hideable
@docs hideFriction, modal, open, overshootLimit, onOpening, onClosing
@docs onCancel, onOpened, onClosed, header

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.BottomSheet
import M3e.Node
import M3e.Token


{-| Build the `<m3e-bottom-sheet>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , detents : M3e.Token.Supported
            , handle : M3e.Token.Supported
            , handleLabel : M3e.Token.Supported
            , hideable : M3e.Token.Supported
            , hideFriction : M3e.Token.Supported
            , modal : M3e.Token.Supported
            , open : M3e.Token.Supported
            , overshootLimit : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onCancel : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | bottomSheet : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.BottomSheet.bottomSheet
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The zero‑based index of the detent the sheet should open to. (default: `0`)
-}
detent : Float -> M3e.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
detent =
    M3e.Html.BottomSheet.detent


{-| Detents (discrete height states) the sheet can snap to. (default: `[]`)
-}
detents : String -> M3e.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
detents =
    M3e.Html.BottomSheet.detents


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> M3e.Html.Attr.Attr { c | handle : M3e.Token.Supported } msg
handle =
    M3e.Html.BottomSheet.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
handleLabel : String -> M3e.Html.Attr.Attr { c | handleLabel : M3e.Token.Supported } msg
handleLabel =
    M3e.Html.BottomSheet.handleLabel


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
hideable : Bool -> M3e.Html.Attr.Attr { c | hideable : M3e.Token.Supported } msg
hideable =
    M3e.Html.BottomSheet.hideable


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
hideFriction : Float -> M3e.Html.Attr.Attr { c | hideFriction : M3e.Token.Supported } msg
hideFriction =
    M3e.Html.BottomSheet.hideFriction


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
modal : Bool -> M3e.Html.Attr.Attr { c | modal : M3e.Token.Supported } msg
modal =
    M3e.Html.BottomSheet.modal


{-| Whether the bottom sheet is open. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.BottomSheet.open


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit : Float -> M3e.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
overshootLimit =
    M3e.Html.BottomSheet.overshootLimit


{-| Listen for `opening` events.
-}
onOpening : msg -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.BottomSheet.onOpening


{-| Listen for `closing` events.
-}
onClosing : msg -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.BottomSheet.onClosing


{-| Listen for `cancel` events.
-}
onCancel : msg -> M3e.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel =
    M3e.Html.BottomSheet.onCancel


{-| Listen for `opened` events.
-}
onOpened : msg -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.BottomSheet.onOpened


{-| Listen for `closed` events.
-}
onClosed : msg -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.BottomSheet.onClosed


{-| Place content in the `header` slot.
-}
header : M3e.Element.Element any msg -> M3e.Element.Element k msg
header el =
    M3e.Element.Internal.placeSlot "header" el
