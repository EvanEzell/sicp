; Exercise 2.42.scm
; Author: Evan Ezell

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
  (append (list new-row) rest-of-queens))

(define (safe? k position)
  (let ((cur-queen-row (car position)))
    (define (iter col position)
      (if (= col 0)
          true
          (let ((check-queen-row (car position)))
            (if (or (= cur-queen-row check-queen-row)
                    (= (+ cur-queen-row (- k col)) check-queen-row)
                    (= (- cur-queen-row (- k col)) check-queen-row))
                false
                (iter (- col 1) (cdr position))))))
    (iter (- k 1) (cdr position))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (position) (safe? k position))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))