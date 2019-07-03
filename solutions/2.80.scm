; Exercise 2.80
; Author: Evan Ezell

; generic zero predicate

; scheme-number zero predicate
; the following goes inside the scheme-number package
(define (=zero? x) (= x 0))
(put '=zero? 'scheme-number =zero?)

; rational zero predicate
; the following goes inside the rational-number package
(define (=zero? x) (= (numer x) 0))
(put '=zero? 'rational =zero?)

; complex zero predicate
; the following goes inside the complex-number package
(define (=zero? x) (= (magnitude x) 0))
(put '=zero? 'complex =zero?)
