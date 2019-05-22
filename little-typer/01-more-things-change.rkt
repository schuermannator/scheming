#lang pie

;; talking about atoms - similar to Scheme
;; tick + letter/hyphens is an atom
;; an Atom is a type

'atom
'test

;; Judgements: attitude taken towards an expression
;; "'atom is an atom"
;; ___ is a ___
;; ___ is the same ___ as ___
;; ___ is a type
;; ___ and ___ are the same type

;; in Lisp, cons makes lists longer - in Pie, just makes pairs
(claim first Atom)
(claim second Atom)
(define first 'atom)
(define second 'test)
(claim pair (Pair Atom Atom))
(define pair (cons first second))
pair
;;(cdr (cons first second))
;;(Pair first second)
;; normal form is most direct way of writing an expression
1

;; CLAIM BEFORE DEFINITION
;; using DEFINE to associate a name with an expr. requires that the
;; expression's type have been previously been associated with the
;; name using CLAIM
;; claims and defines are forever (immutable)

(claim one Nat)
(define one
  (add1 zero))

one

;; An expression with a constructor at the top is called a value
;; constructors of Nat are zero and add1, constructor of Pair is cons
;; not every value is a normal form since the arguments to a constructor
;; need not be normal

;; Everything in Pie is an expression

;; Atom and Nat and Pair are type constructors
