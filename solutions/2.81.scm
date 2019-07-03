; Exercise 2.81
; Author: Evan Ezell

; Question A
; If the operation is not found in the table it will try to coerce the 
; two argument types. Since the argument types can now be coerced thanks
; to Louis procedures, apply-generic will be called again with the same
; arguments. We will be stuck in a never ending loop.

; Question B
; apply-generic works correctly, but in a roundabout way. If the operation
; is not found in the table for arguments of the same type, there is no
; need to try and coerce one to the other.

; Question C
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
	(let ((proc (get op type-tags)))
	  (if proc
		(apply proc (map contents args))
		(if (= (length args) 2)
		    (let ((type1 (car type-tags))
				  (type2 (cadr type-tags))
				  (a1 (car args))
				  (a2 (cadr args)))
			  (if (equal? type1 type2)
                (error "No method for these types"
                       (list op type-tags))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                          (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                          (apply-generic op a1 (t2->t1 a2)))
                        (else (error "No method for these types"
                                     (list op type-tags)))))))
            (error "No method for these types"
                   (list op type-tags)))))))
