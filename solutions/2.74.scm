; Exercise 2.74
; Author: Evan Ezell

; We can think of the abstraction of headquarters system as the following
; diagram.
;
;                   headquarters-record package
;                      _____________________                      
;                     |      get-record     |
;_____________________|      get-salary     |_____________________________
;                     |find-employee-record |
;                     -----------------------
;      div 1            |       div ...    |             div n 
;      file             |       file       |             file
; representation        |  representation  |         representation
;                       |                  |                 

; file-object constructor
(define (make-file-object division file)
  (cons division file))

; file-object selectors
(define (division file-object) (car file-object))
(define (file file-object) (cdr file-object))

; record-object constructor
(define (make-record-object division file)
  (cons division record))

; record-object selectors
(define (division record-object) (car record-object))
(define (record record-object) (cdr record-object))

; Question A
(define (get-record employee file-object)
  ((get 'get-record (division file-object)) employee))

; Question B
(define (get-salary record-object)
  ((get 'get-salary (division record-object)) (record file-object)))

; Question C
(define (find-employee-record employee files)
  (if (null? files) 
    false ; record not found
    (let ((record (get-record employee (car files))))
      (if (record)
          record
          (find-employee-record employee (cdr files))))))

; Question D
; Each division needs to write their own implementations of the 
; get-record and get-salary procedures.
