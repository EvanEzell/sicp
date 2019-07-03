; Exercise 2.59
; Author: Evan Ezell

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((not (element-of-set? (car set1) set2)) 
         (union-set (cdr set1) (cons (car set1) set2)))
        (else (union-set (cdr set1) set2))))
