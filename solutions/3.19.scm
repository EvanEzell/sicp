;;; Exercise 3.19
;;; Author: Evan Ezell

; Uses Floyd's algorithm

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (make-cycle x) (append! x x))

(define (cycle? x)
  (define (helper slow fast)
    (cond ((null? fast) #f)
          ((null? (cdr fast)) #f)
          ((null? (cddr fast)) #f)
          ((eq? slow fast) #t)
          (else (helper (cdr slow) (cddr fast)))))
  (if (null? x)
      #f
      (helper x (cdr x))))

(cycle? (list 'a 'b 'c)) ; false
(cycle? '()) ; false
(cycle? (make-cycle (list 'a 'b 'c))) ; true
