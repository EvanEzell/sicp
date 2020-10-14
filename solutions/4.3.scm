; Exercise 4.3
; Author: Evan Ezell

; Assume put adds procedure to the operation-and-type
; table. Assume get looks up procedure from the 
; operation-and-type table.

(define (type-tag exp)
  (car exp))

(define (contents exp)
  (cdr exp))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((get 'eval (type-tag exp))
         (contents exp)
         env)
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(put 'eval 'quoted
     (lambda (exp env) (text-of-quotation exp)))

(put 'eval 'assignment
     (lambda (exp env) (eval-assignment exp env)))

(put 'eval 'definition
     (lambda (exp env) (eval-definition exp env)))

(put 'eval 'if
     (lambda (exp env) (eval-if exp env)))
        
(put 'eval 'lambda
     (lambda (exp env)
       (make-procedure (lambda-parameters exp)
                       (lambda-body exp)
                       env)))

(put 'eval 'begin 
     (lambda (exp env)
       (eval-sequence (begin-actions exp) env)))

(put 'eval 'cond 
     (lambda (exp env)
        ((cond? exp) (eval (cond->if exp) env))))
