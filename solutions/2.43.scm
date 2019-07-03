; Exercise 2.43
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

(define (fast-queens board-size)
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

(define (slow-queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (position) (safe? k position))
         (flatmap
           (lambda (new-row)
             (map (lambda (rest-of-queens)
                    (adjoin-position new-row k rest-of-queens))
                  (queen-cols (- k 1))))
           (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

; This interchange makes the program run slowly because we have
; to recursively enumerate the rest-of-queens for each new-row
; we want to adjoin. In the previous definition of queens, we
; recursively enumerate the rest-of-queens once and adjoin the
; new-rows onto rest-of-queens, reusing the rest-of-queens list
; each time.

(define (fast-queens-test board-size)
  (newline)
  (display "fast-queens-test for board-size: ")
  (display board-size)
  (newline)
  (let ((start-time (runtime)))
    (fast-queens board-size)
    (display "*** ")
    (display (- (runtime) start-time))
    (display " ***")))

(define (slow-queens-test board-size)
  (newline)
  (display "slow-queens-test for board-size: ")
  (display board-size)
  (newline)
  (let ((start-time (runtime)))
    (slow-queens board-size)
    (display "*** ")
    (display (- (runtime) start-time))
    (display " ***")))

(fast-queens-test 6)

;fast-queens-test for board-size: 6
;*** 9.999999999990905e-3 ***
;Unspecified return value

(slow-queens-test 6)

;slow-queens-test for board-size: 6
;*** .6200000000000045 ***
;Unspecified return value

(fast-queens-test 7)

;fast-queens-test for board-size: 7
;*** .03999999999999204 ***
;Unspecified return value

(slow-queens-test 7)

;slow-queens-test for board-size: 7
;*** 11.549999999999983 ***
;Unspecified return value