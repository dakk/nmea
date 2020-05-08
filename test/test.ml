open OUnit2;;

let parse_gpgga s () octx = 
  let s = Nmea.Nmea_stream.parse s in
  assert_equal true true
;;

let parse_gpgll s () octx = 
  let s = Nmea.Nmea_stream.parse s in
  assert_equal true true
;;

let suite = "nmea" >::: [
	"parse_gpgll.0"	>:: parse_gpgll "$GPGLL,4916.45,N,12311.12,W,225444,A*32" ();	
	(* "parse_gpgga.0"	>:: parse_gpgga "$GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47" ();	
	"parse_gpgga.1"	>:: parse_gpgga "$GPGGA,134658.00,5106.9792,N,11402.3003,W,2,09,1.0,1048.47,M,-16.27,M,08,AAAA*60" ();	 *)
];;

let () = run_test_tt_main suite;;