; Exercise 4.4
; Author: Evan Ezell

(put 'eval 'and
     (lambda (exp env) (eval-and exp)))

(put 'eval 'or
     (lambda (exp env) (eval-or exp)))

(define (eval-and exp)
  (define (eval-exps exps)
    (cond ((null? exps) 'true)
          ((true? (eval (first-exp exp))) (eval-and (rest-exp exp)))
          (else 'false)))
  (eval-exps (exp-list exp)))

(define (eval-or exp)
  (define (eval-exps exps)
    (cond ((null? exps) 'true)
          ((false? (eval (first-exp exp))) (eval-or (rest-exp exp)))
          (else 'true)))
  (eval-exps (exp-list exp)))

(define (first-exp exp)
  (car exp))

(define (rest-exp exp)
  (cdr exp))

(define (exp-list exp)
  (cdr exp))

; Alternative solution, as a macro:

(put 'eval 'and
     (lambda (exp env) (and->if exp)))

(put 'eval 'or
     (lambda (exp env) (or->if exp)))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (and->if exp)
  (define (expand-clauses exps)
    (if (null? exps)
        'true
        (make-if (first-exp exps)
                 (expand-clauses (rest-exp exps))
                 'false)))
  (expand-clauses (exp-list exp)))

(define (or->if exp)
  (define (expand-clauses exps)
    (if (null? exps)
        'true
        (make-if (first-exp exps)
                 'true
                 (expand-clauses (rest-exp exps)))))
  (expand-clauses (exp-list exp)))
