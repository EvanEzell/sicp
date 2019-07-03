; Exercise 1.39
; Author: Evan Ezell

(define (cont-frac n d k)
  (define (iter k result)
    (if (= k 0)
    result
    (iter (- k 1)
          (/ (n k) (+ (d k) result)))))
  (iter k 0))

; continued fraction representation of the
; tangent function (J.H. Lambert, 1770)

(define (tan-cf x k)
  (cont-frac (lambda (i)
               (if (= i 1)
                   x
                   (* (square x) -1)))
	     (lambda (i) (- (* i 2) 1))
             k))

(define pi 3.14159265)

(tan-cf (/ pi 4) 4)
;Value: .9999978666208239