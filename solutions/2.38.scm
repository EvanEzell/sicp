; Exercise 2.38.scm
; Author: Evan Ezell

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; (fold-right / 1 (list 1 2 3)) -> 3/2
(fold-right / 1 (list 1 2 3))
;Value: 3/2

; (fold-left / 1 (list 1 2 3)) -> 1/6
(fold-left / 1 (list 1 2 3))
;Value: 1/6

; (fold-right list nil (list 1 2 3)) -> (1 (2 (3 '())))
(fold-right list '() (list 1 2 3))
;Value 45: (1 (2 (3 ())))

; (fold-left list nil (list 1 2 3)) -> ((('() 1) 2) 3)
(fold-left list '() (list 1 2 3))
;Value 46: (((() 1) 2) 3)

; "op" must be a commutative operation for fold-left and
; fold-right to produce the same results (e.g. + and *)