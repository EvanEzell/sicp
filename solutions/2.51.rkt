#lang racket/gui
(require graphics/graphics)
(open-graphics)
(define vp (open-viewport "A Picture Language" 500 500))

(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))


(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame f)
  (car f))

(define (edge1-frame f)
  (cadr f))

(define (edge2-frame f)
  (caddr f))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (let ((start-coord-map ((frame-coord-map frame) (start-segment segment)))
             (end-coord-map ((frame-coord-map frame) (end-segment segment))))
       (line
        (make-posn (xcor-vect start-coord-map) (ycor-vect start-coord-map))
        (make-posn (xcor-vect end-coord-map) (ycor-vect end-coord-map)))))
     segment-list)))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define wave-painter
  (let ((segment-list (list (make-segment (make-vect 0.50 0.40)
                                          (make-vect 0.60 0.00))
                            (make-segment (make-vect 0.50 0.40)
                                          (make-vect 0.40 0.00))
                            (make-segment (make-vect 0.30 0.00)
                                          (make-vect 0.35 0.65))
                            (make-segment (make-vect 0.35 0.65)
                                          (make-vect 0.15 0.55))
                            (make-segment (make-vect 0.15 0.55)
                                          (make-vect 0.00 0.80))
                            (make-segment (make-vect 0.00 0.90)
                                          (make-vect 0.20 0.70))
                            (make-segment (make-vect 0.20 0.70)
                                          (make-vect 0.30 0.75))
                            (make-segment (make-vect 0.30 0.75)
                                          (make-vect 0.40 0.75))
                            (make-segment (make-vect 0.40 0.75)
                                          (make-vect 0.35 0.90))
                            (make-segment (make-vect 0.35 0.90)
                                          (make-vect 0.40 1.00))
                            (make-segment (make-vect 0.55 1.00)
                                          (make-vect 0.60 0.90))
                            (make-segment (make-vect 0.60 0.90)
                                          (make-vect 0.55 0.75))
                            (make-segment (make-vect 0.55 0.75)
                                          (make-vect 0.65 0.75))
                            (make-segment (make-vect 0.65 0.75)
                                          (make-vect 1.00 0.45))
                            (make-segment (make-vect 1.00 0.30)
                                          (make-vect 0.60 0.65))
                            (make-segment (make-vect 0.60 0.65)
                                          (make-vect 0.70 0.00))))) 
    (segments->painter segment-list)))

;(define (below painter1 painter2)
;  (let ((split-point (make-vect 0.0 0.5)))
;    (let ((paint-bottom (transform-painter painter1
;                                           (make-vect 0.0 0.0)
;                                           (make-vect 1.0 0.0)
;                                           split-point))
;          (paint-top (transform-painter painter2 
;                                        split-point
;                                        (make-vect 1.0 0.5)
;                                        (make-vect 0.0 1.0))))
;      (lambda (frame)
;        (paint-bottom frame)
;        (paint-top frame)))))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (rotate-180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (rotate-270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (below painter1 painter2)
  (rotate-270 
   (rotate-180 
    (beside 
     (rotate-270 painter1) (rotate-270 painter2)))))

(define unit-frame (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500)))
((below wave-painter wave-painter) unit-frame)
