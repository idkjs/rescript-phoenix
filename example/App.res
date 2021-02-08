type state =
  | LOADING
  | ERROR
  | LOADED(string)

type action =
  | FETCHCHANNEL
  | WEBSOCKET(string)
  | FAILEDTOFETCH

type webSocket = {id: string}

module Decode = {
  let ws = webSocket => {
    open Json.Decode
    {id: webSocket |> field("id", string)}
  }
}

// let initialState = LOADING;

@react.component
let make = () => {
  let (state: state, dispatch: action => unit) = React.useReducer(
    (_, action: action) =>
      switch action {
      | WEBSOCKET(id) => LOADED(id)
      | FAILEDTOFETCH => ERROR
      | FETCHCHANNEL => LOADING
      },
    LOADING,
  )

  let fetchChannel = {
    dispatch(FETCHCHANNEL)
    open Js.Promise
    Fetch.fetchWithInit(
      "/",
      Fetch.RequestInit.make(
        ~method_=Post,
        ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(json =>
      json
      |> Decode.ws
      |> (webSocket => dispatch(WEBSOCKET(webSocket.id)))
      |> resolve
    )
    |> catch(_err => Js.Promise.resolve(dispatch(FAILEDTOFETCH)))
    |> ignore
  }

  React.useEffect1(() => {
    fetchChannel |> ignore
    None
  }, [])
  switch state {
  | ERROR => <div> {React.string("An Error Occured !!")} </div>
  | LOADING => <div> <div> {React.string("Loading... ")} </div> </div>
  | LOADED(id) => <div> <div> {React.string("Loaded" ++ id)} </div> </div>
  }
}
