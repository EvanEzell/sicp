;;; Exercise 2.17
;;; Author: Evan Ezell

(define (last-pair foolist)
  (let ((next (cdr foolist)))
    (if (null? next)
        foolist
        (last-pair next))))
