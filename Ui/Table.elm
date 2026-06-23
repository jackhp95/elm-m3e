module Ui.Table exposing
    ( TableDefinition
    , table, view
    , Column
    , colHeader, colHeaderCustom
    , colWithAlignment, colWithCustomHeaderStyles, colWithSort
    , SortDefinition, SortIcon(..)
    , Alignment(..)
    , Row
    , row, rowIdentified, rowWithCustomStyles
    , withRows, withRemoteDataRows
    , Cell
    , cell, cellCustom, cellWithCustomStyles
    , withEmptyView, withDenseSpacing, withStickyHeader, withStripedRows
    , CheckboxSelection, withCheckboxes
    , withCustomComponentStyles, withCustomTableStyles
    , withCustomHeadStyles, withCustomHeadRowStyles, withCustomBodyStyles
    )

{-| A data table component for displaying rows and columns of structured data.

Tables are built with a builder pattern: start with `table`, configure columns,
add rows, apply display options, then render with `view`.

    table
        [ colHeader TranslateHtml.name
        , colHeader TranslateHtml.status
        ]
        |> withRows
            [ row [ cell (text "Acme Corp"), cell TranslateHtml.active ]
            , row [ cell (text "Globex"), cell TranslateHtml.pending ]
            ]
        |> view


# Core

@docs TableDefinition
@docs table, view


# Columns

@docs Column
@docs colHeader, colHeaderCustom
@docs colWithAlignment, colWithCustomHeaderStyles, colWithSort


## Sort

@docs SortDefinition, SortIcon


## Alignment

@docs Alignment


# Rows

@docs Row
@docs row, rowIdentified, rowWithCustomStyles
@docs withRows, withRemoteDataRows


# Cells

@docs Cell
@docs cell, cellCustom, cellWithCustomStyles


# Table Options

@docs withEmptyView, withDenseSpacing, withStickyHeader, withStripedRows


## Checkboxes

@docs CheckboxSelection, withCheckboxes


## Custom Styles

@docs withCustomComponentStyles, withCustomTableStyles
@docs withCustomHeadStyles, withCustomHeadRowStyles, withCustomBodyStyles

-}

import Api
import Api.Error
import EverySet exposing (EverySet)
import Html exposing (Html)
import Html.Attributes as Attr exposing (class, classList)
import Html.Events as HtmlEvents
import Html.Extra
import Icon
import Icon.FontAwesome as FA
import Json.Encode as Encode
import List.Extra
import Maybe.Extra
import Mercury.Checkbox as Checkbox
import RemoteData exposing (RemoteData)
import TranslateHtml
import Utils.QA
import Views.Spinners as Spinners


{-| An opaque type representing the full configuration of a table, including
its columns, rows, and display options.

Build a `TableDefinition` with `table` and render it with `view`.

This is a view type and should never be stored inside State.

-}
type TableDefinition msg rowId
    = TableDefinition_Internal
        { columns : List (Column msg)
        , rows : List (Row msg rowId)
        , emptyView : Html msg
        , spacing : RowSpacing
        , stickyHeader : Bool
        , striped : Bool
        , checkboxes : Maybe (CheckboxSelection msg rowId)
        , customComponentStyles : List (Html.Attribute msg)
        , customTableStyles : List (Html.Attribute msg)
        , customHeadStyles : List (Html.Attribute msg)
        , customHeadRowStyles : List (Html.Attribute msg)
        , customBodyStyles : List (Html.Attribute msg)
        }


{-| Create a `TableDefinition` with the given columns.

    table
        [ colHeader TranslateHtml.name
        , colHeader TranslateHtml.email
        ]

Use the `with*` functions to add rows and configure display options, then
render with `view`.

-}
table : List (Column msg) -> TableDefinition msg rowId
table columns =
    TableDefinition_Internal
        { columns = columns
        , rows = []
        , emptyView = TranslateHtml.thereAreNoItemsToDisplay
        , spacing = Normal
        , stickyHeader = False
        , striped = False
        , checkboxes = Nothing
        , customComponentStyles = []
        , customTableStyles = []
        , customHeadStyles = []
        , customHeadRowStyles = []
        , customBodyStyles = []
        }


