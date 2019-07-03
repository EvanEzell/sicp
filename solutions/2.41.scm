; Exercise 2.41
; Author: Evan Ezell

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (unique-triples n)
  (flatmap (lambda (i)
             (map (lambda (pair)
                    (append (list i) pair))
                  (unique-pairs (- i 1))))
           (enumerate-interval 1 n)))

(define (sum triple)
  (accumulate + 0 triple))

(define (triples-sum s n)
  (filter (lambda (triple) (= (sum triple) s))
          (unique-triples n)))
