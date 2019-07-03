; Exercise 1.40
; Author: Evan Ezell

; define cubic so that (newtons-method (cubic a b c) 1
; will approximate zeroes of x^3 + ax^2 + bx + c

(define (cubic a b c)
  (define (cube x) (* x x x))
  (lambda (x)
	(+ (cube x)
	   (* a (square x))
	   (* b x)
	   c)))
