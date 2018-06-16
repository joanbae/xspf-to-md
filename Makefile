.PHONY:	all clean

OCB = ocamlbuild -use-ocamlfind

all: main.native

clean:
	$(OCB) -clean

main.native:
	$(OCB) src/main.native

