open Sentence;;

type t = in_channel;;

let parse s = 
  (* try  *)
    Parser.sentence Lexer.token (Lexing.from_string s)
  (* with | _ -> raise Invalid_sentence *)
;;

let next ch = 
  try 
    Some (parse @@ input_line ch)
  with | _ -> None
;;

let next_coord ch = 
  match next ch with
  | Some(GPGGA (s)) -> Some(s.coord)
  | Some(GPRMC (s)) -> Some(s.coord)
  | _ -> None
;;