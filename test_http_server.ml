

let port = 3000
let hostname = "127.0.0.1"
let create_server  http = 
  let server = http##createServer (fun %uncurry  (req,  resp)  -> 
      resp##statusCode__set 200;
      resp##setHeader("Content-Type", "text/plain");
      resp##end__ "Hello world\n"
    )
  in
  server##listen(port, hostname,  fun %uncurry () -> 
      Js.log ("Server running at http://"^ hostname ^ ":" ^ string_of_int port ^ "/")
    ) 

type req 

type resp = [%uncurry: <
   statusCode__set : int -> unit  ;
   setHeader : string * string -> unit ;
   end__ : string ->  unit 
> Js.t ]

type server = [%uncurry: <
   listen : int * string *  (unit -> unit) -> unit 
> Js.t]



type http = [%uncurry:<
   createServer : (req  * resp  -> unit ) ->  server
> Js.t ]


external http : http  = "http"  [@@bs.val_of_module ]


let () = 
  create_server http



(* local variables: *)
(* compile-command: "./node_modules/bs-platform/bin/bsc -c test_http_server.ml" *)
(* end: *)
