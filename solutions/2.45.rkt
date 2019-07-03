; Exercise 2.45
; Author: Evan Ezell

#lang sicp
(#%require sicp-pict)

(define (split where how)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split where how) painter (- n 1))))
          (where painter (how smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(paint (up-split einstein 1))

(paint (right-split einstein 1))
