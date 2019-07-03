; Exercise 2.27
; Author: Evan Ezell

(define (deep-reverse items)
  (define (iter items rev-items)
    (cond ((null? items) rev-items)
          ((not (pair? items)) items)
          (else (iter (cdr items) 
                      (cons (deep-reverse (car items)) rev-items)))))
  (iter items '()))

(define x (list (list 1 2) (list 3 4)))

(deep-reverse x)
;Value 86: ((4 3) (2 1))