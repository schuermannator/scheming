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
  (lambda (l)
    (cond
     ((null? l) '())
     (else (cons (car (car l)) (firsts (cdr l)))))))

(define l '((apple peach poo)
            (plum pear sherry)
            (grape rasin pee)
            (bean carrot eggzima)))

(firsts l)

;;; Third Commandment:
; When building a list, describe the first typical element and then cons it onto the natural recursion.

;;; insertR
; insert to the right

(define insertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old) (cons old (cons new (cdr lat))))
     (else (cons (car lat) (insertR new old (cdr lat)))))))

(define new 'topping)
(define old 'fudge)
(define lat '(ice cream with fudge for desert))

(insertR new old lat)

(insertR 'flowers 'smelly '(i like smelly))

(define insertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old) (cons new lat))
     (else (cons (car lat) (insertL new old (cdr lat)))))))

(insertL new old lat)

; substitute
(define subst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old) (cons new (cdr lat)))
     (else (cons (car lat) (subst new old (cdr lat)))))))

(subst new old lat)
          
; substitute
(define subst2
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) '())
     ((or (eq? (car lat) o1) (eq? (car lat) o2)) (cons new (cdr lat)))
     (else (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))

(subst2 new old 'cream lat)

(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) a) (multirember a (cdr lat)))
     (else (cons (car lat) (multirember a (cdr lat)))))))

(multirember 'test '(testing test through a test of tests test))


;;; Now implement muliinsertR, multiinsertL, multisubst

(define multiinsertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old) (cons old (cons new (multiinsertR new old (cdr lat)))))
     (else (cons (car lat) (multiinsertR new old (cdr lat)))))))

(multiinsertR 'extra 'good '(I had a good great really good day))

(define multiinsertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old) (cons new (cons old (multiinsertL new old (cdr lat)))))
     (else (cons (car lat) (multiinsertL new old (cdr lat)))))))

(multiinsertL 'extra 'good '(I had a good great really good day))

(define multisubst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat)) (cons new (multisubst new old (cdr lat))))
     (else (cons (car lat) (multisubst new old (cdr lat)))))))

(multisubst 'extra 'good '(I had a good great really good day))

;;;; Fourth Commandment
; Always change at least one argument while recurring
; The changed condition must be tested in the terminating condition
; i.e. test null? with cdr



