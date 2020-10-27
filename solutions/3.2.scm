;;; Exercise 3.2 
;;; Author: Evan Ezell

(define (make-monitored f)
  (let ((ctr 0))
    (define (mf m)
      (cond ((eq? m 'reset-count) (set! ctr 0))
            ((eq? m 'how-many-calls?) ctr)
            (else
              (begin (set! ctr (+ ctr 1))
                     (f m)))))
    mf))
