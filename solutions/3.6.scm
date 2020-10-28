;;; Exercise 3.6
;;; Author: Evan Ezell

(define rand
  (let ((x random-init))
    (lambda (msg)
      (cond ((eq? msg 'reset)
             (lambda (value) (set! x value)))
            ((eq? msg 'generate)
             (begin (set! x (rand-update x))
                    x))
            (else (error "Invalid msg"))))))
