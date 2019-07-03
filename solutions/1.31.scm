; Exercise 1.31
; Author: Evan Ezell

; product procedure that spawns a recursive process

(define (product term a next b)
  (if (< a b)
	  1
	  (* (term a)
		 (product term (next a) next b))))


; product procedure that spawns an iterative process

(define (product term a next b)
  (define (iter a result)
	(if (< a b)
	    result
		(iter (next a) (* result (term a)))))
  (iter a 1))


; factorial procedure defined in terms of product above

(define (factorial n)
  (define (inc x) (+ x 1))
  (define (identity x) x)
  (product identity 1 inc n))


; pi approximation written in terms of product above 
; using the John Wallis formula
; (pi/4) is aproximately (2/3)*(4/3)*(4/5)*(6/5)*(6/7)*(8/7)*...

(define (pi-apx n)
  (define (inc x) (+ x 1))
  (define (pi-term n)
	(if (even? n)
	    (/ (+ n 2) (+ n 1))
		(/ (+ n 1) (+ n 2))))
  (* 4
	 (product pi-term 1 inc n)))
