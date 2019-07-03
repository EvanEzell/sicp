; Exercise 1.46
; Author: Evan Ezell

; iterative version
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (define (iter guess)
      (if (good-enough? guess)
          guess
          (iter (improve next))))
    (iter guess)))

; recursive version
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess)))))

(define (square-root x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.0001))
  (define (average x y) (/ (+ x y) 2))
  (define (improve guess) (average (/ x y) x)) 
  ((iterative-improve good-enough? improve) 1.0))

(define (fixed-point f first-guess)
  (define (good-enough? guess)
    (< (abs (- guess (f guess))) .00001))
  ((iterative-improve good-enough? f) first-guess))
