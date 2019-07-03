; Exercise 2.1
; Author: Evan Ezell

(define (make-rat n d) (cons n d))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (make-rat n d)
  (define (sign x) (if (< x 0) - +))
  (let ((g (gcd n d)))
    (cons ((sign d) (/ n g))
	  (abs (/ d g)))))
