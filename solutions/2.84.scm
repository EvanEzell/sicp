; Exercise 2.84
; Author: Evan Ezell

(define (higher? x type)
  (if (eq? (type-tag x) type)
      false
      (let ((proc (get 'raise (type-tag x))))
        (if proc
            (if (eq? (type-tag (proc x)) type)
                false
                (higher? (proc x) y))
            true))))
          
(define (successive-raise x type)
  (if (eq? (type-tag x) type)
      x
      (successive-raise (raise x) type)))

(define (try-apply op args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          false))))
          


(define (apply-generic op . args)    
  (if (not (try-apply op args))
      (if (= (length args) 2)
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            (if (higher? a1 type2)
                (if (not (try-apply op args))
                    (error "No method for these types"
                           (list op type-tags)))
                (if (not (try-apply op args))
                    (error "No method for these types"
                           (list op type-tags)))
            
            (apply-generic op (successive-raise a1 type2) a2)))
      (error "No method for these types"
             (list op type-tags)))))))
