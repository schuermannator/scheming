; playground for chapter 1 of "The Little Schemer"

; learning about atoms and S-Expressions
; S-Expression = Symbolic Expressions

;;; Their definition of a func 'atom?'
;;; Takes one argument - can be any S-Expression
(define atom?
    (lambda (x)
    (and (not (pair? x)) (not (null? x) ))))

'atom

'(atom) ; list of a single atom

; car
(car '(((hotdogs)) (and) (pickle) relish))

; could-er
(cdr '(((hotdogs)) (and) (pickle) relish))

; both take non-empty lists as arguments

(define l '(butter and jelly))
(define a 'peanut)
; cons the atom 'a' onto the list 'l'
(cons a l) ; (peanut butter and jelly)

; cons takes 2 args:
; 1. Any S-Expression
; 2. Any list

(define nl ())
(null? nl) ; null is defined only on lists

(define zach 'zachmo)
(null? zach)

