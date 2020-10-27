;;; Exercise 3.3 
;;; Author: Evan Ezell

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      (error "Insufficient funds")))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define (dispatch psswd m)
    (cond ((not (eq? password psswd))
           (lambda (amount) (error "Incorrect password")))
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
    dispatch)
