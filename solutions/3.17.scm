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

(define (find x visited)
  (cond ((null? visited) #f)
        ((eq? x (car visited)) #t)
        (else (find x (cdr visited)))))

(define (count-pairs x)
  (define (cp-helper x visited)
    (if (or (not (pair? x)) 
            (find x visited))
        0   
        (begin (append! visited (cons x '()))
               (+ (cp-helper (car x) visited)
                  (cp-helper (cdr x) visited)
                  1))))
  (cp-helper x (list '())))


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
