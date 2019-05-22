#lang pie

(claim test (-> Atom Atom))
(define test
  (lambda (a)
    a))

(test 'test)

(claim expectations
       (List Atom))
(define expectations
  (:: 'cooked
      (:: 'eaten
          (:: 'cleaned
              (:: 'understood
                  (:: 'slept
                      (:: 'rested nil)))))))

;; nil here is not an Atom
;; List is a type constructor. if E is a type, then (List E) is a type
;; [list of entries of type E]
;; nil is a constuctor
;; :: is the other constructor (this is 'cons')

(claim rug (List Atom))
(define rug
  (:: 'one
      (:: 'two
          (:: 'three nil))))

(claim step-length-atom
       (-> Atom (List Atom) Nat Nat))
(define step-length-atom
  (lambda (e es len-es)
    (add1 len-es)))

(claim length-atom (-> (List Atom) Nat))
(define length-atom
  (lambda (l)
    (rec-List
     l
     0
     step-length-atom)))

(claim length
       (Pi ((E U))
           (-> (List E) Nat)))
(claim step-length
       (Pi ((A U))
           (-> A (List A) Nat Nat)))
(define step-length
  (lambda (T)
    (lambda (e es len-es)
      (add1 len-es))))
(define length
  (lambda (T)
    (lambda (l)
      (rec-List
       l
       0
       (step-length T)))))

((length Atom) rug)

(claim length-Atom (-> (List Atom) Nat))
(define length-Atom (length Atom))

(length-Atom rug)
