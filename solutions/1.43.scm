; Exercise 1.43
; Author: Evan Ezell

(define (compose f g)
  (lambda (x) (f (g x))))

; iterative version
(define (repeated f n)
  (define (iter cf counter)
    (if (= counter n)
	cf
	(iter (compose f cf) (+ counter 1))))
  (iter f 1))

((repeated square 2) 5)
;Value: 625

; recursive version
(define (repetead f n)
  (if (= n 0)
      f
      (compose f (repeated f (- n 1)))))

((repeated square 2) 5)
;Value: 625
