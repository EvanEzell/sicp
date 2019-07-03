; Exercise 2.60
; Author: Evan Ezell

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set) (cons x set))

(define (union-set set1 set2) (append set1 set2))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; "intersection-set" and "element-of-set" are the same efficiency. However,
; since we allow multiples of the same item, it might be more likely that
; we find a match sooner - this is a double edge sword though - we may now
; have longer lists to search through if x is not in the set. "intersection-
; set" pretty much stays the same, but some lists may be longer since we are
; allowing duplicates.

; "adjoin-set" is now O(1), since we do not have to first search the set
; before adjoining - this is much faster than O(n) before. "union-set" is
; also much more efficient and is O(n), where n is the size of the first set.

; You would likely want to use this representation of sets if you were
; frequently adding elements to sets - since "adjoin-set" is much more
; efficient. However, with the likely decreased efficiency in "element-of-
; set?" and  "intersection-set" it would be undesiriable for mathematical
; applications where you are probably performing these operations frequently.
