; Exercise 2.53
; Author: Evan Ezell

(define a 1)
(define b 2)

;: (list 'a 'b 'c) -> (a b c)
(list 'a 'b 'c)
;Value 26: (a b c)

;: (list (list 'george)) -> ((george))
(list (list 'george))
;Value 28: ((george))

;: (cdr '((x1 x2) (y1 y2))) -> ((y1 y2))
(cdr '((x1 x2) (y1 y2)))
;Value 29: ((y1 y2))

;: (cadr '((x1 x2) (y1 y2))) -> (y1 y2)
(cadr '((x1 x2) (y1 y2)))
;Value 30: (y1 y2)

;: (pair? (car '(a short list))) -> false
(pair? (car '(a short list)))
;Value: #f
 
;: (memq 'red '((red shoes) (blue socks))) -> false
(memq 'red '((red shoes) (blue socks)))
 ;Value: #f

;: (memq 'red '(red shoes blue socks)) -> (red shoes blue socks)
(memq 'red '(red shoes blue socks))
;Value 31: (red shoes blue socks)