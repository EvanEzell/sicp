; Exercise 2.63
; Author: Evan Ezell

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

; the following are three representations of the set
; {1, 3, 5, 7, 9, 11}

(define x (make-tree 7
		     (make-tree 3
				(make-tree 1 '() '())
				(make-tree 5 '() '()))
		     (make-tree 9
				'()
				(make-tree 11 '() '()))))

(tree->list-1 x)
;Value 26: (1 3 5 7 9 11)

(tree->list-2 x)
;Value 27: (1 3 5 7 9 11)

(define y (make-tree 3
		     (make-tree 1 '() '())
		     (make-tree 7 
				(make-tree 5 '() '())
				(make-tree 9 
					   '() 
					   (make-tree 11 '() '())))))
(tree->list-1 y)
;Value 28: (1 3 5 7 9 11)

(tree->list-2 y)
;Value 29: (1 3 5 7 9 11)

(define z (make-tree 5 
		     (make-tree 3 
				(make-tree 1 '() '()) 
				'())
		     (make-tree 9 
				(make-tree 7 '() '())
				(make-tree 11 '() '()))))

(tree->list-1 z)
;Value 30: (1 3 5 7 9 11)

(tree->list-2 z)
;Value 31: (1 3 5 7 9 11)

; tree->list-1 and tree->list-2 produce the exact same results; however,
; tree->list-1 grows at a rate of O(nlogn) while tree->list-2 grows at 
; a rate of O(n). This is due to the cost of cons vs append. Cons is 
; constant time where append is linear.
