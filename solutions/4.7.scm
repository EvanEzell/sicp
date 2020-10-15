; Exercise 4.7
; Author: Evan Ezell

; let* can be written as a set of nested let expressions
; by using each binding in one let expression and the 
; following bindings in the body. When there are no more
; bindings the body of the let should be the body of the
; expression.

(define (let*-body exp)
  (cddr exp))

(define (let*-bindings exp)
  (cdr exp))

(define (make-let bindings body)
  (list 'let bindings body))

(define (let*->nested-lets exp)
  (define (nest-lets bindings)
    (if (null? bindings)
      (let*-body exp)
      (make-let (first bindings) (nest-lets (rest bindings)))))
  (nest-lets (let*-bindings exp)))

; We do not have to explicitly expand let* in terms of
; non-derived expressions. The evaluator will send the
; expression off to apply, which will then send it back
; to eval to reduce the nested let expressions. These
; have been defined so we're good.
