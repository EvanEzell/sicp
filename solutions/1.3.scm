;;; Exercise 1.3
;;; Author: Evan Ezell

(define foo (lambda (x y z))
  (define (sum-of-squares a b) (+ (* a a) (* b b)))
  (cond ((and (>= x z) (>= y z)) (sum-of-squares x y))
        ((and (>= y x) (>= z x)) (sum-of-squares y z))
        ((and (>= x y) (>= z y)) (sum-of-squares x z))))
