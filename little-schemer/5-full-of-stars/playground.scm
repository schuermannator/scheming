;;; *Oh My Gawd*: It's Full of Stars

(define rember*
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((atom? (car lat))
      (cond
       ((eq? (car lat) a) (rember* a (cdr lat)))
       (else (cons (car lat) (rember* a (cdr lat))))))
     (else (cons (rember* a (car lat)) (rember* a (cdr lat)))))))

(define l '((coffee) cup ((tea) cup) (and (hick)) cup))
(rember* 'cup l)

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? (car l) old) (cons old (cons new (insertR* new old (cdr l)))))
         (else (cons (car l) (insertR* new old (cdr l))))))
      (else (cons (insertR* new old (car l)) (insertR* new old (cdr l)))))))

(define li '((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood))
  
(insertR* 'roast 'chuck li)

(define occur*
  (lambda (a l)
    (cond 
      ((null? l) 0)
      ((atom? (car l))
       (cond 
         ((eq? (car l) a) (+ 1 (occur* a (cdr l))))
         (else (occur* a (cdr l)))))
      (else (+ (occur* a (car l)) (occur* a (cdr l)))))))

(define ll '((banana) (split ((((banana ice))) (cream (banana)) sherbert)) (banana) (bread) (banana brandy)))
(occur* 'banana ll)