{-| Render a `TableDefinition` to HTML.

    table [ colHeader TranslateHtml.name ]
        |> withRows [ row [ cell (text "Acme Corp") ] ]
        |> view

-}
view : TableDefinition msg rowId -> Html msg
view (TableDefinition_Internal tableDef) =
    Html.div
        (classList
            [ ( "component-data-table", True )
            , ( "striped", tableDef.striped )
            , ( "dense", tableDef.spacing == Dense )
            , ( "fixed-header", tableDef.stickyHeader )
            ]
            :: tableDef.customComponentStyles
        )
        [ Html.table (class "data-table-table" :: tableDef.customTableStyles)
            [ Html.thead (class "data-table-head" :: tableDef.customHeadStyles)
                [ Html.tr (class "data-table-row" :: tableDef.customHeadRowStyles)
                    (selectAllCheckboxView (TableDefinition_Internal tableDef)
                        ++ List.indexedMap renderColumn tableDef.columns
                    )
                ]
            , Html.tbody (class "data-table-body" :: tableDef.customBodyStyles)
                (if List.isEmpty tableDef.rows then
                    [ Html.tr [ class "data-table-row" ]
                        [ Html.td
                            [ class "data-table-cell table-empty"
                            , Attr.colspan
                                (List.length tableDef.columns
                                    + (if Maybe.Extra.isJust tableDef.checkboxes then
                                        1

                                       else
                                        0
                                      )
                                )
                            ]
                            [ tableDef.emptyView ]
                        ]
                    ]

                 else
                    List.map (renderRow (TableDefinition_Internal tableDef)) tableDef.rows
                )
            ]
        ]



--Columns


{-| An opaque type representing a single table column, including its header
content, alignment, optional sort behavior, and any custom header styles.

Create columns with `colHeader` or `colHeaderCustom`, then modify them with
`colWithAlignment`, `colWithSort`, and `colWithCustomHeaderStyles`.

This is a view type and should never be stored inside State.

-}
type Column msg
    = Column
        { headerContent : List (Html msg)
        , headerCustomStyles : List (Html.Attribute msg)
        , alignment : Alignment
        , sort : Maybe (SortDefinition msg)
        }


renderColumn : Int -> Column msg -> Html msg
renderColumn index (Column col) =
    let
        content =
            case col.sort of
                Nothing ->
                    col.headerContent

                Just (SortDefinition sort) ->
                    let
                        sortIcon =
                            case sort.sortIcon of
                                ActiveSortAscending ->
                                    Icon.element (Icon.solid FA.arrowDown) [] []

                                ActiveSortDescending ->
                                    Icon.element (Icon.solid FA.arrowUp) [] []

                                InactiveSort ->
                                    Icon.element (Icon.solid FA.arrowDown) [ class "tw-opacity-30" ] []
                    in
                    [ Html.button
                        [ class "tw-flex tw-gap-2 tw-items-center"
                        , Attr.type_ "button"
                        , Utils.QA.testId ("table-column-" ++ String.fromInt index ++ "-clicked")
                        , HtmlEvents.onClick sort.toggleSortMsg
                        ]
                        [ Html.span [] col.headerContent, sortIcon ]
                    ]
    in
    Html.th
        (class "data-table-header-cell"
            :: alignmentToAttr col.alignment
            :: col.headerCustomStyles
        )
        content


{-| Create a column with a single HTML node as its header.

    colHeader TranslateHtml.supplierName

For more control over header attributes and content, use `colHeaderCustom`.

-}
colHeader : Html msg -> Column msg
colHeader content =
    Column
        { headerContent = [ content ]
        , headerCustomStyles = []
        , alignment = AlignStart
        , sort = Nothing
        }


{-| Create a column with custom attributes and a list of HTML nodes as its header.

Generally, even if multiple items are needed in a header cell, it is preferred to use `colHeader` with a div or span inside rather than this function.

    colHeaderCustom [ class "tw-w-32" ] [ icon, TranslateHtml.actions ]

-}
colHeaderCustom : List (Html.Attribute msg) -> List (Html msg) -> Column msg
colHeaderCustom attrs content =
    Column
        { headerContent = content
        , headerCustomStyles = attrs
        , alignment = AlignStart
        , sort = Nothing
        }


