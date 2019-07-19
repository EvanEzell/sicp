;;; Exercise 1.7
;;; Author: Evan Ezell

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
		 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (improve guess x) guess))
     (* guess .0001)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;;; For a small square root, one that's smaller than our threshold of .0001,
;;; the procedure produces a result which is the first guess less than .0001
;;; regardless of whether the result was close to the actual square root.
;;; For very large numbers, since operation is performed with limited
;;; precision, it is likely that the square of the guess will produce
;;; incorrect, values leading to a miscalculation of the true difference
;;; between the radicand and the square.

;; small example
;; (sqrt .00000001) -> .0078
;; (square .0078) -> .000061
;; .000061 is not close to .00000001

(define (good-enough? guess x)
  (< (abs (- (improve guess x) guess))
     (* guess .0001)))
