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


      