{-| Add header cell attributes to a column.

    colHeader TranslateHtml.name
        |> colWithCustomHeaderStyles [ class "tw-text-lg" ]

-}
colWithCustomHeaderStyles : List (Html.Attribute msg) -> Column msg -> Column msg
colWithCustomHeaderStyles attrs (Column col) =
    Column { col | headerCustomStyles = attrs }


{-| Set the text and content alignment for a column.

    colHeader TranslateHtml.amount
        |> colWithAlignment AlignEnd

-}
colWithAlignment : Alignment -> Column msg -> Column msg
colWithAlignment alignment (Column col) =
    Column { col | alignment = alignment }


{-| Horizontal alignment for column header and cell content.

  - `AlignStart` — left-aligned (default)
  - `AlignCenter` — center-aligned
  - `AlignEnd` — right-aligned

-}
type Alignment
    = AlignStart
    | AlignCenter
    | AlignEnd


alignmentToAttr : Alignment -> Html.Attribute msg
alignmentToAttr alignment =
    case alignment of
        AlignStart ->
            class "ds-text-start ds-justify-items-start"

        AlignCenter ->
            class "ds-text-center ds-justify-items-center"

        AlignEnd ->
            class "ds-text-end ds-justify-items-end"


{-| Add sort controls to a column header.

The column renders a clickable button with a sort icon. Pass the current
`SortIcon` state and the msg to dispatch when the user clicks to toggle
the sorted column and direction.

    colHeader TranslateHtml.name
        |> colWithSort
            { sortIcon = ActiveSortAscending
            , toggleSortMsg = PageSpecificMsg.UserClickedNameSort
            }

-}
colWithSort :
    { sortIcon : SortIcon
    , toggleSortMsg : msg
    }
    -> Column msg
    -> Column msg
colWithSort sortDef (Column col) =
    Column { col | sort = Just (SortDefinition sortDef) }


{-| An opaque type holding the sort configuration for a column: which icon
to display and the message to dispatch when the header is clicked.

Attach a `SortDefinition` to a column with `colWithSort`.

This is a view type and should never be stored inside State.

-}
type SortDefinition msg
    = SortDefinition
        { sortIcon : SortIcon
        , toggleSortMsg : msg
        }


{-| The visual state of a sortable column header icon.

  - `ActiveSortAscending` — column is being actively sorted, ordered ascending (↓)
  - `ActiveSortDescending` — column is being actively sorted, ordered descending (↑)
  - `InactiveSort` — column is sortable but not the currently sorted column (↕)

-}
type SortIcon
    = ActiveSortAscending
    | ActiveSortDescending
    | InactiveSort



--Rows


{-| An opaque type representing a table row, containing its cells, an optional
row ID for checkbox selection, and any custom styles.

Create rows with `row` or `rowIdentified`.

This is a view type and should never be stored inside State.

-}
type Row msg rowId
    = Row
        { rowId : Maybe rowId
        , cells : List (Cell msg)
        , customStyles : List (Html.Attribute msg)
        }


renderRow : TableDefinition msg rowId -> Row msg rowId -> Html msg
renderRow (TableDefinition_Internal tableDef) (Row tableRow) =
    let
        renderRowCell index (CustomCell attrs content) =
            let
                alignmentAttrs =
                    tableDef.columns
                        |> List.Extra.getAt index
                        |> Maybe.map (\(Column { alignment }) -> [ alignmentToAttr alignment ])
                        |> Maybe.withDefault []
            in
            Html.td (class "data-table-cell" :: (alignmentAttrs ++ attrs)) content

        ( rowCheckbox, isSelected ) =
            case ( tableRow.rowId, tableDef.checkboxes ) of
                ( Just rowId, Just (CheckboxSelection { selectRowMsg, rowsSelected }) ) ->
                    let
                        rowIsSelected =
                            EverySet.member rowId rowsSelected
                    in
                    ( [ Html.td [ class "data-table-cell tw-w-0" ]
                            [ checkboxView
                                { checkMsg = selectRowMsg rowId
                                , isChecked = rowIsSelected
                                , isIndeterminate = False
                                }
                            ]
                      ]
                    , rowIsSelected
                    )

                _ ->
                    ( [], False )
    in
    Html.tr (classList [ ( "data-table-row", True ), ( "selected", isSelected ) ] :: tableRow.customStyles)
        (rowCheckbox ++ List.indexedMap renderRowCell tableRow.cells)


