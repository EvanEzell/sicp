; Exercise 1.26
; Author: Evan Ezell

; Louis expmod procedure
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

;; When using the square procedure the argument is evaluated
;; one time then squared. When explicitly multiplying the
;; two factors, each must be evaluated. There is no need to
;; do this since each evaluation will always lead to the
;; same return value. Ultimately, this doubles the number
;; of computations when the exponent is even, resulting in
;; a O(n) process.
