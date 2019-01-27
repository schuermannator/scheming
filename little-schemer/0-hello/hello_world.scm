; hello_world.scm
; simple hello world in scheme

;(begin
;  (display "Hello, World!")
;  (newline))

;(define (say-hello name)
;    (print (string-append "Hello, " name))
;    (newline))

;  (say-hello "Earthling")

; Hello world as a variable
(define vhello "Hello world")     ;1

; Hello world as a function
(define fhello (lambda ()         ;2
		 "Hello world"))


;;; call with vhello and (fhello)
