;;; Their definition of a func 'atom?'
;;; Takes one argument - can be any S-Expression
(define atom?
    (lambda (x)
    (and (not (pair? x)) (not (null? x) ))))
