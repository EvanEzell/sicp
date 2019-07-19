;;; Exercise 1.4
;;; Author: Evan Ezell

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;;; In this case if b > 0 the primitive operation + will be applied to
;;; arguments a and b. Else, primitive operation - will be applied. We
;;; can think of primitive operations + and - as data here. Instead of
;;; the if statement resulting in a numeric, it results in a procedure.
