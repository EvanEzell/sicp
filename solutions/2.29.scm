; Exercise 2.29
; Author: Evan Ezell

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

(define (total-weight mobile)
  (cond ((null? mobile) 0)
        ((not (pair? mobile)) mobile)
        (else (+ (total-weight (branch-structure (left-branch mobile)))
                 (total-weight (branch-structure (right-branch mobile)))))))

(define (balanced? mobile)
  (if (number? mobile)
      true
      (let ((left-torque (* (branch-length (left-branch))
                            (total-weight (left-branch))))
            (right-torque (* (branch-length (right-branch))
                             (total-weight (right-branch)))))
        (and (= left-torque right-torque)
             (balanced? (branch-structure (left-branch mobile)))
             (balanced? (branch-structure (left-branch mobile)))))))
