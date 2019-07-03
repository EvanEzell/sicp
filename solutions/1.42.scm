; Exercise 1.42
; Author: Evan Ezell

; procedure that implements function
; composition

(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6)
;Value: 49