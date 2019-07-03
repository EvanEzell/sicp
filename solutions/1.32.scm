; Exercise 1.32
; Author: Evan Ezell

; We can generalize sum and product to a more
; general procedure. Let's look at the similarities
; between the two procedures:

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (product term a next b)
  (if (< a b)
	  1
	  (* (term a)
		 (product term (next a) next b))))

; There are only two difference between these two procedures,
; the 0 in sum and 1 in product and the operators (+ and *). 
; We can generalize the 0 and 1 to be the null-value and the
; + and * to be a combiner.

; A more general procedure follows:

; The recursive process version
(define (accumulate combiner null-value term a next b)
  (if (< a b)
	  null-value
	  (combiner (term a)
				(accumulate combiner null-value term (next a) next b))))

; The iterative process version
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
	(if (< a b)
	    result
		(iter (next a) (combiner result (term a)))))
  (iter a null-value))


; sum in terms of accumulate
(define (sum term a next b)
  (accumulate + 0 term a next b))

; product in terms of accumulate
(define (product term a next b)
  (accumulate * 1 term a next b))
