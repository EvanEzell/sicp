; Exercise 1.38
; Author: Evan Ezell

(define (cont-frac n d k)
  (define (iter k result)
    (if (= k 0)
    result
    (iter (- k 1)
          (/ (n k) (+ (d k) result)))))
  (iter k 0))

(define e (+ (cont-frac (lambda (i) 1.0)
			(lambda (i)
			  (if (= (remainder i 3) 2)
			      (* 2 (ceiling (/ i 3)))
			      1))
			10)
	     2))

e
;Value: 2.7182817182817183










