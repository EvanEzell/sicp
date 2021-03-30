;;; Exercise 3.22
;;; Author: Evan Ezell


(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! item)
      (set! front-ptr item))
    (define (set-rear-ptr! item)
      (set! rear-ptr item))
    (define (empty-queue?) (null? front-ptr))
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (if (empty-queue?)
            (begin (set-front-ptr! new-pair)
                   (set-rear-ptr! new-pair))
            (begin (set-cdr! rear-ptr new-pair)
                   (set-rear-ptr! new-pair)))))
    (define (delete-queue!)
      (if (empty-queue?)
          (error "DELETE! called with an empty queue")
          (set-front-ptr! (cdr front-ptr))))
    (define (print-queue) (print front-ptr))
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            ((eq? m 'print-queue) print-queue)
           	(else (error "Unknown op on queue"))))
    dispatch))

(define q1 (make-queue))
((q1 'insert-queue!) 'a)
((q1 'front-queue))       ; a
((q1 'empty-queue?))      ; false
((q1 'insert-queue!) 'b)
((q1 'front-queue))       ; a
((q1 'print-queue))       ; (a b)
((q1 'delete-queue!))
((q1 'print-queue))       ; (b)
((q1 'delete-queue!))
((q1 'print-queue))       ; ()