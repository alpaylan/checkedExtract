
open CheckedExtract.Checkedlib

let b = 
  test_check "(fun x -> x + 5)"
  
let () = 
  print_endline (string_of_bool b)
