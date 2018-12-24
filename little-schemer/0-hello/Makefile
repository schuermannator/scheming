all: scheme lisp


scheme:
	scheme --load hello_world.scm

lisp:
	sbcl --noinform --load hello_world.lisp --eval '(progn (hello-world) (sb-ext:quit))'
	# sbcl --noinform --load hello_world --eval '(hello-world)'
