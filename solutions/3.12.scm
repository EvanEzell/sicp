;;; Exercise 3.12 
;;; Author: Evan Ezell

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z
(a b c d)
(cdr x)

; response is (b)

(define w (append! x y))
w
(a b c d)
(cdr x)

; response is (b c d)
