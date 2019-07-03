; Exercise 2.85
; Author: Evan Ezell

; general drop procedure
(define (drop data-object) (apply-generic 'drop data-object))

; add the following to the complex package
(define (drop complex)
  (if (= (imag-part complex) 0)
      (drop (make-real (real-part complex)))
      complex))
(put 'drop 'complex drop)

; add the following to the real package
(define (drop real)
  (if (and (integer? (numer real))
           (integer? (denom real)))
      (make-rational (numer real) (denom real))
      real))
(put 'drop 'real drop)

; add the following to the rational package
(define (drop rational)
  (if (= (denom rational) 1)
      (drop (make-integer (numer rational)))
      rational))
(put 'drop 'rational drop)

; add the following to the integer package
(put 'drop 'integer (lambda (integer) integer))
