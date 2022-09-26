(* File containing draw functions *)

let range = 41;;    (*Liczba pixeli na wyswietlaczu *)
let x_scale = 1;;   (*Stosunek wartosc-pixel na osi x *)
let y_scale = 3;;   (*Stosunek wartosc-pixel na osi x *)

(*definicja znakow na wyswietlaczu *)
let space_char:string = "  " 
let line_char:string = "()" 
let x_axis_char:string = "=="
let y_axis_char:string = "||"
(*funkcja obliczjaca wartosc dla podanego wielomianu oraz x *)
let polynomial_value poly = fun x -> (List.fold_left (fun s a -> x * s + a) 0 poly);;

(*laczenie list z rekurencja ogonowa *)
let append l1 l2 =
  let rec loop acc l1 l2 =
    match l1, l2 with
    | [], [] -> List.rev acc
    | [], h :: t -> loop (h :: acc) [] t
    | h :: t, l -> loop (h :: acc) t l
    in
    loop [] l1 l2

(*funkcja decydujaca jaki znak nalezy wyrysowac *)
let match_head h row_val poly= 
    if row_val = (polynomial_value poly (h/x_scale))/y_scale then
        [line_char]
    else if row_val = 0 then
        [x_axis_char]
    else
        if h = 0 then [y_axis_char]
        else [space_char]

(*funkcja zapelniajaca pojedynczy wiersz *)
let rec build_row row_val x_range result poly =
    match x_range with
        [] -> ["Something went wrong"]
        |h::[] -> append result (match_head h row_val poly)
        |h::t -> build_row row_val t (append result (match_head h row_val poly)) poly
(*funkcja zapelniajaca cala matryce *)
let rec build_canvas canv x_range y_range poly =
    match y_range with
        [] -> [["Something went wrong"]]
        |h::[] -> append canv [(build_row h x_range [] poly)]
        |h::t -> build_canvas (append canv [(build_row h x_range [] poly)]) x_range t  poly
(*funkcja wypisujaca wiersz*)
let rec print_row row =
    match row with
        [] -> print_string "\n"
        |h::[] -> print_string h; print_string "\n"
        |h::t -> print_string h; print_row t
(*funkcja wypisujaca matryce *)
let rec print_canvas canv=
    match canv with
        []-> print_string "Something went wrong"
        |h::[[]] -> print_row h
        |h::t -> print_row h; print_canvas t

(*dziedzina x *)
let x_range = List.init range (fun x -> x - range/2);;
(*zbior wartosci y *)
let y_range = List.init range (fun y -> -y + range/2);;

(*funkcja wyjsciowa wyrysowujaca wielomian*)
let polydraw l = 
    print_canvas (build_canvas [[]] x_range y_range l);
    print_string    (x_axis_char ^ " - " ^ (string_of_int x_scale)
                    ^ "\n\n" ^ y_axis_char ^ " - " ^ (string_of_int y_scale)
                    ^ "\n");
    1.;;
(*wyjciowa funkcja podajaca wartosc dla danego wielomianu i argumentu *)
let polyval l v = float_of_int (polynomial_value l v);;
