
type rec t = {
  @bs.meth
  "resend": /* constructor(channel: Channel, event: string, payload: any, timeout: number); */
  /* defined as function in Phx_channel duo to circle dependency */
  /* resend(timeout: number): void; */
  float => unit,
  @bs.get
  "send": /* send(): void; */
  unit,
  @bs.meth
  "receive": /* receive(status: string, callback: (response?: any) => void): Push; */
  (string, Js.Json.t => unit) => t,
}
