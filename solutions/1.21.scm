; Exercise 1.21
; Author: Evan Ezell

(define (smallest-divisor n)
  (define (find-divisor n test-divisor)
    (define (divides? a b) (= (remainder b a) 0))
    (cond ((> (square test-divisor) n) n)
	  ((divides? test-divisor n) test-divisor)
	  (else (find-divisor n (+ test-divisor 1)))))
  (find-divisor n 2))

(smallest-divisor 199)
;Value: 199

(smallest-divisor 1999)
;Value: 1999

(smallest-divisor 19999)
;Value: 7






























