open OUnit2;;

let dummy () octx = assert_equal true true;;

let suite = "nmea" >::: [
	"dummy"	>:: dummy ();	
];;

let () = run_test_tt_main suite;;