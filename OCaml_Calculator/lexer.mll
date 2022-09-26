(* Lexer file also known in literature as scanner lexer.mll *)

{
  (* The type token is defined in file parser.mli *)
  open Parser;;     
   
  (* My functions *)
  open Funs;;

  (* End of file exception *)
  exception Eof;;

  (* Unexpected token *)
  exception UNEXPECTED_TOKEN;;
  (* Built-in function not found *)
  exception BuiltInFuncNotFound;;

  (* Create hash table with init list *)
  let create_my_hashtab size init_list =
    (* Create hash table with given size *)
    let tab = Hashtbl.create size in
    (* Iterate through the entire init list *)
    List.iter
      (* Adding key data pairs into tab hash table *)
      (fun (key, data) -> Hashtbl.add tab key data)
      init_list;
    (* Return tab hash table *)
    tab;;
  (* val create_my_hashtab : int -> ('a * 'b) list -> ('a, 'b) Hashtbl.t = <fun> *)
  
  (* Table with built-in functions *)
  (* https://v2.ocaml.org/api/Stdlib.html *)
  let bi_func_tab = create_my_hashtab 18 [
    ("sqrt", sqrt);
    ("exp", exp);
    ("expm1", expm1);
    ("log", log);
    ("log10", log10);
    ("log1p", log1p);
    ("cos", cos);
    ("sin", sin);
    ("tan", tan);
    ("acos", acos);
    ("asin", asin);
    ("atan", atan);
    ("cosh", cosh);
    ("sinh", sinh);
    ("tanh", tanh);
    ("ceil", ceil);
    ("floor", floor);
    ("abs", abs_float);
  ];;
  (* val log1p : float -> float
      log1p x computes log(1.0 +. x) (natural logarithm), 
      giving numerically-accurate results even if x is close to 0.0. *)
  (* val expm1 : float -> float
      expm1 x computes exp x -. 1.0, 
      giving numerically-accurate results even if x is close to 0.0. *)
  (* val funct_tab : (string, float -> float) Hashtbl.t = <abstr> *)

  let my_three_args_funcs = create_my_hashtab 3 [
    ("sum3", sumuj3liczby);
  ];;
  let poly_draw_func = create_my_hashtab 1 [
    ("polydraw", polydraw);
  ];;
  let polyval_func = create_my_hashtab 1 [
    ("polyval", polyval);
  ];;
} 

(* Digits 0 1 2 3 4 5 6 7 8 9 *)
let digit = ['0'-'9']
(* Float number *)
let float = digit+('.'digit+)?
(* White spaces*)
let white = [' ' '\t']+
(* New line *)
let nl = ['\n']
(* ID of function *)
let fun_id = ['a'-'z' 'A'-'Z' '0'-'9']

(* Parsing token *)
rule token = parse
  | float as lxm { FLOAT(float_of_string lxm) }
  | '+'         { PLUS }
  | '-'         { MINUS } 
  | '*'         { MULT }
  | '/'         { DIV }
  | '^'		      { POW }
  | '('         { LBRACKET }
  | ')'         { RBRACKET } 
  | white       { token lexbuf }  
  | nl          { EOL }
  | eof         { raise Eof }
  | fun_id* as word
                { 
                  (* Try to find fun in built-in functions tab *)
                  try
                      let f = Hashtbl.find bi_func_tab word in
                      BI_FUNC f
                  with Not_found -> 
                      (* Try to find fun in my 3 args functions tab *)
                      try
                          let f = Hashtbl.find my_three_args_funcs word in
                          MY_3FUNC f
                      with Not_found ->
                          try
                              let f = Hashtbl.find poly_draw_func word in
                              POLY_DRAW f
                          with Not_found ->
                              try 
                                  let f = Hashtbl.find polyval_func word in 
                                  POLY_VAL f
                              with Not_found ->
                                  raise BuiltInFuncNotFound
                }
  | _           { raise UNEXPECTED_TOKEN }
  
(* End of lexer.mll file *)
