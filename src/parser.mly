%token <int> NAT
%token <float> REAL
%token <int> HEX

%token <Coord.ns> NS
%token <Coord.ew> EW
/* %token <string> UNIT */
%token <bool> STATUS

%token SPREFIX GPGGA GPRMC
%token SLASH COMMA STAR M
%token EOL EOF

%start <Sentence.t> sentence

%%

sentence:
  | SPREFIX GPGGA COMMA nmea_gpgga_sentence EOL   { Sentence.GPGGA $4 }
  | SPREFIX GPRMC COMMA nmea_gprmc_sentence EOL   { Sentence.GPRMC $4 }

/* checksum = $18; */

nmea_gpgga_sentence:
  | NAT COMMA coords COMMA NAT COMMA NAT COMMA REAL COMMA REAL COMMA M COMMA REAL COMMA M COMMA checksum
    { Sentence.({
        time = Sentence.time_to_unix $1;
        coord = $3;
        quality = $5;
        sat_n = $7;
        hdop = $9;
        alt = $11;
        geoid_height = $15;
    })}

nmea_gprmc_sentence:
  | NAT COMMA STATUS COMMA coords COMMA REAL COMMA REAL COMMA NAT COMMA REAL COMMA EW COMMA checksum
    { Sentence.({
        time = Sentence.datetime_to_unix $11 $1;
        status = $3;
        coord = $5;
        sog = $7;
        cmg = $9;
        mag_var = Coord.parse_lng $13 $15;
    })}

checksum:
  | HEX  { $1 }
  | NAT  { int_of_string (Printf.sprintf "0x%d" $1) }

coords:
  | REAL COMMA NS COMMA REAL COMMA EW
    { (Coord.parse_lat $1 $3),
      (Coord.parse_lng $5 $7) }