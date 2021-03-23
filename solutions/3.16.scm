;;; Exercise 3.16 
;;; Author: Evan Ezell

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(count-pairs (cons (cons 'a '()) (cons 'b '())))
; 3

(count-pairs (cons (cons 'a '()) (cons (cons 'c '()) '())))
; 4

(count-pairs (cons (cons (cons (cons 'a '()) '()) '()) (cons (cons (cons 'b '()) '()) '())))
; 7

(count-pairs (make-cycle (list 'a 'b 'c)))
; never returns

; anytime their is a pointer back to pair more than once,
; either via a cycle or a shared reference, count-pairs will not work
