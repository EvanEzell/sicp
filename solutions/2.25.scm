; Exrcise 2.25
; Author: Evan Ezell

(define foolist (list 1 3 (list 5 7) 9))

foolist
;Value 66: (1 3 (5 7) 9)

(car (cdr (car (cdr (cdr foolist)))))
;Value: 7

(define barlist (list (list 7)))

barlist
;Value 67: ((7))

(car (car barlist))
;Value: 7

(define bazlist (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

bazlist
;Value 68: (1 (2 (3 (4 (5 (6 7))))))

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr bazlist))))))))))))
;Value: 7