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
(define plus 
  (lambda (a1 a2)
    (cond
     ((zero? a2) a1)
     (else (plus (add1 a1) (sub1 a2))))))

(plus 5 6)

(define minus
  (lambda (a1 a2)
    (cond
     ((zero? a2) a1)
     (else (minus (sub1 a1) (sub1 a2))))))

(minus 6 3)

; mess up
(define times
  (lambda (a1 a2)
    (cond
     ((zero? a2) 0)
     ((eq? a2 1) a1)
     (else (times (plus a1 a1) (sub1 a2))))))

; retry
(define times
  (lambda (m n)
    (cond
     ((zero? n) 0)
     (else (+ m (times m (sub1 n)))))))

(times 3 4)

(define tup '(1 3 4 6 10 11 9 1))

(define addtup
  (lambda (tup)
    (cond
     ((null? tup) 0)
     (else (+ (car tup) (addtup (cdr tup)))))))

(addtup tup)

;;; 5th commandment
; terminating cond: 0 for +, 1 for *, and () for cons

(define tup+
  (lambda (tup1 tup2)
    (cond
     ;((and (null? tup1) (null? tup2)) '())
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (else (cons (+ (car tup1) (car tup2)) (tup+ (cdr tup1) (cdr tup2)))))))


(define t1 '(3 6 9 11 4))
(define t2 '(8 5 2 0 7 69))
(tup+ t1 t2)

(> 10 55)
(< 10 55)

; greater than using zero? and sub1
(define gt
  (lambda (m n)
    (cond
     ((zero? m) '#f)
     ((zero? n) '#t)
     (else (gt (sub1 m) (sub1 n))))))

(gt 10 55)
(gt 55 10)

(define exp
  (lambda (n m)
    (cond
     ((zero? m) 1)
     (else (* n (exp n (sub1 m)))))))

(exp 2 5)

(define div
  (lambda (x y)
    (cond
     ((< x y) 0)
     (else (add1 (div (- x y) y))))))

(div 10 4)
(div 12 5)

;; length lat
(define length
  (lambda (lat)
    (cond
     ((null? lat) 0)
     (else (add1 (length (cdr lat)))))))

(length '(this is a test weee))

;; one-indexed 'pick'
(define pick
  (lambda (n lat)
    (cond
     ((zero? n) '())
     ((eq? n 1) (car lat))
     (else (pick (sub1 n) (cdr lat))))))

(pick 4 '(lasagna spaghetti ravioli macaroni meatball))
;; returns '() for zero index 

(define rempick
  (lambda (n lat)
    (cond
     ((zero? n) '())
     ((eq? n 1) (cdr lat))
     (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(rempick 4 '(lasagna spaghetti ravioli macaroni meatball))

(define no-nums
  (lambda (lat)
    (cond
     ((null? lat) '())
     ((number? (car lat)) (no-nums (cdr lat)))
     (else (cons (car lat) (no-nums (cdr lat)))))))

(no-nums '(5 pears 6 prunes 9 dates))

;; opposite from above
(define all-nums
  (lambda (lat)
    (cond
     ((null? lat) '())
     ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
     (else (all-nums (cdr lat))))))

(all-nums '(5 pears 6 prunes 9 dates))

(define eqan?
  (lambda (a1 a2)
    (cond
     ((and (number? a1) (number? a2)) (= a1 a2))
     ((or (number? a1) (number? a2)) #f)
     (else (eq? a1 a2)))))

(eqan? 5 zach)

;; count number of occurances of atom a in lat
(define occur
  (lambda (a lat)
    (cond
     ((null? lat) 0)
     ((eq? (car lat) a) (add1 (occur a (cdr lat))))
     (else (occur a (cdr lat))))))


(occur 'zach '(this is a zach test of zach for zach because zach a))

(define one?
  (lambda (n)
    (cond
     ((zero? n) #f)
     (else (zero? (sub1 n))))))

(one? 1)
(one? 6)

