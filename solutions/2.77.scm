; Exercise 2.77
; Author: Evan Ezell

; At each point we are stripping off the type tags and applying the generic
; procedure to the new object. This keeps calling apply-generic, because
; that is what is defined at each layer until we get to the rectangular
; magnitutde. Once we get here, the rectangular magnitude procedure is
; called on the actual datum, a pair (3 . 4).

; apply-generic is called twice. In the first case, we dispatch to the
; general procedure apply-generic. This strips the type tag 'complex
; and calls apply-generic again. At this point the type tag 'rectangular
; is stripped off and we call the magnitude procedure inside the rectangular
; package.
