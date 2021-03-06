// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Phoenix from "phoenix";
import * as Caml_option from "bs-platform/lib/es6/caml_option.js";

function syncState(onJoin, onLeave, currentState, newState) {
  return Phoenix.Presence.syncState(currentState, newState, onJoin !== undefined ? Caml_option.valFromOption(onJoin) : undefined, onLeave !== undefined ? Caml_option.valFromOption(onLeave) : undefined);
}

function syncDiff(onJoin, onLeave, currentState, diff) {
  return Phoenix.Presence.syncDiff(currentState, diff, onJoin !== undefined ? Caml_option.valFromOption(onJoin) : undefined, onLeave !== undefined ? Caml_option.valFromOption(onLeave) : undefined);
}

function list(chooser, presences) {
  return Phoenix.Presence.list(presences, chooser !== undefined ? Caml_option.valFromOption(chooser) : undefined);
}

function onState(f, channel) {
  channel.on("presence_state", f);
  return channel;
}

function onDiff(f, channel) {
  channel.on("presence_diff", f);
  return channel;
}

var Channel;

export {
  Channel ,
  syncState ,
  syncDiff ,
  list ,
  onState ,
  onDiff ,
  
}
/* phoenix Not a pure module */
