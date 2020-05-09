%token <int> NAT
%token <float> REAL
%token <int> HEX

%token <Coord.ns> NS
%token <Coord.ew> EW
%token <string> UNIT
%token <bool> STATUS

%token GPGGA GPRMC GPGLL GPGSV
%token SLASH COMMA STAR M
%token SPREFIX EOL

%start <Sentence.t> sentence

%%

sentence:
  | SPREFIX GPGGA COMMA nmea_gpgga_sentence EOL   { Sentence.GPGGA $4 }
  | SPREFIX GPRMC COMMA nmea_gprmc_sentence EOL   { Sentence.GPRMC $4 }
  | SPREFIX GPGLL COMMA nmea_gpgll_sentence EOL   { Sentence.GPGLL $4 }
  | SPREFIX GPGSV COMMA nmea_gpgsv_sentence EOL   { Sentence.GPGSV $4 }

nmea_gpgsv_sentence:
  | NAT COMMA NAT COMMA NAT COMMA sat_info COMMA sat_info COMMA sat_info COMMA sat_info COMMA checksum
    { Sentence.({
        msg_n = $1;
        msg_i = $3;
        sv_n = $5;
        sats = [ $7; $9; $11 ];
    })}


/* $GPGLL,4916.45,N,12311.12,W,225444,A*32 */
/* $GPGLL,,,,,082031.00,V,N*42 */
nmea_gpgll_sentence:
  /* coord       time       status*/
  | coords COMMA REAL COMMA STATUS checksum
    { Sentence.({
        time = Sentence.time_to_unix @@ int_of_float $3;
        status = $5;
        coord = $1;
    })}

nmea_gpgga_sentence:
  /* time      coord        quality   sat_n     hdop       alt        M       geoid      M       -          - */
  | REAL COMMA coords COMMA NAT COMMA NAT COMMA REAL COMMA REAL COMMA M COMMA REAL COMMA M COMMA UNIT COMMA UNIT checksum
    { Sentence.({
        time = Sentence.time_to_unix @@ int_of_float $1;
        coord = $3;
        quality = $5;
        sat_n = $7;
        hdop = $9;
        alt = $11;
        geoid_height = $15;
    })}

/* $GPRMC,083344.00,V,,,,,,,090520,,,N*7B */
nmea_gprmc_sentence:
  | REAL COMMA STATUS COMMA coords COMMA REAL COMMA REAL COMMA NAT COMMA REAL COMMA EW COMMA checksum
    { Sentence.({
        time = Sentence.datetime_to_unix $11 @@ int_of_float $1;
        status = $3;
        coord = $5;
        sog = $7;
        cmg = $9;
        mag_var = Coord.parse_lng $13 $15;
    })}
  | REAL COMMA STATUS COMMA coords COMMA COMMA COMMA NAT COMMA COMMA COMMA checksum
    { Sentence.({
        time = Sentence.datetime_to_unix $9 (int_of_float $1);
        status = $3;
        coord = $5;
        sog = 0.0;
        cmg = 0.0;
        mag_var = (0.0, E);
    })}

sat_info: 
  | NAT COMMA NAT COMMA NAT COMMA NAT {
    (Sentence.({
      prn = $1;
      elev_dgr = $3;
      azimuth = $5;
      snr_db = $7;
    }))
  }

checksum:
  | COMMA? NS? STAR HEX  { $4 }
  | COMMA? NS? STAR NAT  { int_of_string (Printf.sprintf "0x%d" $4) }

coords:
  | REAL COMMA NS COMMA REAL COMMA EW
    { (Coord.parse_lat $1 $3),
      (Coord.parse_lng $5 $7) }
  | COMMA COMMA COMMA
    { (0.0, N), (0.0, W) }