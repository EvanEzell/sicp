;;; Exercise 2.6
;;; Author: Evan Ezell

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (+ n1 n2)
  (lambda (f) (lambda (x) ((n1 n2) x))))