{-| Create a row without an ID.

Use this when you do not need checkbox selection. For rows that can be
selected via checkboxes, use `rowIdentified` instead.

    row
        [ cell (text "Acme Corp")
        , cell TranslateHtml.active
        ]

-}
row : List (Cell msg) -> Row msg Never
row cells =
    Row { rowId = Nothing, cells = cells, customStyles = [] }


{-| Create a row with an ID, enabling checkbox selection.

The `rowId` is used by `withCheckboxes` to track which rows are selected.
The type of `rowId` should generally be a Types.Id type.

    rowIdentified supplier.id
        [ cell (text supplier.name)
        , cell (text supplier.status)
        ]

-}
rowIdentified : rowId -> List (Cell msg) -> Row msg rowId
rowIdentified rowId cells =
    Row { rowId = Just rowId, cells = cells, customStyles = [] }


{-| Add custom HTML attributes to a row element.

    rowIdentified supplier.id [ cell (text supplier.name) ]
        |> rowWithCustomStyles [ class "tw-opacity-50" ]

-}
rowWithCustomStyles : List (Html.Attribute msg) -> Row msg rowId -> Row msg rowId
rowWithCustomStyles attrs (Row r) =
    Row { r | customStyles = r.customStyles ++ attrs }


{-| Add a list of rows to a `TableDefinition`.

    table [ colHeader TranslateHtml.name ]
        |> withRows
            [ row [ cell (text "Acme Corp") ]
            , row [ cell (text "Globex") ]
            ]

-}
withRows : List (Row msg rowId) -> TableDefinition msg rowId -> TableDefinition msg rowId
withRows rows (TableDefinition_Internal tableDef) =
    TableDefinition_Internal { tableDef | rows = tableDef.rows ++ rows }


{-| Populate table rows from a `RemoteData` value.

  - `NotAsked` — renders an empty table body with no empty-state message
  - `Loading` — renders a loading spinner in the empty-state cell
  - `Failure` — renders an error view in the empty-state cell
  - `Success` — populates the table with the given rows via `withRows`

This is the recommended way to connect a table to an API response.

    table [ colHeader TranslateHtml.name ]
        |> withRemoteDataRows
            (RemoteData.map
                (List.map (\s -> row [ cell (text s.name) ]))
                model.suppliers
            )
        |> view

-}
withRemoteDataRows : RemoteData Api.Error (List (Row msg rowId)) -> TableDefinition msg rowId -> TableDefinition msg rowId
withRemoteDataRows remoteData tableDef =
    case remoteData of
        RemoteData.NotAsked ->
            tableDef
                |> withEmptyView Html.Extra.nothing

        RemoteData.Loading ->
            tableDef
                |> withEmptyView
                    (Html.div []
                        [ Spinners.loadingSpinner ]
                    )

        RemoteData.Failure error ->
            tableDef
                |> withEmptyView
                    (Api.Error.view error)

        RemoteData.Success data ->
            tableDef |> withRows data



-- Cells


{-| An opaque type representing a single table cell, containing HTML content
and optional custom attributes.

Create cells with `cell` or `cellCustom`, and modify them with
`cellWithCustomStyles`.

This is a view type and should never be stored inside State.

-}
type Cell msg
    = CustomCell (List (Html.Attribute msg)) (List (Html msg))


{-| Create a cell containing a single HTML node.

    cell (text "Acme Corp")

For multiple nodes or custom attributes, use `cellCustom`.

-}
cell : Html msg -> Cell msg
cell content =
    CustomCell [] [ content ]


{-| Add custom HTML attributes to an existing cell.

    cell (text "Acme Corp")
        |> cellWithCustomStyles [ class "tw-font-bold" ]

-}
cellWithCustomStyles : List (Html.Attribute msg) -> Cell msg -> Cell msg
cellWithCustomStyles moreAttrs (CustomCell attrs content) =
    CustomCell (attrs ++ moreAttrs) content


