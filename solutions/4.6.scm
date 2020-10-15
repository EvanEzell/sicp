; Exercise 4.6
; Author: Evan Ezell

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (let-arg-list exp) (cdr exp))
(define (let-par item) (car item))
(define (let-arg item) (cdr item))

(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))

(define (extract-let-body exp) (cddr exp))

(define (extract-let-pars exp)
  (map let-par (let-arg-list exp)))

(define (extract-let-args exp)
  (map let-arg (let-arg-list exp)))

(define (let->combination exp)
  (cons (make-lambda (extract-let-pars exp)
                     (extract-let-body exp))
        (extract-let-args exp)))

; assuming data-directed eval
(put 'eval 'let
     (lambda (exp env)
       (let->combination exp)))
