
module Channel = Phx_channel
type meta = Js_json.t

type state = Js.Dict.t<{"metas": array<meta>}>
type diff = {"joins": state, "leaves": state}
type key = string

type onJoinOrLeave = (
  ~key: string=?,
  ~currentPresence: state=?,
  ~newPresence: state=?,
  unit,
) => unit

/* syncState(
    currentState: any,
    newState: any,
    onJoin?: (key?: string, currentPresence?: any, newPresence?: any) => void,
    onLeave?: (key?: string, currentPresence?: any, newPresence?: any) => void
  ): any;*/
@bs.scope("Presence") @bs.module("phoenix")
external syncState: (
  state,
  state,
  ~onJoin: onJoinOrLeave=?,
  ~onLeave: onJoinOrLeave=?,
  unit,
) => state = "syncState"
let syncState = (~onJoin=?, ~onLeave=?, currentState, newState) =>
  syncState(currentState, newState, ~onJoin?, ~onLeave?, ())

/* syncDiff(
    currentState: any,
    newState: any,
    onJoin?: (key?: string, currentPresence?: any, newPresence?: any) => void,
    onLeave?: (key?: string, currentPresence?: any, newPresence?: any) => void
  ): any;*/
@bs.scope("Presence") @bs.module("phoenix")
external syncDiff: (
  state,
  diff,
  ~onJoin: onJoinOrLeave=?,
  ~onLeave: onJoinOrLeave=?,
  unit,
) => state = "syncDiff"
let syncDiff = (~onJoin=?, ~onLeave=?, currentState, diff) =>
  syncDiff(currentState, diff, ~onJoin?, ~onLeave?, ())

/* This function doesn't map well */
type pres = Js.Json.t
type chooser = (key, pres) => pres
/* list(presences: any, chooser?: Function): any; */
@bs.scope("Presence") @bs.module("phoenix")
external list: (Js.Json.t, ~chooser: chooser=?, unit) => Js.Json.t = "list"
let list = (~chooser=?, presences) => list(presences, ~chooser?, ())

@bs.send
external onState: (Channel.t, string, state => unit, unit) => unit = "on"
let onState = (f, channel) => {
  let _ = onState(channel, "presence_state", f, ())
  channel
}
@bs.send
external onDiff: (Channel.t, string, diff => unit, unit) => unit = "on"
let onDiff = (f, channel) => {
  let _ = onDiff(channel, "presence_diff", f, ())
  channel
}
