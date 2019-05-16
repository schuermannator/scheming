#lang racket

;; From lib
(define (blank? str)
  (for/and ([c (in-string str)])
    (char-blank? c)))

(define (string->datum str)
  (unless (blank? str)
    (let ([result (read (open-input-string (format "(~a)" str)))])
      (if (= (length result) 1)
          (car result)
          result))))

(define (datum? x) (or (list? x) (symbol? x)))

(define (format-datum datum-template . args)
  (unless (datum? datum-template)
    (raise-argument-error 'format-datums "datum?" datum-template))
  (string->datum (apply format (format "~a" datum-template)
                        (map (λ (arg) (if (syntax? arg)
                                          (syntax->datum arg)
                                          arg)) args))))

(define (format-datums datum-template . argss)
  (unless (datum? datum-template)
    (raise-argument-error 'format-datums "datum?" datum-template))
  (apply map (λ args (apply format-datum datum-template args)) argss))

;;;; end lib

;; every racket language has a 1. reader and 2. expander

;; first thing Racket calls for a language is 'read-syntax' function
;; (by convention)
;; path to source file and a port for reading data from the file
;; returns code describing a module, packaged as a syntax object.
(define (read-syntax path port)
  (define src-lines (port->lines port)) ;; port->lines is a function that reads port
  (define src-datums (format-datums '(handle ~a) src-lines))
  (define module-datum `(module stacker stacker.rkt ;; quasiquote, and using stack.rk as expd.
                          ,@src-datums)) ;; unquote (,) and unquote-splicing (@)
  (datum->syntax #f module-datum))
(provide read-syntax)

;;;; Module as a syntax obj. out of read-syntax and into expander
;; (module stacker-mod "stacker.rkt"
;;   (handle)
;;   (handle 4)
;;   (handle 8)
;;   (handle +)
;;   (handle 3)
;;   (handle *))

;; expander uses macros
;; entry point for every expander must be the #%module-begin macro
;; (#%module-begin
;;   (handle)
;;   (handle 4)
;;   (handle 8)
;;   (handle +)
;;   (handle 3)
;;   (handle *))

(define-macro (stacker-module-begin ...)
  #'(#%module-begin
     ...))
(provide (rename-out[stacker-module-begin #%module-begin]))
