; Exercise 1.27
; Author: Evan Ezell

;; Carmichael numbers
;; Numbers that fool the Fermat test
;; Examples: 561, 1105, 1729, 2465, 2821, 6601

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))        

(define (congruent? x y) (= x y))

(define (fermat-test n)
  (define (try-it a)
	(if (< a n)
    	(if (congruent? (expmod a n n) (remainder a n))
	    	(try-it (+ a 1))
			false)
		true))
(try-it 1)
