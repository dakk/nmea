type t = in_channel

(** [parse s] parses the sentence s *)
val parse: string -> Sentence.t

(** [next ch] returns the next sentence read from ch *)
val next: in_channel -> Sentence.t option

(** [next_coord ch] returns the next coordinate read from ch *)
val next_coord: in_channel -> Coord.t option