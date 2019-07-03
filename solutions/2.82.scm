; Exercise 2.82
; Author: Evan Ezell

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
	(let ((proc (get op type-tags)))
	  (if proc
		  (apply proc (map contents args))
          (iter type-tags args op)))))

; tries to coerce entire list to type
; if it fails, return false
; if it succeeds, return coerced args
(define (coerc-iter type args)
  (cond ((null? args) '())
        ((equal? type (type-tag (car args)))
         (cons (car args) (coerc-iter type (cdr args))))
        (else
          (let ((proc (get-coercion type-tag (type-tag (car args)))))
            (if proc
                (cons (apply-generic proc (car args)) 
                      (coerc-iter type (cdr args)))
                false)))))

; try to coerce all args to each type in type-tags list
; if it succeeds for a type, try and find a procedure for all
; of those types
; if can't find a procedure after all possible coercions,
; report error
(define (iter type-tags args op)
  (if (null? type-tags)
      (error "No method for these types")
      (let ((coerced-args (coerc-iter (car type-tags) args)))
        (if coerced-args
            (let ((proc (get op (map type-tag coerced-args))))
              (if proc
                  (apply-generic proc coerced-args)))
        (iter (cdr type-tags) args)))))

; Trying to coerce all the arguments to the first type, then to the
; second type, etc. is not general enough. 
; If there is an operation that takes different argument types, this
; will not work. Also, if both arguments can be converted to an 
; entirely different argument type and the operation applied, this
; strategy will not work.
