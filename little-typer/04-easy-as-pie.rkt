#lang pie


;;;; ---->> here
(claim elim-Pair
       (Pi ((A U) (D U) (X U))
           (-> (Pair A D)
               (-> A D X)
               X)))

(define elim-Pair
  (lambda (A D X)
    (lambda (p f)
      (f (car p) (cdr p)))))

(claim kar
       (-> (Pair Nat Nat)
           Nat))
(define kar
  (lambda (p)
    (elim-Pair
     Nat Nat
     Nat
     p
     (lambda (a d)
       a))))

(claim kdr (-> (Pair Nat Nat)
               Nat))
(define kdr
  (lambda (p)
    (elim-Pair
     Nat Nat
     Nat
     p
     (lambda (a d) d))))

(claim swap
       (-> (Pair Nat Atom)
           (Pair Atom Nat)))
(define swap
  (lambda (p)
    (elim-Pair
     Nat Atom
     (Pair Atom Nat)
     p
     (lambda (a d) (cons d a)))))


;; Pi-expressions  wtf!
;; does what -> cannot
;; can talk about _any_ types

;; A and D refer to specific types that are not yet known
(claim flip
       (Pi ((A U)
            (D U))
           (-> (Pair A D)
               (Pair D A))))

(define flip
  (lambda (A D)
    (lambda (p)
      (cons (cdr p) (car p)))))

;; lambda-expression's type can be a Pi-expression
;; both -> and Pi describe lambda-expressions

(flip Nat Atom)
((flip Nat Atom) (cons 17 'apple))

;; Pi is like lambda-expr but for types
;; Pi feels like type-classes in Haskell

;;;; ---->> up
;; now defining elim-Pair

;; to be (Pi ((Y U)) X) -> to be a lambda-expr that, when applied to a type T,
;; results in an expression with the type that is the result of consistently
;; replacing every Y in X with T... It can also be an expression whose value is
;; such a lambda-expression

(claim twin-Nat
       (-> Nat (Pair Nat Nat)))

(define twin-Nat
  (lambda (n)
    (cons n n)))

(twin-Nat 5)

(claim twin-Atom
       (-> Atom (Pair Atom Atom)))

(define twin-Atom
  (lambda (a)
    (cons a a)))

(twin-Atom 'test)

;; more generic -> use Pi

(claim twin
       (Pi ((A U))
           (-> A (Pair A A))))

(define twin
  (lambda (Y)
    (lambda (a)
      (cons a a))))

((twin Nat) 5)
;((twin (Pair Nat Nat)) (Pair 12 13)) ;; not sure why this doesnt work
;; expected U but given Nat
