let rec loop ch =
  Unix.sleep 1;
  match Nmea.Nmea_stream.next ch with
  | None -> Printf.printf "Invalid message\n"; loop ch
  | Some(m) -> Printf.printf "Valid message\n"; loop ch
;;


loop @@ open_in "/dev/ttyACM0";;