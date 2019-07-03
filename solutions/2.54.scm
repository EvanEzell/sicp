; Exercise 2.54
; Author: Evan Ezell

(define (equal? a b)
  (if (and (pair? a) (pair? b))
      (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b)))
      (if (and (number? a) (number? b))
          (= a b)
          (eq? a b))))
