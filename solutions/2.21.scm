; Exercise 2.21
; Author: Evan Ezell

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items))
            (cdr items))))

(define (square-list items)
  (map square items))
