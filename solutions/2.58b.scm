; Exercise 2.58
; Author: Evan Ezell

(define (before-eq item x)
  (if (eq? (car x) item)
      '()
      (cons (car x)
            (before-eq item (cdr x)))))

(define (after-eq item x) (cdr (memq item x)))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (make-exponentiation base expt)
  (cond ((=number? base 0) 0)
        ((=number? expt 0) 1)
        ((=number? expt 1) base)
        (else (list base '** expt))))

(define (sum? x) (not (eq? (memq '+ x) false)))

(define (addend s) 
  (let ((result (before-eq '+ s)))
    (if (null? (cdr result))
        (car result)
        result)))

(define (augend s)
  (let ((result (after-eq '+ s)))
    (if (null? (cdr result))
        (car result)
        result)))

(define (product? x) (not (eq? (memq '* x) false)))

(define (multiplier p)
  (let ((result (before-eq '* p)))
    (if (null? (cdr result))
        (car result)
        result)))

(define (multiplicand p)
  (let ((result (after-eq '* p)))
    (if (null? (cdr result))
        (car result)
        result)))

(define (exponentiation? x) (not (eq? (memq '** x) false)))

(define (base expn)
  (let ((result (before-eq '** expn)))
    (if (null? (cdr result))
        (car result)
        result)))

(define (exponent expn)
  (let ((result (after-eq '** expn)))
    (if (null? (cdr result))
        (car result)
        result)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
           (make-product (exponent exp)
                         (make-exponentiation (base exp)
                                              (make-sum (exponent exp) -1)))
           (deriv (base exp) var)))
        (else
          (error "unknown expression type -- DERIV" exp))))
