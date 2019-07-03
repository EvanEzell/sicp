; Exercise 2.20
; Author: Evan Ezell

(define (same-parity first . items)
  (define (iter items)
    (if (null? items)
	'()
	(if (even? (+ (car items) first))
	    (cons (car items) (iter (cdr items)))
	    (iter (cdr items)))))
  (cons first (iter items)))

(same-parity 1 2 3 4 5 6 7)
;Value 40: (1 3 5 7)

(same-parity 2 3 4 5 6 7)
;Value 41: (2 4 6)
