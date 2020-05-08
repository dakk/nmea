type ns = N | S
type ew = E | W
type lat = float * ns
type lng = float * ew

type t = lat * lng

val lat : t -> lat
val lng : t -> lng
val to_string : t -> string

val parse_lat : float -> ns -> lat
val parse_lng : float -> ew -> lng