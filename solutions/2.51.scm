; Exercise 2.51
; Author: Evan Ezell

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom (transform-painter painter1
                                           (make-vect 0.0 0.0)
                                           split-point
                                           (make-vect 0.0 1.0)))
          (paint-top (transform-painter painter2 
                                        split-point
                                        (make-vect 0.0 1.0)
                                        (make-vect 1.0 0.5))))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)))))

(define (below painter1 painter2)
  (rotate-270 
   (rotate-180 
    (beside 
     (rotate-270 painter1) (rotate-270 painter2)))))
