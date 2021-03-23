;;; Exercise 3.16 
;;; Author: Evan Ezell

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(count-pairs (list 'a 'b 'c))
; 3

(define w (cons 'a 'b))
(define x (cons w 'd))

(count-pairs (cons w x))
; 4

(define y (cons 'a '()))
(define z (cons y y))
(count-pairs (cons z z))
; 7

;(count-pairs (make-cycle (list 'a 'b 'c)))
; never returns
