;;; Exercise 2.12
;;; Author: Evan Ezell

(define (percent interval)
  (abs (/ (width interval)
          (center interval))))
