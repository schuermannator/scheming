#lang pie

(claim step-+ (-> Nat Nat))
(define step-+ (lambda (n)
                 (add1 n)))

(claim + (-> Nat Nat Nat))
(define + (lambda (a b)
            (iter-Nat a
                      b
                      step-+)))

; (claim gausss (-> Nat Nat))
; (define gausss
;   (lambda (n)
;     (which-Nat n
;                0
;                (lambda (n-1)
;                  (+ (add1 n-1) (gausss n-1))))))


;; rec-Nat is PRIMITIVE RECURSION

(claim step-gauss (-> Nat Nat Nat))
(define step-gauss (lambda (ln lg)
                     (+ (add1 ln) lg)))

(claim gauss (-> Nat Nat))
(define gauss (lambda (n)
                (rec-Nat n
                         0
                         ;step-gauss)))
                         (lambda (lastn lastgauss)
                           (+ (add1 lastn) lastgauss)))))

(claim make-step-* (-> Nat (-> Nat Nat Nat)))
(define make-step-* (lambda (j)
                      (lambda (ln lnum)
                        (+ j lnum))))

(claim *old (-> Nat Nat Nat))
(define *old (lambda (a b)
            (rec-Nat a
                     0
                     (make-step-* b))))

(claim step-* (-> Nat Nat Nat Nat))
(define step-*
  (lambda (j ln lnum)
    (+ j lnum)))

(claim * (-> Nat Nat Nat))
(define * (lambda (a b)
            (rec-Nat a
                     0
                     (step-* b))))

;; CURRYING hell yeah


;; factorial 1 1 2 3 5 8
;; TODO
(claim step-factorial
       (-> Nat Nat
           Nat))
(define step-factorial
  (lambda (ln lnum)
    (+ (add1 ln) lnum)))

(claim factorial
       (-> Nat Nat))
(define factorial
  (lambda (n)
    (rec-Nat n
             0
             step-factorial)))
