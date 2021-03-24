;;; Exercise 3.17
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

(define (count-pairs x)
  (let ((visited '()))
    (define (cp-helper x)
      (if (or (not (pair? x))
              (memq x visited))
          0
          (begin (set! visited (cons x visited))
                 (+ (cp-helper (car x))
                    (cp-helper (cdr x))
                    1))))
  (cp-helper x)))


(count-pairs (list 'a 'b 'c))
; 3

(define w (cons 'a 'b))
(define x (cons w 'd))

(count-pairs (cons w x))
; 3

(define y (cons 'a '()))
(define z (cons y y))
(count-pairs (cons z z))
; 3

(count-pairs (make-cycle (list 'a 'b 'c)))
; 3
