module ErrorPage exposing (ErrorPage, Model, Msg, init, internalError, notFound, statusCode, update, view)

import Doc
import Effect exposing (Effect)
import M3e.Element as Element
import View exposing (View)


type alias Msg =
    ()


type alias Model =
    {}


init : ErrorPage -> ( Model, Effect Msg )
init _ =
    ( {}, Effect.none )


update : ErrorPage -> Msg -> Model -> ( Model, Effect Msg )
update _ _ model =
    ( model, Effect.none )


type ErrorPage
    = NotFound
    | InternalError String


notFound : ErrorPage
notFound =
    NotFound


internalError : String -> ErrorPage
internalError =
    InternalError


view : ErrorPage -> Model -> View Msg
view error _ =
    { body =
        [ Doc.message
            (case error of
                NotFound ->
                    "Page not found. Maybe try another URL?"

                InternalError string ->
                    "Something went wrong.\n" ++ string
            )
            |> Element.toNode
        ]
    , title =
        case error of
            NotFound ->
                "Page Not Found"

            InternalError _ ->
                "Unexpected Error"
    }


statusCode : ErrorPage -> number
statusCode error =
    case error of
        NotFound ->
            404

        InternalError _ ->
            500
