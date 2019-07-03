; Exercise 1.30
; Author: Evan Ezell

; Make sum procedure spawn an iterative process

; (define (sum term a next b)
;   (define (iter a result)
; 	(if <??>
; 	    <??>
; 		(iter <??> <??>)))
;   (iter <??> <??>))

(define (sum term a next b)
  (define (iter a result)
	(if (> a b)
	    result
		(iter (next a) (+ result (term b)))))
  (iter a 0))
