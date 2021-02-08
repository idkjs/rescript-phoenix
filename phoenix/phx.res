// module Abstract = Phx_abstract
module Channel = Phx_channel
module Socket = Phx_socket
// module Push = Phx_push
module Presence = Phx_presence
module LongPoll = Phx_long_poll

// open Abstract
/* Init functions */

let initSocket = Socket.init

let initChannel = Socket.channel

/* Channel functions */

let joinChannel = Channel.join

let leaveChannel = Channel.leave

let push = Channel.push

let putOn = (event, f: Js.Json.t => unit, channel) => {
  let _ = channel["on"](event, f)
  channel
}

/* Socket functions */

let disconnectSocket = Socket.disconnect

let connectSocket = Socket.connect

let removeChannel = (channel, socket) => socket["remove"](channel)

let putOnClose = (f: unit => unit, socket) => {
  let _ = socket["onClose"](f)
  socket
}

/* Push Functions */

let putReceive = (event, handleReiceive, push) => {
  let _ = push["receive"](event, handleReiceive)
  push
}

/* Presence Functions */
let putOnSyncState = Presence.onState
let putOnsyncDiff = Presence.onDiff
