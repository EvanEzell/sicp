; Exercise 1.41
; Author: Evan Ezell

; A procedure, named double, that returns
; a procedure. The returned procedure applies
; the procedure passed as the argument to double
; twice.

(define (double proc)
  (lambda (x) (proc (proc x))))

; What value is returned by
; (((double (double double)) inc 5)?
; will produce 21: (((2)^2)^2) + 5

(((double (double double)) inc) 5)
;Value: 21