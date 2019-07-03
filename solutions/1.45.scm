; Exercise 1.45
; Author: Evan Ezell

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter cf counter)
	(if (= counter n)
	  cf
	  (iter (compose f cf) (+ counter 1))))
  (iter f 1))

; We need to experiment to see how many times
; we must damp a nth root function to keep it
; from oscillating.

; We know that we must damp square root and cube
; root once, and the fourth root twice.
; Lets try out some higher order roots to see how
; many times we must average damp.

; We can explore this by implementing root with a
; user specified number of damps and  an iterator
; which tries to get the nth-root for each n.

(define (root x n)
  (let ((damps 5)
	(f (lambda (y) (/ x (expt y (- n 1))))))
  (fixed-point ((repeated average-damp damps) f) 1.0)))

(define (iter a b)
  (display "trying ")
  (display a)
  (newline)
  (root (expt 2 a) a)
  (if (< a b) (iter (+ a 1) b)))

; Now let's try some tests!

; damps <- 1
(iter 2 20)
; trying 2
; trying 3
; trying 4
;Quit!

; damps <- 2
(iter 4 20)
; trying 4
; trying 5
; trying 6
; trying 7
; trying 8
;Quit!

; damps <- 3
(iter 8 20)
; trying 8
; trying 9
; trying 10
; trying 11
; trying 12
; trying 13
; trying 14
; trying 15
; trying 16
;Quit!

; damps <- 4
(iter 16 70)
; trying 16
; trying 17
; trying 18
; trying 19
; trying 20
; trying 21
; trying 22
; trying 23
; trying 24
; trying 25
; trying 26
; trying 27
; trying 28
; trying 29
; trying 30
; trying 31
; trying 32
;Quit!

; damps <- 5
(iter 32 70)
; trying 32
; trying 33
; trying 34
; trying 35
; trying 36
;Floating-point overflow

; We can see that the number of damps should be the following:
; damps = floor( log(n) / log(2) )

(define (damp-number n)
  (floor (/ (log n) (log 2))))

(define (root x n)
  (let ((damps (damp-number n))
	(f (lambda (y) (/ x (expt y (- n 1))))))
  (fixed-point ((repeated average-damp damps) f) 1.0)))

; test to make sure it works
(iter 2 50)
; trying 2
; trying 3
; trying 4
; trying 5
; trying 6
; trying 7
; trying 8
; trying 9
; trying 10
; trying 11
; trying 12
; trying 13
; trying 14
; trying 15
; trying 16
; trying 17
; trying 18
; trying 19
; trying 20
; trying 21
; trying 22
; trying 23
; trying 24
; trying 25
; trying 26
; trying 27
; trying 28
; trying 29
; trying 30
; trying 31
; trying 32
; trying 33
; trying 34
; trying 35
; trying 36
;Floating-point overflow
