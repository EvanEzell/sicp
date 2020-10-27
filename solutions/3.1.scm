;;; Exercise 3.1 
;;; Author: Evan Ezell

(define (make-accumulator augend)
  (lambda (addend)
    (begin (set! augend (+ augend addend))
           augend)))
