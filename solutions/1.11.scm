;;; Exercise 1.11
;;; f(n) = n for n<3
;;; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n>=3

;; recursive process
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
	 (* 2
	    (f (- n 2)))
	 (* 3
	    (f (- n 3))))))

;; iterative process
(define (f n)
  (f-iter 2 1 0 n))

(define (f-iter a b c count)
  (if (= count 0)
      c
      (f-iter (+ a
		 (* 2 b)
		 (* 3 c))
	      a
	      b
	      (- count 1))))
