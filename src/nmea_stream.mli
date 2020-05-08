(* type t = Sentence.t Stream.t


(* [to_coord s] translates an nmea stream to a coordinate stream *)
val to_coord: t -> Coord.t Stream.t

(* [of_channel ic] returns a stream of nmea sentences read from the channel ic *)
val of_channel: in_channel -> t

(* [of_file f] returns a stream of nmea sentences read from f *)
val of_file: string -> t *)