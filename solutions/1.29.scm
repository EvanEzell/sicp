; Exercise 1.29
; Author: Evan Ezell

; Integration via Simpson's Rule

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (simp-term f)
	(define (det-const k)
	  (if (and (> k 0) (< k n))
		  (if (even? k) 2 4)
		  1))
	(lambda (k) (* (det-const k)
				   (f (+ a (* k h))))))
  (sum (simp-term f) 0 inc n))
