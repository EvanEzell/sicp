; Exercise 2.26
; Author: Evan Ezell

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)
;Value 73: (1 2 3 4 5 6)

(cons x y)
;Value 74: ((1 2 3) 4 5 6)

(list x y)
;Value 75: ((1 2 3) (4 5 6))