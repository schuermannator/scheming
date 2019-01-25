;;; load prereqs
(load "../prereqs.scm")

; check if something is in a list of atoms
(define member?
  (lambda (a l)
    (cond
     ((null? l) #f)
     (else (or (eq? (car l) a) (member? a (cdr l)))))))

; remove a member from a list of atoms
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) a) (cdr lat))
     (else (cons a (rember (cdr lat)))))))

(rember 'a '(a v d))

; check if something is a list of atoms
(define lat?
  (lambda (l)
    (cond
     ((null? l) #t)
     (else (and (atom? (car l)) (lat? (cdr l)))))))

; test lat
(lat? '(a b c '(d e)))
(lat? '(a c v dsa vd j))
(lat? '(a b (c) d))


