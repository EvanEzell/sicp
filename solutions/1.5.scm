;;; Exercise 1.5
;;; Author: Evan Ezell

(define (p) (p))
;;; procedure p has no formal parameters, and the body calls itself
;;; recursively again and again

(define (test x y)
  (if (= x 0)
      0
      y))

;; (test 0 (p))
;;; applicative-order
;;; evaluates arguments first resulting in an infinite loop caused
;;; by the procedure p

;;; normal-order
;;; fully expands the expression and does not evaluate until necessary
;;; since x is 0, 0 is returned and p is never evaluated
