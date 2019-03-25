#lang racket

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define src-datums (format-datums ''(handle ~a) src-lines))
  (define module-datum `(module stacker racket
                          ,@src-datums))
  (datum->syntax #f module-datum))
(provide read-syntax)
