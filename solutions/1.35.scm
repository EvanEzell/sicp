; Exercise 1.35
; Author: Evan Ezell

; x -> 1 + 1/x
; If we plug in the golden ratio (1.6180) we get
; 1 + 1/(1.6180) = 1.6180
; Thus, the golden ratio is a fixed point of the
; function 1 + 1/x

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1)
;Value: 987/610