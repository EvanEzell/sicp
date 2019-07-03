; Exercise 2.28
; Author: Evan Ezell

(define (fringe tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (fringe (car tree))
                      (fringe (cdr tree))))))

(define x (list (list 1 2) (list 3 4)))

(fringe x)
;Value 29: (1 2 3 4)

(fringe (list x x))
;Value 31: (1 2 3 4 1 2 3 4)