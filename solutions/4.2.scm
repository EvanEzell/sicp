; Exercise 4.2
; Author: Evan Ezell

; a) Louis evaluator will do the following:
;    (define x 3)
; It will treat this as an application since it appears
; first in cond. Application should be reserved for any other
; compound expression.
;
; The application clause looks like this:
; ((application? exp)
;    (apply (eval (operator exp) env)
;    (list-of-values (operands exp) env)))
;
; Since exp is a pair the body is evaluated. Using substitution
; model:
; (apply (eval (operator (define x 3)) env)
; (list-of-values (operands (define x 3)) env))
;                 ||
; (apply (eval define) env)
; (list-of-values (x 3) env)
;
; From here proceding forward will result in invalid results no
; matter the order of evaluation of the underlying Lisp system.
;
; (apply (eval define) env) will result in an unbound variable
; error since (eval define) will satisfy variable? but has not
; been bound in env.
;
; (list-of-values (x 3) env) will result in either an unbound variable
; error if x has not been bound in env or will bind x to its value
; in one of the previous frames.
;
; In conclusion, Louis' new ordering of conditions will not work. The
; evaluator has the structure that the special forms must be tried first
; before a procedure application is tried. Since the ordering causes
; the evaluator to treat "define" as a variable expression and not the 
; special form define expression, the evaluator treats the expression as
; the wrong expression type yielding an unbound variable error or by
; binding the arguments in the wrong environment.

; b)
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
