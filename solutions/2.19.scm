;;; Exercise 2.19
;;; Author: Evan Ezell

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
          (+ (cc amount
                 (except-first-denomination
                   coin-values))
             (cc (- amount
                    (first-denomination
                      coin-values))
                 coin-values)))))

(define (first-denomination coin-values)
  (car coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (no-more? coin-values)
  (null? coin-values))

;;; The order of the list does not matter because our algorithm will try all
;;; possible combinations regardless of the order of coin-values. However,
;;; if we want to make change with the smallest number of coins the order of
;;; the list matters.
