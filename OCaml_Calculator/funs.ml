(* Sewcio wazne!
  Dodajac nowa funkcje:

  edycja pliku parser.mly:
  NOTE: Jezeli dodajesz funkcje z inna iloscia argumentow niz juz zrobione!!!

      ~ do parser.mly nalezy dodac (w tokenach):

  %token < (ilosc argumentow * (float->))float > nazwa_(ilosc arg)Funs /* moje funkcje przyjmujace x arg*/

      ~ i na dole kodu dodac:

    | nazwa_(ilosc arg)Funs LBRACKET (ilosc argumentow * (expr)) RBRACKET   { $1 (ilosc arg * ($x)) } /* TESTING nazwa_(ilosc arg)Funs */ 
      
  edycja pliku lexer.mll:    
  NOTE: jezeli ma tyle samo argumentow co juz zrobiona:

    - rozbudowujesz hash tab juz istniejacy np.:
    
    let my_three_args_funcs = create_my_hashtab size(teraz po dodaniu = 2) [
      ("sumuj3liczby", sum3);
      ("new_command_name", new_func_in_code_name);
    ];;

  W przeciwnym razie:
        - nowa tabela funkcji
        oraz
        - na koncu lexer.mll
          | fun_id* as word odpowiednio -> poprawic trzeba ten fragment kodu:
          {!!!
            | fun_id* as word
                  { 
                    try
                        let f = Hashtbl.find bi_func_tab word in
                        BI_FUNC f
                    with Not_found -> 
                        (* Try to find fun in my functions tab *)
                        try
                            let f = Hashtbl.find my_three_args_funcs word in
                            MY_FUNC f
                        with Not_found -> 
                              raise BuiltInFuncNotFound
                  }
          }!!!

  edycja pliku funs.ml:
  NOTE: w tym pliku dodajemy nowe funkcje widziane przez kalkulator.
  NOTE: mozna zrobic plik z jakas funkcjami pomocniczymi i go zalaczyc tutaj za pomoca open Nazwa_pliku;; (nazwa pliku z wielkiej litery)
  NOTE: jak bedziesz korzystal z pomocniczych plikow to je tez musisz dodac do Makefile by sie skompilowaly!!!


  BARDZO WAZNE!!!
  COMPILE: make
  TEST: ./calc
  CLEAN: make clean
  ZAWSZE CZYSC PRZED WYSLANIEM NA GITA!
  Wysylaj tylko nasze pliki, a nie generowane/wyniki kompilacji.
*)


(* Example fun with 3 float arguments that sum x y z *)
let sumuj3liczby (x:float) (y:float) (z:float) = 
  x +. y +. z;;
open Poly;;
let polydraw a b c d e = Poly.polydraw [int_of_float a; int_of_float b; int_of_float c; int_of_float d; int_of_float e];;
let polyval a b c d e f = Poly.polyval [ int_of_float a; int_of_float b; int_of_float c; int_of_float d; int_of_float e] (int_of_float f);;

(* End of funs.ml file *)
