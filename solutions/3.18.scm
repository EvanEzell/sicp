;;; Exercise 3.18
;;; Author: Evan Ezell
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (make-cycle x) (append! x x))

(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) #t)
        (else (memq item (cdr x)))))

(define (cycle? x)
  (let ((visited '()))
    (define (c-helper x)
      (cond ((not (pair? x)) #f)
            ((memq x visited) #t)
            (else (begin (set! visited (cons x visited))
                       (or (c-helper (car x))
                           (c-helper (cdr x)))))))
  (c-helper x)))

(cycle? (list 'a 'b 'c))
; false

(define w (cons 'a 'b))
(define x (cons w 'd))
(cycle? (cons w x))
; true

(define y (cons 'a '()))
(define z (cons y y))
(cycle? (cons z z))
; true

(cycle? (make-cycle (list 'a 'b 'c)))
; true
