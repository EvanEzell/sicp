;;; Exercise 1.6
;;; Author: Evan Ezell

;;; Eva Lu Ator's if procedure
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; Eva's tests
;; (new-if (= 2 3) 0 5) -> 5
;; (new-if (= 1 1) 0 5) -> 0

;; Alyssa's rewrite of sqrt-iter using new-if
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

;;; Since sqrt-iter is passed as an argument to the procedure new-if it gets
;;; evaluated before the predicate good-enough?. Since sqrt-iter is a
;;; recursive procedure it keeps getting called and good-enough? is never
;;; evaluated. The difference in the built-in if and the new-if is the
;;; built-in is a special-form. This means it applies a different evaluation
;;; rule than the general evaluation rule. The general evaluation rule
;;; evaluates the sub-expressions first, which results in sqrt-iter always
;;; being called. The special-form if always evaluates the predicate first
;;; and then decides whether to evaluate the consequent or alternative.
