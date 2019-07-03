; Exercise 2.66.scm
; Author: Evan Ezell

(define (lookup given-key set-of-records)
  (cond ((= given-key (key (entry set-of-records)))
         (entry set-of-records))
        ((< given-key (key (entry set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        ((> given-key (key (entry set-of-records)))
         (lookup given-key (right-branch set-of-records)))
        (else false)))
