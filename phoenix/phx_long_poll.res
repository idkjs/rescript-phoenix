open Phx_abstract
type t = {
  @bs.meth
  "normalizeEndpoint": /* constructor(endPoint: string); */
  /* defined as function */
  /* normalizeEndpoint(endPoint: string): string; */
  string => string,
  @bs.get
  "endpointURL": /* endpointURL(): string; */
  string,
  @bs.get
  "closeAndRetry": /* closeAndRetry(): void; */
  void,
  @bs.get
  "ontimeout": /* ontimeout(): void; */
  void,
  @bs.get
  "poll": /* poll(): void; */
  void,
  /* send(body: any): void; */
  /* defined as function */
  /* close(code?: any, reason?: any): void; */
  /* defined as function */
}

/* constructor(endPoint: string); */
@bs.new @bs.module("phoenix") external init: string => t = "LongPoll"

/* send(body: any): void; */
@bs.send external send: (t, Js.t<'body>) => void = "send"
/* close(code?: any, reason?: any): void; */
@bs.send
external close: (t, ~code: Js.t<'code>=?, ~reason: Js.t<'reason>=?) => void = "close"
