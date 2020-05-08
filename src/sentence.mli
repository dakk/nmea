exception Invalid_sentence
type mag_var = float * Coord.ew

type gga = {
  time: float;
  coord: Coord.t;
  quality: int;
  sat_n: int;
  hdop: float;
  alt: float;
  geoid_height: float;
}

type gll = {
  time: float;
  coord: Coord.t;
  status: bool;
}

type gprmc = {
  time: float;
  coord: Coord.t;
  sog: float;
  cmg: float;
  mag_var: mag_var;
  status: bool;
}

type gprma = {
  coord: Coord.t;
  sog: float;
  cog: float;
  mag_var: mag_var;
  status: bool;
}

type t = GPGLL of gll | GPGGA of gga | GPRMC of gprmc | GPRRMA of gprma

val time_to_unix: int -> float
val datetime_to_unix: int -> int -> float