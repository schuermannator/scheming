#lang pie

;; constructors build values
;; type constructors build types
;;
;; car is neither -> it's an eliminator
;; eliminators take apart the values built by constructors

;; lambda builds functions
;; lambda is a constructor
;; applying a function to arguments is the functions eliminator
;; every (lambda (x...) body) is a value
;(lambda (flavor)
;  (cons flavor 'lentils))

;; neutral expressions that are written identically are the same,
;; __no matter their type__.

(claim veggies (Pair Atom Atom))
(define veggies (cons 'celert 'carrot))

;; (claim gauss (-> Nat Nat))
;; (define gauss (lambda (n)
;;                 (cond
;;                   ((eq? n 'zero) 0)
;;                   (else (add1 (gauss (sub1 n)))))))

;; Expressions such as Atom, Nat, and (Pair Atom Atom) are types, sand each of
;; these types is a U.

;; Type Values
;; An expression that is described by a type is a value when it has a
;; constructor at its top. Similarly, an expression thst is a type is a value
;; when it has a type constuctuor at its top.
;;

(claim Pear U)
(define Pear (Pair Nat Nat))

(claim Pear-maker U)
(define Pear-maker
  (-> Nat Nat Pear))

(claim elim-Pear
       (-> Pear Pear-maker Pear))

(define elim-Pear
  (lambda (pear maker)
    (maker (car pear) (cdr pear))))

(elim-Pear
 (cons 3 17)
 (lambda (a d)
   (cons d a)))

(claim step-+ (-> Nat Nat))
(define step-+ (lambda (n)
                 (add1 n)))

(claim + (-> Nat Nat Nat))
(define + (lambda (a b)
            (iter-Nat a
                      b
                      step-+)))

(claim pearwise+ (-> Pear Pear Pear))
(define pearwise+ (lambda (first second)
                    (elim-Pear first
                               (lambda (ff fs)
                                 (elim-Pear second
                                            (lambda (sf ss)
                                              (cons (+ ff sf) (+ fs ss))))))))

(pearwise+ (cons 1 2) (cons 3 4))
