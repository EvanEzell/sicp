; Exercise 1.37
; Author: Evan Ezell

; recursive process version
(define (cont-frac n d k)
  (define (iter counter)
    (if (> counter k)
    0
    (/ (n k)
       (+ (d k) (iter (+ counter 1))))))
  (iter 1))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           4)
;Value: .6000000000000001

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           10)
;Value: .6179775280898876

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           20)
;Value: .6180339850173578


; iterative process version
(define (cont-frac n d k)
  (define (iter k result)
    (if (= k 0)
	result
	(iter (- k 1)
	      (/ (n k) (+ (d k) result)))))
  (iter k 0))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           20)
;Value: .6180339850173578