; cons-ing lists
(load "../prereqs.scm")
; there was more stuff about rember

;;; Second commandment: use 'cons' to build lists

(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     (else (cond
            ((eq? (car lat) a) (cdr lat))
            (else (cons (car lat) (rember a (cdr lat)))))))))

(define remberall
  (lambda (a lat)
    (cond
     ((null? lat) '())
     (else (cond
            ((eq? (car lat) a) (remberall a (cdr lat)))
            (else (cons (car lat) (remberall a (cdr lat)))))))))

;; I'm an animal

(rember 'a '(b b d a c a e))
(remberall 'a '(b b d a c a e))

;; Simplification:
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) a) (cdr lat))
     (else (cons (car lat) (rember a (cdr lat)))))))

(rember 'a '(b b d a c a e))


; write the function "firsts"
(define firsts
  (lambda l
    (cond
     ((null? l) '())
     (else (cons (car (car l) (firsts (cdr l))))))))

(define l '((apple peach poo)
            (plum pear sherry)
            (grape rasin pee)
            (bean carrot eggzima)))

(firsts l)





