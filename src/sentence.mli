exception Invalid_sentence
type mag_var = float * Coord.ew

type gpgga = {
  time: float;
  coord: Coord.t;
  quality: int;
  sat_n: int;
  hdop: float;
  alt: float;
  geoid_height: float;
}

type gpgll = {
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

type sat = {
  prn: int;
  elev_dgr: int;
  azimuth: int;
  snr_db: int;
}

type gpgsv = {
  msg_n: int;
  msg_i: int;
  sv_n: int;
  sats: sat list;
}

type t = GPGLL of gpgll | GPGGA of gpgga | GPRMC of gprmc | GPRRMA of gprma | GPGSV of gpgsv

val time_to_unix: int -> float
val datetime_to_unix: int -> int -> float