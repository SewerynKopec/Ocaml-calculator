# Makefile file

# Calc output file
all:  parser  poly  funs  lexer  calc  
	ocamlc -o calc poly.cmo funs.cmo lexer.cmo parser.cmo calc.cmo 

# Generates parser.mli and parser.ml
# and compiles it
parser: parser.mly
	ocamlyacc parser.mly     
	ocamlc -c parser.mli parser.ml

# Polynomial module
poly: poly.ml
	ocamlc -c poly.ml

# Compiles my functions
funs: funs.ml
	ocamlc -c funs.ml

# Generates lexer.ml and compiles it
lexer: lexer.mll
	ocamllex lexer.mll       
	ocamlc -c lexer.ml

# Compile main program
calc: calc.ml
	ocamlc -c calc.ml

# Clean project
clean:
	rm -f lexer.ml parser.ml parser.mli *.cmi *.cmo calc 
	
# End of Makefile file
