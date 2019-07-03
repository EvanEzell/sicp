; Exercise 1.34
; Author: Evan Ezell

(define (f g) (g 2))

(f square)
;Value: 4

; It helps to think of f defined using lambda notation

(define f (lambda (g) (g 2)))

; If we use the substitution method of evaluation we get
; the following:

; (f f)
; (f (lambda (g) (g 2)))
; ((lambda (g) (g 2)) (lambda (g) (g 2)))
; ((lambda (g) (g 2)) 2)
; (2 2)
; And we can see that (2 2) is not a valid expression

(f f)
;The object 2 is not applicable.
