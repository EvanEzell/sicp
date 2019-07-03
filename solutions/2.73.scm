; Exercise 2.73
; Author: Evan Ezell

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; Question A
; Instead of having each rule for derivative explicitly laid out in
; the deriv procedure, we can make it more generic by letting the
; procedure itself decide which deriv rule to apply. This is done
; by looking at the type of expression, in this case the operand, and
; applying the appropriate procedure for that derivative rule. The end
; result is a much cleaner generic deriv procedure. If one wants to add
; a new deriv rule, they just have to define a new deriv procedure for
; a given expression type and add it to the table. The beauty of this
; is that deriv does not have to change at all, cuspy!

; The number? and variable? are not included in the data-directed
; dispatch because the operator and operand procedures will not work 
; on a expression of type number and variable. You could say they are 
; "special" types.

; Question B
(define (install-sum-package)
  ;; internal procedures
  (define (addend exp) (cadr expr))
  (define (augend exp) (caddr expr))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))

  ;; interface to the rest of the system
  (put 'deriv '(+) deriv-sum)
  (put 'make-sum '+ make-sum)
  'done)

(define (install-product-package)
  ;; internal procedures
  (define (multiplier exp) (cadr exp))
  (define (multiplicand exp) (caddr exp))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (define (deriv-product exp var)
    (make-sum (make-product
                (multiplier exp)
                (deriv (multiplicand exp) var))
              (make-product
                (deriv (multiplier exp) var)
                (multiplicand exp))))

  ;; interface to the rest of the system
  (put 'deriv '(*) deriv-product)
  (put 'make-product '* make-product)
  'done)

; Question C
(define (install-exponentiation-package)
  ;; internal procedures
  (define (base x) (cadr x))
  (define (exponent x) (caddr x))
  (define (make-exponentiation base expt)
    (cond ((=number? base 0) 0)
          ((=number? expt 0) 1)
          ((=number? expt 1) base)
          (else (list '** base expt))))
  (define (deriv-exponentiation exp var)
    (make-product
      (make-product (exponent exp)
                    (make-exponentiation (base exp)
                                         (make-sum (exponent exp) -1)))
      (deriv (base exp) var)))

  ;; interface to the rest of the system
  (put 'deriv '(**) deriv-exponentiation)
  (put 'make-exponentiation '** make-exponentiation)
  'done)

; Question D
; The only thing that would need to be changed is the order of 
; arguments to the put procedures inside the internal deriv procedures.

; The abstraction layer diagram for the above system is below.
;
;                  derivative-arithmetic package
;                      _____________________                      
;                     |        deriv        |
;_____________________|       make-sum      |_____________________________
;                     |     make-product    |
;                     | make-exponentiation |
;                     -----------------------
;       +               |        *        |               **
;      plus             |     product     |         exponentiation
; representation        | representation  |         representation
;                       |                 |                 
