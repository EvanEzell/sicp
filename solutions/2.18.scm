; Exercise 2.18
; Author: Evan Ezell

(define (reverse items)
  (define (iter items rev-items)
    (if (null? items)
        rev-items
        (iter (cdr items) (cons (car items) rev-items))))
  (iter items '()))

(reverse (list 1 4 9 16 25))
;Value 78: (25 16 9 4 1)