{-| Create a cell with custom attributes and a list of HTML nodes.

Generally, even if multiple items are needed in a cell, it is preferred to use `cell` with a div or span inside rather than this function.

    cellCustom [ class "tw-text-right" ]
        [ icon
        , text (String.fromFloat amount)
        ]

-}
cellCustom : List (Html.Attribute msg) -> List (Html msg) -> Cell msg
cellCustom attrs content =
    CustomCell attrs content



-- Customizations


{-| Override the content shown when the table has no rows.

Defaults to a localised "No data available" message.

    table [ colHeader TranslateHtml.name ]
        |> withEmptyView TranslateHtml.noResultsFound

-}
withEmptyView : Html msg -> TableDefinition msg rowId -> TableDefinition msg rowId
withEmptyView emptyView (TableDefinition_Internal def) =
    TableDefinition_Internal { def | emptyView = emptyView }


type RowSpacing
    = Normal
    | Dense


{-| Reduce the vertical padding on each row for a more compact layout.

    table columns
        |> withDenseSpacing

-}
withDenseSpacing : TableDefinition msg rowId -> TableDefinition msg rowId
withDenseSpacing (TableDefinition_Internal def) =
    TableDefinition_Internal { def | spacing = Dense }


{-| Keep the table header visible while the body scrolls.

    table columns
        |> withStickyHeader

-}
withStickyHeader : TableDefinition msg rowId -> TableDefinition msg rowId
withStickyHeader (TableDefinition_Internal def) =
    TableDefinition_Internal { def | stickyHeader = True }


{-| Apply alternating background colours to odd and even rows.

    table columns
        |> withStripedRows

-}
withStripedRows : TableDefinition msg rowId -> TableDefinition msg rowId
withStripedRows (TableDefinition_Internal def) =
    TableDefinition_Internal { def | striped = True }


{-| An opaque type holding the checkbox selection configuration for a table:
a "select all" message, a per-row select message, and the set of currently
selected row IDs.

Attach checkbox selection to a table with `withCheckboxes`.

-}
type CheckboxSelection msg rowId
    = CheckboxSelection
        { selectAllMsg : Bool -> msg
        , selectRowMsg : rowId -> Bool -> msg
        , rowsSelected : EverySet rowId
        }


{-| Add a checkbox column to the table for row selection.

Rows must be created with `rowIdentified` so that each row has an ID to track.

  - `selectAllMsg` — called with `True` to select all visible rows, `False` to deselect all
  - `selectRowMsg` — called with the row ID and the new checked state when a single row is toggled
  - `rowsSelected` — the set of currently selected row IDs; drives the checked state of each checkbox

The header checkbox displays based on whether rowsSelected contains all rows in the table,
and shows an indeterminate state when some but not all rows are selected.

    table columns
        |> withRows (List.map toRow model.suppliers)
        |> withCheckboxes
            { selectAllMsg = PageMsg.SelectAllToggled
            , selectRowMsg = PageMsg.SelectRowToggled
            , rowsSelected = model.selectedSuppliers
            }

-}
withCheckboxes :
    { selectAllMsg : Bool -> msg
    , selectRowMsg : rowId -> Bool -> msg
    , rowsSelected : EverySet rowId
    }
    -> TableDefinition msg rowId
    -> TableDefinition msg rowId
withCheckboxes checkboxesDef (TableDefinition_Internal def) =
    TableDefinition_Internal { def | checkboxes = Just (CheckboxSelection checkboxesDef) }


checkboxView : { checkMsg : Bool -> msg, isChecked : Bool, isIndeterminate : Bool } -> Html msg
checkboxView { checkMsg, isChecked, isIndeterminate } =
    Checkbox.component
        [ HtmlEvents.onCheck checkMsg
        , Attr.checked isChecked
        , class "t-primary"
        , Attr.property "indeterminate" (Encode.bool isIndeterminate)
        ]
        []


