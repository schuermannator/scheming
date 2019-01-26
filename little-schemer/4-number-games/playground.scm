; number games
(load "../prereqs.scm")

(atom? '14)
(define n '14)
(atom? n)

(define add1
  (lambda (n)
    (+ n 1)))

(define sub1
  (lambda (n)
    (- n 1)))

(add1 n)

(zero? 0)

; try to write "+" (using add1 and sub1 and zero?)
(define +
  (lambda (a1 a2)
    (


