; Exercise 2.23
; Author: Evan Ezell

(define (for-each proc items)
  (if (not (null? items))
      (begin (proc (car items))
	     (for-each proc (cdr items)))))

(for-each (lambda (x)
            (newline)
            (display x))
          (list 57 321 88))
;57
;321
;88
;Unspecified return value