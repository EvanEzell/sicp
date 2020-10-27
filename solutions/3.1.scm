;;; Exercise 3.1 
;;; Author: Evan Ezell

(define (make-accumulator init)
  (let ((total init))
    (lambda (value)
      (begin (set! total (+ total value))
             total))))