selectAllCheckboxView : TableDefinition msg rowId -> List (Html msg)
selectAllCheckboxView (TableDefinition_Internal tableDef) =
    case tableDef.checkboxes of
        Nothing ->
            []

        Just (CheckboxSelection { selectAllMsg, rowsSelected }) ->
            let
                allRowIds =
                    tableDef.rows
                        |> List.filterMap
                            (\(Row r) -> r.rowId)
                        |> EverySet.fromList

                visibleRowsSelected =
                    EverySet.intersect rowsSelected allRowIds

                visibleRowsThatAreNotChecked =
                    EverySet.diff allRowIds visibleRowsSelected

                checkIcon =
                    if EverySet.isEmpty visibleRowsSelected then
                        checkboxView
                            { checkMsg = selectAllMsg
                            , isChecked = False
                            , isIndeterminate = False
                            }

                    else if EverySet.isEmpty visibleRowsThatAreNotChecked then
                        checkboxView
                            { checkMsg = selectAllMsg
                            , isChecked = True
                            , isIndeterminate = False
                            }

                    else
                        checkboxView
                            { checkMsg = selectAllMsg
                            , isChecked = True
                            , isIndeterminate = True
                            }
            in
            [ Html.th [ class "data-table-header-cell tw-w-0" ] [ checkIcon ] ]


{-| Add custom HTML attributes to the outermost component wrapper `<div>`.

    table columns
        |> withCustomComponentStyles [ class "tw-overflow-auto" ]

This function should not need to be used often. Check if there is a more specific `with*` function that accomplishes the
same thing before reaching for this function.

-}
withCustomComponentStyles : List (Html.Attribute msg) -> TableDefinition msg rowId -> TableDefinition msg rowId
withCustomComponentStyles attrs (TableDefinition_Internal def) =
    TableDefinition_Internal { def | customComponentStyles = def.customComponentStyles ++ attrs }


{-| Add custom HTML attributes to the `<table>` element.

    table columns
        |> withCustomTableStyles [ class "tw-w-full" ]

This function should not need to be used often and may indicate styling that is outside the design system.
Check if there is a more specific `with*` function that accomplishes the same thing before reaching for this function.

-}
withCustomTableStyles : List (Html.Attribute msg) -> TableDefinition msg rowId -> TableDefinition msg rowId
withCustomTableStyles attrs (TableDefinition_Internal def) =
    TableDefinition_Internal { def | customTableStyles = def.customTableStyles ++ attrs }


{-| Add custom HTML attributes to the `<thead>` element.

    table columns
        |> withCustomHeadStyles [ class "tw-bg-gray-50" ]

This function should not need to be used often and may indicate styling that is outside the design system.
Check if there is a more specific `with*` function that accomplishes the same thing before reaching for this function.

-}
withCustomHeadStyles : List (Html.Attribute msg) -> TableDefinition msg rowId -> TableDefinition msg rowId
withCustomHeadStyles attrs (TableDefinition_Internal def) =
    TableDefinition_Internal { def | customHeadStyles = def.customHeadStyles ++ attrs }


{-| Add custom HTML attributes to the header `<tr>` element.

    table columns
        |> withCustomHeadRowStyles [ class "tw-border-b" ]

This function should not need to be used often and may indicate styling that is outside the design system.
Check if there is a more specific `with*` function that accomplishes the same thing before reaching for this function.

-}
withCustomHeadRowStyles : List (Html.Attribute msg) -> TableDefinition msg rowId -> TableDefinition msg rowId
withCustomHeadRowStyles attrs (TableDefinition_Internal def) =
    TableDefinition_Internal { def | customHeadRowStyles = def.customHeadRowStyles ++ attrs }


{-| Add custom HTML attributes to the `<tbody>` element.

    table columns
        |> withCustomBodyStyles [ class "tw-divide-y" ]

This function should not need to be used often and may indicate styling that is outside the design system.
Check if there is a more specific `with*` function that accomplishes the same thing before reaching for this function.

-}
withCustomBodyStyles : List (Html.Attribute msg) -> TableDefinition msg rowId -> TableDefinition msg rowId
withCustomBodyStyles attrs (TableDefinition_Internal def) =
    TableDefinition_Internal { def | customBodyStyles = def.customBodyStyles ++ attrs }
