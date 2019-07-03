; Exercise 1.33
; Author: Evan Ezell

; The recursive process version
(define (filtered-accumulate filter combiner null-value term a next b)
	(if (< a b)
	    null-value
		(if (filter a)
		    (combiner (term a) 
					  (filtered-accumulate filter combiner null-value term (next a) next b))
			(filtered-accumulate filter combiner null-value term (next a) next b))))

; The iterative process version; this is much cleaner and is more space efficient
(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
	(if (< a b)
	    result
		(if (filter a)
			(iter (next a) (combiner result (term a)))
			(iter (next a) result))))
  (iter a null-value))

; a) The sum of the squares of the prime numbers in the interval a to b
;    assuming prime? predicate is written

(define (sos-prime a b)
  (define (square x) (* x x))
  (define (inc x) (+ x 1))
  (filtered-accumulate prime? + 0 square a inc b))

; b) the product of all the positive integers less than n that are relatively
;    prime to n (i.e., all positive integers i < n such that GCD(i,n)=1)

(define (prod-rel-primes n)
  (define (rel-prime? x) (= (gcd x n) 1))
  (define (identity x) x)
  (define (inc x) (+ x 1))
  (filtered-accumulate rel-prime? * 1 identity 1 inc n))
