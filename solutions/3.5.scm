;;; Exercise 3.5
;;; Author: Evan Ezell

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
            (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((x (random 10000))
        (y (random 10000)))
    (let ((min-v (min x y))
          (max-v (max x y)))
      (+ (* (/ min-v max-v)
            (- high low))
         low))))

(define (rect-area x1 y1 x2 y2)
  (* (abs (- y2 y1))
     (abs (- x2 x1))))

(define (estimate-integral p x1 y1 x2 y2 trials)
  (define (test)
    (p (random-in-range x1 x2) (random-in-range y1 y2)))
  (* (rect-area x1 y1 x2 y2) (monte-carlo trials test)))

(define (circle-predicate x y r)
  (lambda (test-x test-y)
    (< (+ (square (- test-x x))
          (square (- test-y y)))
       (* r r))))

(define (estimate-pi trials)
  (define pred (circle-predicate 0 0 1))
  (estimate-integral pred -1 -1 1 1 trials)) 
