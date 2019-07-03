; Excercise 2.70
; Author: Evan Ezell

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))

;; decoding
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      '()
      (let ((next-branch
              (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode-1 (cdr bits) tree))
          (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

;; sets

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair)
                             (cdr pair))
                  (make-leaf-set (cdr pairs))))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((element-of-set? symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((element-of-set? symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "Symbol not in tree"))))

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (successive-merge nodes)
  (if (null? (cdr nodes))
      (car nodes)
      (let ((first-node (car nodes))
            (second-node (cadr nodes))
            (rest-of-nodes (cddr nodes)))
        (if (< (weight first-node) (weight second-node))
            (successive-merge (cons (make-code-tree first-node second-node) rest-of-nodes))
            (successive-merge (cons (make-code-tree second-node first-node) rest-of-nodes))))))


(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define pairs (list (cons 'A 2)
                    (cons 'BOOM 1)
                    (cons 'GET 2)
                    (cons 'JOB 2)
                    (cons 'SHA 3)
                    (cons 'NA 16)
                    (cons 'WAH 16)
                    (cons 'YIP 9)))

(define tree (generate-huffman-tree pairs))

(define message '(Get a job
                  Sha na na na na na na na na
                  Get a job
                  Sha na na na na na na na na
                  Wah yip yip yip yip yip yip yip yip yip
                  Sha boom))

(define code (encode message tree))
code
;Value 26: (1 1 1 1 1 0 1 1 1 1 0 1 1 1 1 1 1 1 1 1
;           1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 1 1 1 1
;           0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0
;           1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 
;           1 1 0 1 1 0 1 1 0 1 1 1 0 1 1 1 1 1 1 0)

(length code)
;Value: 100

; It takes 100 bits to encode the message.

(decode code tree)
;Value 25: (get a job 
;           sha na na na na na na na na 
;           get a job 
;           sha na na na na na na na na 
;           wah yip yip yip yip yip yip yip yip yip 
;           sha boom)

; If we were to encode the 8 symbol alphabet in fixed length codes
; then it would require 4-bits per symbol. For the message above with
; 36 symbols it would require 144 bits to encode the message.
