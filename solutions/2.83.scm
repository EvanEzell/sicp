; Exercise 2.83
; Author: Evan Ezell

; generic raise procedure
(define (raise data-object) (apply-generic 'raise data-object))

; put the following in the scheme-number package
(define (raise integer)
  (make-rational integer 1))
(put 'raise 'scheme-number raise)

; put the following in the rational package
(define (raise rational)
  (make-real (/ (numer rational) (denom rational))))
(put 'raise 'rational raise)

; put the following in the real package
(define (raise real)
  (make-from-real-imag real 0))
(put 'raise 'real raise)
