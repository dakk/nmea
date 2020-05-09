open OUnit2;;

let parse_fail_test s () octx =
  try Nmea.Nmea_stream.parse s |> ignore; assert_equal true false 
  with | _ -> assert_equal true true
;;

let parse_test s () octx = 
  Nmea.Nmea_stream.parse s |> ignore; assert_equal true true
;;

let suite = "nmea" >::: [
  (* gpgsv *)
  "parse_gpgsv.0"	>:: parse_test "$GPGSV,2,1,08,02,22,112,,10,02,264,,12,72,328,,15,14,177,*7E" ();
  "parse_gpgsv.1"	>:: parse_test "$GPGSV,2,2,08,17,04,036,,19,23,043,,24,70,107,,25,48,276,*77" ();	  
  "parse_gpgsv.2"	>:: parse_test "$GPGSV,3,1,11,03,03,111,00,04,15,270,00,06,01,010,00,13,06,292,00*74" ();
  "parse_gpgsv.3"	>:: parse_test "$GPGSV,3,2,11,14,25,170,00,16,57,208,39,18,67,296,40,19,40,246,00*74" ();
  "parse_gpgsv.4"	>:: parse_test "$GPGSV,3,3,11,22,42,067,42,24,14,311,43,27,05,244,00,,,,*4D" ();

  (* gpgll *)
	"parse_gpgll.0"	>:: parse_test "$GPGLL,4916.45,N,12311.12,W,225444.00,A*32" ();	
	"parse_gpgll.1"	>:: parse_test "$GPGLL,,,,,080904.00,V,N*4F" ();	
  "parse_gpgll.2"	>:: parse_test "$GPGLL,,,,,080904.00,V*4F" ();	

  (* gprmc *)
  "parse_gprmc.0" >:: parse_test "$GPRMC,083344.00,V,,,,,,,090520,,,N*7B" ();

  (* gpgga *)
  "parse_gpgga.0" >:: parse_test "$GPGGA,083224.00,,,,,0,00,99.99,,,,,,*69" ();
	"parse_gpgga.1"	>:: parse_test "$GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47" ();	
	"parse_gpgga.2"	>:: parse_test "$GPGGA,134658.00,5106.9792,N,11402.3003,W,2,09,1.0,1048.47,M,-16.27,M,08,AAAA*60" ();	
];;

let () = run_test_tt_main suite;;