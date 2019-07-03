; Exercise 2.79
; Author: Evan Ezell

; generic equality predicate
(define (equ? x y) (apply-generic 'equ? x y))

; scheme-number equality predicate
; the following goes inside the scheme-number package
(define (equ? x y) (= x y))
(put 'equ? '(scheme-number scheme-number) equ?)

; rational equality predicate
; the following goes inside the rational-number package
(define (equ? x y)
  (and (= (numer x) (numer y))
	   (= (denom x) (denom y))))
(put 'equ? '(rational rational) equ?)

; complex equality predicate
; the following goes inside the complex-number package
(define (equ? x y)
  (and (= (real-part x) (real-part y))
	   (= (imag-part x) (imag-part y))))
(put 'equ? '(complex complex) equ?)
