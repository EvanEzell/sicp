; Exercise 1.44
; Author: Evan Ezell

(define (compose f g)
  (lambda (x) (f (g x))))

; iterative version
(define (repeated f n)
  (define (iter cf counter)
	(if (= counter n)
	  cf
	  (iter (compose f cf) (+ counter 1))))
  (iter f 1))

(define (smooth f)
  (let ((dx .0001))
	(lambda (x) (/ (+ (f (- x dx))
					  (f x)
					  (f (+ x dx)))
				   3))))

(define (n-fold-smooth f n)
  (repeated (smooth f) n))
