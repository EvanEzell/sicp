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

(define x-painter
  (let ((segment-list (list (make-segment (make-vect 0 0) (make-vect 1 1))
                            (make-segment (make-vect 1 0) (make-vect 0 1)))))
    (segments->painter segment-list)))

(define diamond-painter
  (let ((segment-list (list (make-segment (make-vect 0.5 0.0) (make-vect 1.0 0.5))
                            (make-segment (make-vect 1.0 0.5) (make-vect 0.5 1.0))
                            (make-segment (make-vect 0.5 1.0) (make-vect 0.0 0.5))
                            (make-segment (make-vect 0.0 0.5) (make-vect 0.5 0.0)))))
    (segments->painter segment-list)))
    
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

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define wave-smile-painter
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
                                          (make-vect 0.70 0.00))
                            (make-segment (make-vect 0.46 0.80)
                                          (make-vect 0.50 0.80))
                            (make-segment (make-vect 0.44 0.90)
                                          (make-vect 0.45 0.90))
                            (make-segment (make-vect 0.51 0.90)
                                          (make-vect 0.52 0.90))))) 
    (segments->painter segment-list)))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              (make-vect 1.0 0.0)
                              split-point))
          (paint-top
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.5)
                              (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up x-painter))
              (bottom-right (below diamond-painter right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (rotate-180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz rotate-180
                                  rotate-180 flip-vert)))
    (combine4 (corner-split painter n))))

(define unit-frame (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500)))
((square-limit wave-smile-painter 1) unit-frame)
