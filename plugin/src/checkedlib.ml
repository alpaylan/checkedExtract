open List
open Merlin_kernel
(* open Merlin_analysis *)
(* open Query_commands *)
open Ocaml_typing





let test_check code = 
  let file_source = Msource.make code in
  let config = Mconfig.initial in
  let pipeline = Mpipeline.make config file_source in

  Mpipeline.with_pipeline pipeline (fun _ ->
    let typing = Mpipeline.typer_result pipeline in
    let typedtree = Mtyper.get_typedtree typing in
    let ppf = Format.std_formatter  in
    begin match typedtree with
      | `Interface s -> Printtyped.interface ppf s
      | `Implementation s -> Printtyped.implementation ppf s
    end;
    Format.pp_print_newline ppf ();
    Format.pp_force_newline ppf ();
    let () = Printf.printf "TypeTree: %s \n" (Mbrowse.print () (Mbrowse.of_typedtree typedtree)) in
    let typedtree_errors = Mtyper.get_errors typing in
    if typedtree_errors = [] then
      let () = Printf.printf "No errors" in
      true
    else
      let () = Printf.printf "Error: %s" (Printexc.to_string (hd typedtree_errors)) in
      false
  )

  (* let () = Printf.printf "Hello, world!\n" in 
  () *)