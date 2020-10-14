; Exercise 4.1
; Author: Evan Ezell

; explicitly force evaluation order

; evaluate from left to right
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((left (eval (first-operand exps) env)))
      (cons left
            (list-of-values (rest-operands exps) env)))))

; evaluate from right to left
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((right (list-of-values (rest-operands exps) env)))
      (cons (eval (first-operand exps) env)
            right))))
