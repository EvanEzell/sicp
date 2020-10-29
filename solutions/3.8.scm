;;; Exercise 3.8 
;;; Author: Evan Ezell

(define (make-f)
  (let ((var #t))
    (lambda (arg)
      (if (= arg 0)
        (begin (set! var #f)
               0)
        (if var 1 0)))))

(define f (make-f))

; my system is evaluating from right-to-left :)
