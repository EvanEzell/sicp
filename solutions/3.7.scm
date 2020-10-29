;;; Exercise 3.7
;;; Author: Evan Ezell

; did not modify code from Exercise 3.3

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

(define (make-joint account password new-password)
  (define (dispatch psswd m)
    (if (not (eq? new-password psswd))
      (lambda (amount) (error "Incorrect password"))
      (account password m)))
  dispatch)
